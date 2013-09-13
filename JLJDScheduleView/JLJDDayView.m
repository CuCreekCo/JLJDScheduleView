/*
  Created by Jason Davidson on 9/11/13.
  Copyright (c) 2013 JLJDavidson, LLC. All rights reserved.

  To change the template use AppCode | Preferences | File Templates.

*/


#import "JLJDDayView.h"
#import "JLJDDayTitleView.h"
#import "JLJDResourceDayView.h"
#import "JLJDResourceTimeBlockView.h"


@implementation JLJDDayView

- (id)initWithDate:(NSDate *)date
        endDayHour:(NSNumber *)endDayHour
      startDayHour:(NSNumber *)startDayHour
      resourceList:(NSArray *)resourceList
 indexInParentView:(int)index {
   self = [super init];
   if (self) {
      self.date = date;
      self.endDayHour = endDayHour;
      self.startDayHour = startDayHour;
      self.resourceList = resourceList;
      [self setDayTitleView:[[JLJDDayTitleView alloc]
            initWithStartHour:startDayHour
            endHour:endDayHour date:date]];
      [self addSubview:[self dayTitleView]];
      [[self dayTitleView] didMoveToSuperview];

      float resourceDayViewYPos = [[self dayTitleView] frame].size.height + 4;
      for (JLJDResource *resource in resourceList) {
         JLJDResourceDayView *resourceDayView =
               [[JLJDResourceDayView alloc]
                     initWithFrame:CGRectMake(0, resourceDayViewYPos,
                           [[self dayTitleView] frame].size.width, 20)
                     dayStartHour:[startDayHour intValue]
                     dayEndHour:[endDayHour intValue] date:date
                     andResource:resource];
         if (index % 2) {
            [resourceDayView setBackgroundColor:[UIColor lightGrayColor]];
         }
         [self addSubview:resourceDayView];
         [self bringSubviewToFront:resourceDayView];
         [resourceDayView didMoveToSuperview];
         resourceDayViewYPos+=20.0;
      }
      if (index % 2) {
         [self setBackgroundColor:[UIColor lightGrayColor]];
         [[self dayTitleView] setBackgroundColor:[UIColor lightGrayColor]];
         [[[self dayTitleView] dayLabel]
               setBackgroundColor:[UIColor lightGrayColor]];
      }
      [self setFrame:CGRectMake(index*[[self dayTitleView] frame].size.width,0,
            [[self dayTitleView] frame].size.width,20)];
   }

   return self;
}

+ (id)viewWithDate:(NSDate *)date
        endDayHour:(NSNumber *)endDayHour
      startDayHour:(NSNumber *)startDayHour
      resourceList:(NSArray *)resourceList {
   return [[self alloc]
         initWithDate:date endDayHour:endDayHour startDayHour:startDayHour
         resourceList:resourceList
         indexInParentView:0];
}

@end