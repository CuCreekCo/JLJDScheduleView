/*
  Created by Jason Davidson on 9/11/13.
  Copyright (c) 2013 JLJDavidson, LLC. All rights reserved.

  To change the template use AppCode | Preferences | File Templates.

*/


#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@class JLJDDayTitleView;
@class JLJDResourceDayView;


@interface JLJDDayView : UIView
@property (nonatomic, copy) NSDate *date;
@property (nonatomic, copy) NSNumber *startDayHour;
@property (nonatomic, copy) NSNumber *endDayHour;
@property (nonatomic, copy) NSArray *resourceList;
@property (nonatomic, strong) JLJDDayTitleView *dayTitleView;


- (id)initWithDate:(NSDate *)date
        endDayHour:(NSNumber *)endDayHour
      startDayHour:(NSNumber *)startDayHour
      resourceList:(NSArray *)resourceList
 indexInParentView:(int)index;

+ (id)viewWithDate:(NSDate *)date
        endDayHour:(NSNumber *)endDayHour
      startDayHour:(NSNumber *)startDayHour
      resourceList:(NSArray *)resourceList;

@end