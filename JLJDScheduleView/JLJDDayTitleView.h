/*
  Created by Jason Davidson on 9/11/13.
  Copyright (c) 2013 JLJDavidson, LLC. All rights reserved.

  To change the template use AppCode | Preferences | File Templates.

*/


#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "JLJDHourOfDayView.h"


@interface JLJDDayTitleView : UIView <JLJDHourOfDayViewDelegate>

@property (nonatomic, copy) NSDate *date;
@property (nonatomic, strong) UILabel *dayLabel;
@property (nonatomic, strong) UIView *hourBarView;
@property (nonatomic, strong) NSNumber *startHour;
@property (nonatomic, strong) NSNumber *endHour;

- (id)initWithStartHour:(NSNumber *)startHour
                endHour:(NSNumber *)endHour
                   date:(NSDate *)date;

+ (id)viewWithStartHour:(NSNumber *)startHour
                endHour:(NSNumber *)endHour
                   date:(NSDate *)date;

@end

@protocol JLJDDayTitleViewDelegate
@optional
- (void)dayTitleViewDidSelectHour:(NSNumber *)hour;

@end