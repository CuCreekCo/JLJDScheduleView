/*
  Created by Jason Davidson on 9/11/13.
  Copyright (c) 2013 JLJDavidson, LLC. All rights reserved.

  A resource's day view show a row and all its blocked out time
  spots for the given day.
*/


#import <EventKit/EventKit.h>
#import "JLJDResourceDayView.h"
#import "JLJDResourceTimeBlockView.h"
#import "NSDate+JLJDDateComparison.h"

@implementation JLJDResourceDayView {

}

- (id)initWithFrame:(CGRect)frame
          dayStartHour:(int)start
            dayEndHour:(int)end
               date:(NSDate *)date
        andResource:(JLJDResource *)resource {
   NSAssert(end > start, @"start of day hour [%d] must be before end of day[%d]", start, end);
   self = [super initWithFrame:frame];

   if (self) {
      [self setResource:resource];
      for (EKEvent *event in [resource eventArray]) {
         CGPoint pointOnDayScale = [self pointInDayForEvent:event
               fallsOnDate:date forDayStart:start  dayEnd:end];
         if(pointOnDayScale.x>0.0 && pointOnDayScale.y>=0.0){
            JLJDResourceTimeBlockView *timeBlockView =
                  [[JLJDResourceTimeBlockView alloc]
                        initWithStartDate:[event startDate]
                        endDate:[event endDate] xPosition:pointOnDayScale.x
                        yPosition:pointOnDayScale.y];
            [self addSubview:timeBlockView];
            [timeBlockView didMoveToSuperview];
         }
      }
   }
   return self;
}

/*
Break the event date down and determine where it falls within the
day view coordinate system:
 +=======================+
 |  |  |  |  |  |  |  |  | <- These are the hours in the given day
 +=======================+
      ^###^  <- Event falls within this hour span (90 minute event).

      Return the X and Y where the event falls (Y is always 0)
 */
-(CGPoint)pointInDayForEvent:(EKEvent *)event fallsOnDate:(NSDate *)date
            forDayStart:(int)start dayEnd:(int)end
{
   int blocksInDayView = end - start + 1;
   NSCalendar *gregorian = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
   NSDateComponents *eventStartHourOfDayComponent =
         [gregorian components:(NSHourCalendarUnit |
               NSMinuteCalendarUnit | NSDayCalendarUnit |
               NSMonthCalendarUnit | NSYearCalendarUnit)
               fromDate:[event startDate]];

   float fallsOnX;

   if ([[event startDate] isSameDayAsDate:date ] ||
         [[event endDate] isSameDayAsDate:date]) {
      float hourFraction = (float)[eventStartHourOfDayComponent minute]/60;
      float hourPosition =(
            abs(blocksInDayView - [eventStartHourOfDayComponent hour]) *
                  kJLJDScheduleBlockWidthPerHour);
      float fractionalHourPosition =
            (kJLJDScheduleBlockWidthPerHour * hourFraction);
      fallsOnX = hourPosition + fractionalHourPosition;
      return CGPointMake(fallsOnX, 0.0);
   }
   return CGPointMake(-999.0, -999.0);
}

#pragma mark Drawing UI
- (void)drawRect:(CGRect)rect {
   CGContextRef context = UIGraphicsGetCurrentContext();

   CGContextSetLineWidth(context, 1.0);

   CGContextSaveGState(context);
   CGContextSetStrokeColorWithColor(context,
         [UIColor
               colorWithRed: 152.0/255.0
               green: 251.0/255.0
               blue:152.0 / 255.0 alpha: 1.0].CGColor);
   CGContextMoveToPoint(context, 0, 0);
   CGContextAddLineToPoint(context, 0, self.bounds.size.height);
   CGContextAddLineToPoint(context, self.bounds.size.width,
         self.bounds.size.height);
   CGContextAddLineToPoint(context, self.bounds.size.width, 0);
   CGContextStrokePath(context);
   CGContextRestoreGState(context);
}

#pragma mark Touches
- (void)touchesBegan:(NSSet *)touches
           withEvent:(UIEvent *)event {
   NSLog(@"Touches began");
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