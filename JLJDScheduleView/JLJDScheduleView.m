//
//  JLJDScheduleView.m
//  JLJDScheduleView
//
//  Created by Jason Davidson on 9/11/13.
//  Copyright (c) 2013 JLJDavidson, LLC. All rights reserved.
//

#import "JLJDScheduleView.h"
#import "JLJDDayView.h"

@implementation JLJDScheduleView

@synthesize resourceTableView = _resourceTableView;
@synthesize scheduleScrollView = _scheduleScrollView;
@synthesize toolbarView = _toolbarView;


@synthesize resourceList = _resourceList;


- (id)initScheduleViewStarting:(NSDate *)startDate
                        ending:(NSDate *)endDate
              withResourceList:(NSArray *)resourceList {
   self = [super init];
   if (self) {
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
         initWithFrame:CGRectMake(0, 44, 100, 307) style:UITableViewStylePlain]];
   [[self resourceTableView] setDelegate:self];
   [[self resourceTableView] setRowHeight:20.0];
   [[self resourceTableView] setScrollEnabled:NO];
   [[self resourceTableView] setDataSource:self];
   [self addSubview:[self resourceTableView]];
   [[self resourceTableView] didMoveToSuperview];
}
- (void)initializeToolbar {
   [self setToolbarView:[[UIToolbar alloc] initWithFrame:CGRectMake(0, 0, 100, 44)]];
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
         [[UIScrollView alloc] initWithFrame:CGRectMake(101, 0, 700, 351)]];
   
   //TODO this needs to be in a loop to add all the day views...
   /* get the days between the start date and end date for our loop */
   NSDate *dayViewDate = [[self startDate] copy];
   int i=0;
   float dayViewWidthSum = 0.0;

   while([dayViewDate compare:[self endDate]]!=NSOrderedDescending){
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
         160.0)];
   [self addSubview:[self scheduleScrollView]];
   [[self scheduleScrollView] didMoveToSuperview];
}

#pragma mark TableView
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
   return 1;
}

- (NSInteger)tableView:(UITableView *)tableView
 numberOfRowsInSection:(NSInteger)section {
   return 3;
}

- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath {
   UITableViewCell *tableViewCell = [[UITableViewCell alloc]
         initWithStyle:UITableViewCellStyleDefault
         reuseIdentifier:@"PARTY_CELL"];
   [[tableViewCell textLabel] setText:@"Joe Mama"];
   return tableViewCell;

}


#pragma mark Toolbar Handlers
-(void)toolbarActionButtonAction {
   NSLog(@"toolbarActionButtonAction pressed");
}
@end
