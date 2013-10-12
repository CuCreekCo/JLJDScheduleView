//
//  JLJDScheduleView.m
//  JLJDScheduleView
//
//  Created by Jason Davidson on 9/11/13.
//  Copyright (c) 2013 JLJDavidson, LLC. All rights reserved.
//
//  A schedule view displays a table of resources (people, places, things)
//  in a left hand table view and a scrollable day view for each of those
//  resources in a right panel.
//

#import "JLJDScheduleView.h"
#import "NSDate+JLJDDateHelper.h"

@implementation JLJDScheduleView {
   float _oneThirdsMyWidth;
   float _twoThirdsMyWidth;
}


@synthesize resourceTableView = _resourceTableView;
@synthesize scheduleScrollView = _scheduleScrollView;
@synthesize toolbarView = _toolbarView;


@synthesize resourceList = _resourceList;


- (id)initScheduleViewStarting:(NSDate *)startDate
                        ending:(NSDate *)endDate
              withResourceList:(NSArray *)resourceList
                     withFrame:(CGRect)frame
                  scrollToDate:(NSDate *)scrollToDate {
   NSLog(@"JLJDScheduleView initScheduleViewStarting started");

   self = [super initWithFrame:frame];
   if (self) {

      _oneThirdsMyWidth = [self frame].size.width / 3;
      _twoThirdsMyWidth = [self frame].size.width - _oneThirdsMyWidth;

      [self setStartDate:[startDate copy]];
      [self setEndDate:[endDate copy]];
      [self setScrollToDateDate:scrollToDate];

      [self setResourceList:resourceList];
      [self initializeTableView];
      [self initializeToolbar];
      [self initializeScheduleView];
   }
   NSLog(@"JLJDScheduleView initScheduleViewStarting ended");

   return self;
}


- (void)initializeTableView {
   [self setResourceTableView:[[UITableView alloc]
         initWithFrame:CGRectMake(0, 44,
               _oneThirdsMyWidth,
               [self frame].size.height) style:UITableViewStylePlain]];
   [[self resourceTableView] setDelegate:self];
   [[self resourceTableView] setRowHeight:kJLJDScheduleBlockHeight];
   [[self resourceTableView] setScrollEnabled:NO];
   [[self resourceTableView] setDataSource:self];
   [self addSubview:[self resourceTableView]];
   [[self resourceTableView] didMoveToSuperview];
}

- (void)initializeToolbar {
   [self setToolbarView:[[UIToolbar alloc] initWithFrame:CGRectMake(0, 0,
         _oneThirdsMyWidth,
         kJLJDScheduleBlockHeight + 4)]];
   [[self toolbarView] setBarStyle:UIBarStyleDefault];
   UIBarButtonItem *actionButton = [[UIBarButtonItem alloc]
         initWithBarButtonSystemItem:UIBarButtonSystemItemAction
         target:self action:@selector(toolbarActionButtonAction)];
   [actionButton setTintColor:[UIColor orangeColor]];
   [[self toolbarView] setItems:@[actionButton]];
   [self addSubview:[self toolbarView]];
   [[self toolbarView] didMoveToSuperview];
}

- (void)initializeScheduleView {
   NSLog(@"JLJDScheduleView initializeScheduleView started.");

   [self setScheduleScrollView:
         [[UIScrollView alloc] initWithFrame:CGRectMake(_oneThirdsMyWidth + 1,
               0,
               _twoThirdsMyWidth,
               [self frame].size.height)]];

   //TODO this needs to be in a loop to add all the day views...
   /* get the days between the start date and end date for our loop */
   // add loading indicator
   UIActivityIndicatorView *indicator = [[UIActivityIndicatorView alloc]
         initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
   [indicator setCenter:[self scheduleScrollView].center];
   [indicator startAnimating];
   [self addSubview:indicator];

   dispatch_async(dispatch_get_main_queue(), ^{
      NSDate *dayViewDate = [[self startDate] copy];
      int i = 0;
      float dayViewWidthSum = 0.0;

      while ([dayViewDate compare:[self endDate]] != NSOrderedDescending) {
         //TODO unhardcode the end and start
         JLJDDayView *dayView =
               [[JLJDDayView alloc] initWithDate:dayViewDate
                     endDayHour:[NSNumber numberWithInt:18]
                     startDayHour:[NSNumber numberWithInt:8]
                     resourceList:[self resourceList]
                     indexInParentView:i++];
         [dayView setDelegate:self];
         [[self scheduleScrollView] addSubview:dayView];
         [dayView didMoveToSuperview];
         dayViewWidthSum += dayView.frame.size.width;
         dayViewDate = [dayViewDate dateByAddingTimeInterval:60 * 60 * 24];
      }
      NSLog(@"JLJDScheduleView done with day view. ScheduleScrollView subview started.");

      [[self scheduleScrollView] setContentSize:CGSizeMake(dayViewWidthSum,
            [self frame].size.height)];

      [self addSubview:[self scheduleScrollView]];
      [[self scheduleScrollView] didMoveToSuperview];
      if ([self scrollToDateDate] != nil) {
         [self highlightScheduledForDate:[self scrollToDateDate]];
      }
      NSLog(@"JLJDScheduleView done with day view. ScheduleScrollView subview ended.");

      [indicator stopAnimating];

   });
   NSLog(@"JLJDScheduleView initializeScheduleView ended.");

}

#pragma mark TableView
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
   return 1;
}

- (NSInteger)tableView:(UITableView *)tableView
 numberOfRowsInSection:(NSInteger)section {
   return [[self resourceList] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath {
   UITableViewCell *tableViewCell = [[UITableViewCell alloc]
         initWithStyle:UITableViewCellStyleSubtitle
         reuseIdentifier:@"PARTY_CELL"];
   JLJDResource *resource = [[self resourceList]
         objectAtIndex:[indexPath row]];

   [[tableViewCell textLabel] setText:[resource resourceName]];
   [[tableViewCell detailTextLabel] setText:[resource resourceType]];
   return tableViewCell;

}


#pragma mark Toolbar Handlers
- (void)toolbarActionButtonAction {
   NSLog(@"toolbarActionButtonAction pressed");
}

#pragma mark Date and Block
- (JLJDDayView *)scrollToDate:(NSDate *)scrollDate {

   NSLog(@"JLJDScheduleView scrollToDate started.");

   float dayViewSum = 0.0;
   for (JLJDDayView *dayView in [[self scheduleScrollView] subviews]) {
      if ([dayView isKindOfClass:[JLJDDayView class]]) {
         if ([scrollDate isSameDayAsDate:[dayView date]]) {
            [[self scheduleScrollView]
                  setContentOffset:CGPointMake(dayViewSum, 0.0)
                  animated:YES];
            [dayView setDate:scrollDate];

            NSLog(@"JLJDScheduleView scrollToDate ended.");

            return dayView;
         }
         dayViewSum += [dayView bounds].size.width;
      }
   }
   [[self scheduleScrollView]
         setContentOffset:CGPointMake(0.0, 0.0)
         animated:YES];
   NSLog(@"JLJDScheduleView scrollToDate ended.");

   return nil;
}

#pragma Delegate Handlers
/*
   Handle Day View touching delegation
 */
- (void)dayView:(JLJDDayView *)dayView
  didSelectHour:(NSNumber *)hour
        forDate:(NSDate *)date {
   NSLog(@"gotcha in the day view touching an hour");
   if ([self delegate] != nil) {
      if ([[self delegate] respondsToSelector:@selector
      (scheduleView:didSelectHour:forDate:)]) {
         [[self delegate] scheduleView:self
               didSelectHour:hour forDate:date];
      }
   }
}

- (void)       dayView:(JLJDDayView *)dayView
didSelectResourceBlock:(JLJDResource *)resource
      forStartDateTime:(NSDate *)startDate
           endDateTime:(NSDate *)endDate
             withEvent:(EKEvent *)event {
   NSLog(@"gotcha in the day touching a resource block");
   if ([self delegate] != nil) {
      if ([[self delegate] respondsToSelector:@selector(
            scheduleView:didSelectResourceBlock:forEvent:)]) {
         [[self delegate] scheduleView:self
               didSelectResourceBlock:resource
               forEvent:event];
      }
   }
}

/*
For a given date, draw a big rectangle in the day view
 */
- (void)highlightScheduledForDate:(NSDate *)scheduleDate {
   NSLog(@"JLJDScheduleView highlightScheduledForDate started.");

   for (JLJDDayView *dayView in [[self scheduleScrollView] subviews]) {
      if ([dayView isKindOfClass:[JLJDDayView class]]) {
         [dayView clearSelectedHourColumn];
      }
   }
   JLJDDayView *dayView = [self scrollToDate:scheduleDate];
   [dayView highlightSelectedHourColumn:[NSNumber numberWithInt:
         [scheduleDate hourOfDate]]
         minutes:[NSNumber numberWithInt:[scheduleDate minutesOfDate]]];
   NSLog(@"JLJDScheduleView highlightScheduledForDate ended.");

}
@end
