/*
  Created by Jason Davidson on 9/11/13.
  Copyright (c) 2013 JLJDavidson, LLC. All rights reserved.

  Hour of Day view to show the hour in question with delegation capabilities.
  The hour of day is used in the day view title hour block view.
*/


#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@protocol JLJDHourOfDayViewDelegate;

enum {
   JLJDScheduleViewHourOfDayNotSelected = 0,
   JLJDScheduleViewHourOfDaySelected
} typedef JLJDScheduleViewHourOfDaySelectionState;


@interface JLJDHourOfDayView : UIView
@property(nonatomic, weak) id <JLJDHourOfDayViewDelegate> delegate;
@property(nonatomic, copy) NSNumber *hourOfDay;
@property(nonatomic, assign) JLJDScheduleViewHourOfDaySelectionState selectionState;
@end

/*
   Delegate to handle touching an hour in the hour block
*/
@protocol JLJDHourOfDayViewDelegate <NSObject>
@optional
- (void)hourOfDayView:(JLJDHourOfDayView *)hourOfDayView
        didSelectHour:(NSNumber *)hour;
@end