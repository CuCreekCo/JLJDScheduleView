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
#import "JLJDDayView.h"
#import "JLJDResourceTimeBlockView.h"
#import "NSDate+JLJDDateComparison.h"

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
                     withFrame:(CGRect)frame {
   self = [super init];
   if (self) {
      [self setFrame:frame];

      _oneThirdsMyWidth = [self frame].size.width / 3;
      _twoThirdsMyWidth = [self frame].size.width - _oneThirdsMyWidth;

      [self setStartDate:[startDate copy]];
      [self setEndDate:[endDate copy]];
      [self setResourceList:resourceList];
      [self initializeTableView];
      [self initializeToolbar];
      [self initializeScheduleView];
   }
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
         kJLJDScheduleBlockHeight+4)]];
   [[self toolbarView] setBarStyle:UIBarStyleBlackTranslucent];
   UIBarButtonItem *actionButton = [[UIBarButtonItem alloc]
         initWithBarButtonSystemItem:UIBarButtonSystemItemAction
         target:self action:@selector(toolbarActionButtonAction)];
   [[self toolbarView] setItems:@[actionButton]];
   [self addSubview:[self toolbarView]];
   [[self toolbarView] didMoveToSuperview];
}

- (void)initializeScheduleView {
   [self setScheduleScrollView:
         [[UIScrollView alloc] initWithFrame:CGRectMake(_oneThirdsMyWidth+1,
               0,
               _twoThirdsMyWidth,
               [self frame].size.height)]];
   
   //TODO this needs to be in a loop to add all the day views...
   /* get the days between the start date and end date for our loop */
   NSDate *dayViewDate = [[self startDate] copy];
   int i=0;
   float dayViewWidthSum = 0.0;

   while([dayViewDate compare:[self endDate]]!=NSOrderedDescending){
      //TODO unhardcode the end and start
      JLJDDayView *dayView =
            [[JLJDDayView alloc] initWithDate:dayViewDate
                  endDayHour:[NSNumber numberWithInt:18]
                  startDayHour:[NSNumber numberWithInt:8]
                  resourceList:[self resourceList]
                  indexInParentView:i++];

      [[self scheduleScrollView] addSubview:dayView];
      [dayView didMoveToSuperview];
      dayViewWidthSum+=dayView.frame.size.width;
      dayViewDate = [dayViewDate dateByAddingTimeInterval:60*60*24];

   }
   [[self scheduleScrollView] setContentSize:CGSizeMake(dayViewWidthSum,
         [self frame].size.height)];
   [self addSubview:[self scheduleScrollView]];
   [[self scheduleScrollView] didMoveToSuperview];
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
   [[tableViewCell textLabel] setText:@"Joe Mama"];
   [[tableViewCell detailTextLabel] setText:@"Officer"];
   return tableViewCell;

}


#pragma mark Toolbar Handlers
-(void)toolbarActionButtonAction {
   NSLog(@"toolbarActionButtonAction pressed");
}

#pragma mark Date and Block
-(void)scrollToDate:(NSDate *)scrollDate{

   float dayViewSum = 0.0;
   BOOL scrolledToDate = NO;
   for(JLJDDayView *dayView in [[self scheduleScrollView] subviews]) {
      if([dayView isKindOfClass:[JLJDDayView class]]){
         if ([scrollDate isSameDayAsDate:[dayView date]]) {
            [[self scheduleScrollView]
                  setContentOffset:CGPointMake(dayViewSum, 0.0)
                  animated:YES];
            scrolledToDate = YES;
            break;
         }
         dayViewSum+=[dayView bounds].size.width;
      }
   }
   if (!scrolledToDate) {
      [[self scheduleScrollView]
               setContentOffset:CGPointMake(0.0, 0.0)
               animated:YES];
   }
}

/*
For a given date, draw a big rectangle in the day view
 */
-(void)highlightScheduledForDate:(NSDate *)scheduleDate{
   //TODO finish me - draw a rectangle on the page for the given date time like
   //outlook calendars...

}
@end
