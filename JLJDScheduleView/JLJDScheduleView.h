//
//  JLJDScheduleView.h
//  JLJDScheduleView
//
//  Created by Jason Davidson on 9/11/13.
//  Copyright (c) 2013 JLJDavidson, LLC. All rights reserved.
//
//  A schedule view displays a table of resources (people, places, things)
//  in a left hand table view and a scrollable day view for each of those
//  resources in a right panel.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface JLJDScheduleView : UIView<UITableViewDelegate,UITableViewDataSource,
      UIScrollViewDelegate>
@property (nonatomic, strong) UITableView *resourceTableView; /* Table view
that displays the list of resources */
@property (nonatomic, strong) UIScrollView *scheduleScrollView; /* Scroll
view that contains X number of days on breaks the day down into hours.  Each
resource has a row of time blocks in this view. */
@property (nonatomic, strong) UIToolbar *toolbarView; /* Toolbar above the
table view for event modifications */
@property (nonatomic, strong) NSDate *startDate; /* The date that starts the
days view */
@property (nonatomic, strong) NSDate *endDate; /* The ending date that ends
the days view */

@property (nonatomic, strong) NSArray *resourceList;

/* List of resources to
include in the schedule view */

- (id)initScheduleViewStarting:(NSDate *)startDate
                        ending:(NSDate *)endDate
              withResourceList:(NSArray *)resourceList
                     withFrame:(CGRect)frame;

- (void)scrollToDate:(NSDate *)scrollDate;
@end
