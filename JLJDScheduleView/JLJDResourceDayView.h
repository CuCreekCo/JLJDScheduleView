/*
  Created by Jason Davidson on 9/11/13.
  Copyright (c) 2013 JLJDavidson, LLC. All rights reserved.

  A resource's day view show a row and all its blocked out time
  spots for the given day.
*/


#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "JLJDResource.h"
#import "JLJDResourceTimeBlockView.h"

@protocol JLJDResourceDayViewDelegate;
@class EKEvent;

@interface JLJDResourceDayView : UIView <JLJDResourceTimeBlockViewDelegate>
@property(nonatomic, strong) JLJDResource *resource;
@property(nonatomic, weak) id <JLJDResourceDayViewDelegate> delegate;

- (id)initWithFrame:(CGRect)frame
       dayStartHour:(int)start
         dayEndHour:(int)end
               date:(NSDate *)date
        andResource:(JLJDResource *)resource;

+ (CGPoint)pointInDayWithStartDateTime:(NSDate *)startTime
                           fallsOnDate:(NSDate *)date
                           forDayStart:(int)start
                                dayEnd:(int)end;
@end

/*
   Day title view delegate that will detect touch events title bar.
*/
@protocol JLJDResourceDayViewDelegate <NSObject>
@optional
- (void)    resourceDayView:(JLJDResourceDayView *)resourceDayView
didSelectBlockStartDateTime:(NSDate *)startDate
                endDateTime:(NSDate *)endDate
                   resource:(JLJDResource *)resource
                  withEvent:(EKEvent *)event;

@end