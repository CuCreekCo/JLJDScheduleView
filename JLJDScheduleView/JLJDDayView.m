/*
  Created by Jason Davidson on 9/11/13.
  Copyright (c) 2013 JLJDavidson, LLC. All rights reserved.

  A Day View encompasses a single day of resource (people, places, things)
  blocks.  A block is a time during said day that occupies time.
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
      UIColor *oddColor =
            [UIColor colorWithRed: 191.0/255.0
                  green: 239.0/255.0
                  blue:255.0 / 255.0 alpha: 1.0];
      UIColor *evenColor = [UIColor whiteColor];
      UIColor *bgColor;
      self.date = date;
      self.endDayHour = endDayHour;
      self.startDayHour = startDayHour;
      self.resourceList = resourceList;
      [self setDayTitleView:[[JLJDDayTitleView alloc]
            initWithStartHour:startDayHour
            endHour:endDayHour date:date]];
      [self addSubview:[self dayTitleView]];
      [[self dayTitleView] didMoveToSuperview];

      /* For each resource in the list draw a row in this day view */
      float resourceDayViewYPos = [[self dayTitleView] frame].size.height + 4;
      for (JLJDResource *resource in resourceList) {
         if (index % 2) {
            bgColor = oddColor;
         } else {
            bgColor = evenColor;
         }
         /* The resource day view is this resources block of events for this
            day. */
         JLJDResourceDayView *resourceDayView =
               [[JLJDResourceDayView alloc]
                     initWithFrame:CGRectMake(0, resourceDayViewYPos,
                           [[self dayTitleView]
                                 frame].size.width, kJLJDScheduleBlockHeight)
                     dayStartHour:[startDayHour intValue]
                     dayEndHour:[endDayHour intValue] date:date
                     andResource:resource];
         [resourceDayView setBackgroundColor:bgColor];
         [self addSubview:resourceDayView];
         [resourceDayView didMoveToSuperview];
         resourceDayViewYPos += kJLJDScheduleBlockHeight;
      }
      [self setBackgroundColor:bgColor];
      [[self dayTitleView] setBackgroundColor:bgColor];
      [[[self dayTitleView] dayLabel]
            setBackgroundColor:bgColor];

      [self setFrame:CGRectMake(index*[[self dayTitleView] frame].size.width,0,
            [[self dayTitleView] frame].size.width,
            resourceDayViewYPos)];
   }

   return self;
}

- (void)touchesBegan:(NSSet *)touches
           withEvent:(UIEvent *)event {
   NSLog(@"day view touches began");
   [super touchesBegan:touches withEvent:event];
}

- (void)touchesCancelled:(NSSet *)touches
               withEvent:(UIEvent *)event {
   [super touchesCancelled:touches withEvent:event];
}

- (void)touchesEnded:(NSSet *)touches
           withEvent:(UIEvent *)event {
   [super touchesEnded:touches withEvent:event];
}

- (void)touchesMoved:(NSSet *)touches
           withEvent:(UIEvent *)event {
   [super touchesMoved:touches withEvent:event];
}

@end