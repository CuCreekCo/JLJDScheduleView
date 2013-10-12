/*
  Created by Jason Davidson on 9/11/13.
  Copyright (c) 2013 JLJDavidson, LLC. All rights reserved.

  A Day View encompasses a single day of resource (people, places, things)
  blocks.  A block is a time during said day that occupies time.
*/


#import <EventKit/EventKit.h>
#import "JLJDDayView.h"


@implementation JLJDDayView

- (id)initWithDate:(NSDate *)date
        endDayHour:(NSNumber *)endDayHour
      startDayHour:(NSNumber *)startDayHour
      resourceList:(NSArray *)resourceList
 indexInParentView:(int)index {
   NSLog(@"JLJDDayView initWithDate started");

   self = [super init];
   if (self) {
      UIColor *oddColor =
            [UIColor colorWithRed:191.0 / 255.0
                  green:239.0 / 255.0
                  blue:255.0 / 255.0 alpha:1.0];
      UIColor *evenColor = [UIColor whiteColor];
      UIColor *bgColor;
      self.date = date;
      self.endDayHour = endDayHour;
      self.startDayHour = startDayHour;
      self.resourceList = resourceList;
      JLJDDayTitleView *dayTitleView = [[JLJDDayTitleView alloc]
            initWithStartHour:startDayHour
            endHour:endDayHour date:date];
      [self setDayTitleView:dayTitleView];
      [dayTitleView setDelegate:self];
      [self addSubview:[self dayTitleView]];
      [[self dayTitleView] didMoveToSuperview];

      /* For each resource in the list draw a row in this day view */
      float resourceDayViewYPos = [[self dayTitleView] frame].size.height + 4;
      NSLog(@"JLJDDayView starting resource list iteration");
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
         [resourceDayView setDelegate:self];
         [self addSubview:resourceDayView];
         [resourceDayView didMoveToSuperview];
         resourceDayViewYPos += kJLJDScheduleBlockHeight;
      }
      NSLog(@"JLJDDayView done with resource list iteration");

      [self setBackgroundColor:bgColor];
      [[self dayTitleView] setBackgroundColor:bgColor];
      [[[self dayTitleView] dayLabel]
            setBackgroundColor:bgColor];

      [self setFrame:CGRectMake(index * [[self dayTitleView]
            frame].size.width, 0,
            [[self dayTitleView] frame].size.width,
            resourceDayViewYPos)];
   }
   NSLog(@"JLJDDayView initWithDate ended");

   return self;
}

#pragma mark Touching Stuff
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

#pragma mark Delegates from Resource Views
/*
   Delegate handler for the JLJDResourceDayView touches
 */
- (void)    resourceDayView:(JLJDResourceDayView *)resourceDayView
didSelectBlockStartDateTime:(NSDate *)startDate
                endDateTime:(NSDate *)endDate
                   resource:(JLJDResource *)resource
                  withEvent:(EKEvent *)event {
   NSLog(@"dayView handling touch of resource block");
   /* Handle resource day view block touch and push it up to my delegate */
   if ([self delegate] != nil) {
      if ([[self delegate] respondsToSelector:@selector
      (dayView:didSelectResourceBlock:forStartDateTime:endDateTime:withEvent:)]) {
         [[self delegate] dayView:self
               didSelectResourceBlock:resource
               forStartDateTime:startDate
               endDateTime:endDate
               withEvent:event];
      }
   }
}

/*
   Delegate handler for the JLJDDayTitleView hour block touches
*/
- (void)dayTitleView:(JLJDDayTitleView *)dayTitleView
       didSelectHour:(NSNumber *)hour
             forDate:(NSDate *)date {
   NSLog(@"dayView handling touch of hour and date");
   if ([self delegate] != nil) {
      if ([[self delegate] respondsToSelector:
            @selector(dayView:didSelectHour:forDate:)]) {
         [[self delegate] dayView:self
               didSelectHour:hour forDate:date];
      }
   }
}

- (void)clearSelectedHourColumn {
   [[self overlaySelectedHourView] removeFromSuperview];
   [self setOverlaySelectedHourView:nil];
}

- (void)highlightSelectedHourColumn:(NSNumber *)hour
                            minutes:(NSNumber *)minutes {
   NSLog(@"highlightSelectedHourColumn started");
   float fallsOnX;

   float hourFraction = [minutes floatValue] / 60;
   float hourPosition = ([hour intValue] - [[self startDayHour] intValue]) *
         kJLJDScheduleBlockWidthPerHour;
   float fractionalHourPosition =
         (kJLJDScheduleBlockWidthPerHour * hourFraction);
   fallsOnX = hourPosition + fractionalHourPosition;
   CGPoint pointInDay = CGPointMake(fallsOnX, 0.0);

   if (pointInDay.x >= 0 && pointInDay.y >= 0) {

      if ([self overlaySelectedHourView] == nil) {
         [self setOverlaySelectedHourView:[[UIView alloc]
               initWithFrame:CGRectMake(
                     pointInDay.x,
                     kJLJDScheduleBlockHeight + 4,
                     kJLJDScheduleBlockWidth, kJLJDScheduleBlockHeight * [[self
                           resourceList] count])]];
         [[self overlaySelectedHourView] setAlpha:0.4];
         [[self overlaySelectedHourView] setBackgroundColor:[UIColor
               redColor]];
         [self addSubview:[self overlaySelectedHourView]];
         [self bringSubviewToFront:[self overlaySelectedHourView]];
         [[self overlaySelectedHourView] didMoveToSuperview];
      } else {
         [[self overlaySelectedHourView] setFrame:CGRectMake(pointInDay.x,
               kJLJDScheduleBlockHeight + 4,
               kJLJDScheduleBlockWidth, kJLJDScheduleBlockHeight * [[self
                     resourceList] count])];
      }
      [self setNeedsDisplay];
   }
   NSLog(@"highlightSelectedHourColumn ended");

}
@end