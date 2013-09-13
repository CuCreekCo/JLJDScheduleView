/*
  Created by Jason Davidson on 9/11/13.
  Copyright (c) 2013 JLJDavidson, LLC. All rights reserved.

  To change the template use AppCode | Preferences | File Templates.

*/


#import "JLJDHourOfDayView.h"


@implementation JLJDHourOfDayView {

}

- (id)initWithFrame:(CGRect)frame {
   self = [super initWithFrame:frame];
   if (self != nil) {
      self.backgroundColor = [UIColor whiteColor];
   }
   return self;
}


#pragma mark Properties

- (void)setSelectionState:(JLJDScheduleViewHourOfDaySelectionState)selectionState {
   _selectionState = selectionState;
   [self setNeedsDisplay];
}

#pragma mark UIView methods

- (void)drawRect:(CGRect)rect {
   if ([self isMemberOfClass:[JLJDHourOfDayView class]]) {
      // If this isn't a subclass use the default drawing
      [self drawBackground];
      [self drawBorders];
      [self drawDayNumber];
   }
}


#pragma mark Drawing

- (void)drawBackground {
   if (self.selectionState == JLJDScheduleViewHourOfDayNotSelected) {
      [[UIColor colorWithWhite:225.0 / 255.0 alpha:1.0] setFill];
      UIRectFill(self.bounds);
   }
   else {
      switch (self.selectionState) {
         case JLJDScheduleViewHourOfDaySelected:
            [[UIColor greenColor] setFill];
            UIRectFill(self.bounds);
            break;
         case JLJDScheduleViewHourOfDayNotSelected:
            break;
      }
   }
}

- (void)drawBorders {
   CGContextRef context = UIGraphicsGetCurrentContext();

   CGContextSetLineWidth(context, 1.0);

   CGContextSaveGState(context);
   CGContextSetStrokeColorWithColor(context, [UIColor colorWithWhite:255.0 / 255.0
         alpha:1.0].CGColor);
   CGContextMoveToPoint(context, 0.5, self.bounds.size.height - 0.5);
   CGContextAddLineToPoint(context, 0.5, 0.5);
   CGContextAddLineToPoint(context, self.bounds.size.width - 0.5, 0.5);
   CGContextStrokePath(context);
   CGContextRestoreGState(context);

   CGContextSaveGState(context);
   CGContextSetStrokeColorWithColor(context, [UIColor colorWithWhite:185.0 / 255.0
         alpha:1.0].CGColor);
   CGContextMoveToPoint(context, self.bounds.size.width - 0.5, 0.0);
   CGContextAddLineToPoint(context, self.bounds.size.width - 0.5, self.bounds.size.height - 0.5);
   CGContextAddLineToPoint(context, 0.0, self.bounds.size.height - 0.5);
   CGContextStrokePath(context);
   CGContextRestoreGState(context);
}

- (void)drawDayNumber {
   if (self.selectionState == JLJDScheduleViewHourOfDayNotSelected) {
      [[UIColor colorWithWhite:66.0 / 255.0 alpha:1.0] set];
   }
   else {
      [[UIColor whiteColor] set];
   }

   UIFont *textFont = [UIFont boldSystemFontOfSize:17.0];
   CGSize textSize = [[_hourOfDay stringValue] sizeWithFont:textFont];

   CGRect textRect = CGRectMake(ceilf(CGRectGetMidX(self.bounds) - (textSize.width / 2.0)), ceilf(CGRectGetMidY(self.bounds) - (textSize.height / 2.0)), textSize.width, textSize.height);
   [[_hourOfDay stringValue] drawInRect:textRect withFont:textFont];
}

- (void)touchesBegan:(NSSet *)touches
           withEvent:(UIEvent *)event {
   if ([event type] == UIEventTypeTouches) {
      if ([[self delegate] respondsToSelector:@selector
      (hourOfDayView:didSelectHour:)]) {
         [[self delegate] hourOfDayView:self
               didSelectHour:[self hourOfDay]];
      }
   }
}

- (void)touchesMoved:(NSSet *)touches
           withEvent:(UIEvent *)event {
   [super touchesMoved:touches withEvent:event];
}

- (void)touchesEnded:(NSSet *)touches
           withEvent:(UIEvent *)event {
   [super touchesEnded:touches withEvent:event];
}

- (void)touchesCancelled:(NSSet *)touches
               withEvent:(UIEvent *)event {
   [super touchesCancelled:touches withEvent:event];
}


@end