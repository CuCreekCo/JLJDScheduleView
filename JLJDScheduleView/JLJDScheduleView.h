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
#import "JLJDDayView.h"

@class JLJDDayView;
@class JLJDResource;
@protocol JLJDScheduleViewDelegate;

@interface JLJDScheduleView : UIView<UITableViewDelegate,UITableViewDataSource,
      UIScrollViewDelegate, JLJDDayViewDelegate, JLJDDayTitleViewDelegate>
@property (nonatomic, weak) id<JLJDScheduleViewDelegate>delegate;
@property (nonatomic, strong) UITableView *resourceTableView; /* Table view
that displays the list of resources */
@property (nonatomic, strong) UIScrollView *scheduleScrollView; /* Scroll
view that contains X number of days on breaks the day down into hours.  Each
resource has a row of time blocks in this view. */
@property (nonatomic, weak, readonly) JLJDDayView *dayView; /* Handle to the day view
 */

@property (nonatomic, strong) UIToolbar *toolbarView; /* Toolbar above the
table view for event modifications */
@property (nonatomic, strong) NSDate *startDate; /* The date that starts the
days view */
@property (nonatomic, strong) NSDate *endDate; /* The ending date that ends
the days view */
@property (nonatomic, copy) NSDate *scrollToDateDate; /*Optional scroll to date
after load */
@property (nonatomic, strong) NSArray *resourceList;

/* List of resources to
include in the schedule view */

- (id)initScheduleViewStarting:(NSDate *)startDate
                        ending:(NSDate *)endDate
              withResourceList:(NSArray *)resourceList
                     withFrame:(CGRect)frame
                  scrollToDate:(NSDate *)scrollToDate;

- (JLJDDayView *)scrollToDate:(NSDate *)scrollDate;

- (void)highlightScheduledForDate:(NSDate *)scheduleDate;
@end

/*
   Delegate to handle touches on the components of the schedule view
      like title touch, day touch, block touch
*/
@protocol JLJDScheduleViewDelegate<NSObject>
@optional
- (void)scheduleView:(JLJDScheduleView *)scheduleView
      didSelectHour:(NSNumber *)hour
            forDate:(NSDate *)date;

- (void)scheduleView:(JLJDScheduleView *)scheduleView
         didSelectResourceBlock:(JLJDResource *)resource
            forEvent:(EKEvent *)event;
@end
