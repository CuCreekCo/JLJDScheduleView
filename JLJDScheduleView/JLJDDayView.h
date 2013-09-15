/*
  Created by Jason Davidson on 9/11/13.
  Copyright (c) 2013 JLJDavidson, LLC. All rights reserved.

  A Day View encompasses a single day of resource (people, places, things)
  blocks.  A block is a time during said day that occupies time.
*/


#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@class JLJDDayTitleView;
@class JLJDResourceDayView;


@interface JLJDDayView : UIView
@property (nonatomic, copy) NSDate *date; /* The day's date */
@property (nonatomic, copy) NSNumber *startDayHour; /*Day's start hour in
military time */
@property (nonatomic, copy) NSNumber *endDayHour; /*Day's end hour in
military time */
@property (nonatomic, copy) NSArray *resourceList; /*Array of resources that
may or may not have events on this day - the view will determine if they do and
display a block for the resources in that time */
@property (nonatomic, strong) JLJDDayTitleView *dayTitleView; /*The day view
title consisting of the long date and a row of blocks for each hour in the
day */

- (id)initWithDate:(NSDate *)date
        endDayHour:(NSNumber *)endDayHour
      startDayHour:(NSNumber *)startDayHour
      resourceList:(NSArray *)resourceList
 indexInParentView:(int)index;
@end