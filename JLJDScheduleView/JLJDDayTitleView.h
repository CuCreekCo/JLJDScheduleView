/*
  Created by Jason Davidson on 9/11/13.
  Copyright (c) 2013 JLJDavidson, LLC. All rights reserved.

  A Day Title consists of day's date  in long form with the
  an hour block for the number of hours between the start hour and the end
  hour.

*/


#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "JLJDHourOfDayView.h"


@interface JLJDDayTitleView : UIView <JLJDHourOfDayViewDelegate>

@property (nonatomic, copy) NSDate *date; /* Date of the day */
@property (nonatomic, strong) UILabel *dayLabel; /* The label used to show
the day's date in long format */
@property (nonatomic, strong) UIView *hourBarView; /* Hour Bar view under the
 day's date label */
@property (nonatomic, strong) NSNumber *startHour; /* The day's start hour in
 military time */
@property (nonatomic, strong) NSNumber *endHour; /* The day's end hour in
military time */

- (id)initWithStartHour:(NSNumber *)startHour
                endHour:(NSNumber *)endHour
                   date:(NSDate *)date;

@end

/*
   Day title view delegate that will detect touch events title bar.
*/
@protocol JLJDDayTitleViewDelegate
@optional
- (void)dayTitleViewDidSelectHour:(NSNumber *)hour;

@end