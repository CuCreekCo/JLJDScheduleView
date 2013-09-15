/*
  Created by Jason Davidson on 9/11/13.
  Copyright (c) 2013 JLJDavidson, LLC. All rights reserved.

   JLJDDayTitleView provides the title view for a schedule day view.

*/

#import "JLJDDayTitleView.h"
#import "JLJDResourceTimeBlockView.h"

@implementation JLJDDayTitleView
@synthesize dayLabel = _dayLabel;
@synthesize endHour = _endHour;
@synthesize hourBarView = _hourBarView;
@synthesize startHour = _startHour;

/*
   Init with military time day hour start and the day's date

 */
- (id)initWithStartHour:(NSNumber *)startHour
                endHour:(NSNumber *)endHour
                   date:(NSDate *)date {
   NSAssert(([endHour intValue] > [startHour intValue]), @"startHour[%@] must be before endHour[%@] ", startHour, endHour);

   self = [super init];
   if (self) {
      self.startHour = startHour;
      self.endHour = endHour;
      self.date = date;
      _hourBarView = [self createHourBarView];

      [self setDayLabel:[[UILabel alloc]
            initWithFrame:CGRectMake(8, 4, _hourBarView.frame.size.width - 8,
                  kJLJDScheduleBlockHeight / 2)]];

      [[self dayLabel] setFont:[UIFont boldSystemFontOfSize:14]];

      NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
      NSLocale *enUSPOSIXLocale = [[NSLocale alloc]
            initWithLocaleIdentifier:@"en_US_POSIX"];
      [dateFormatter setLocale:enUSPOSIXLocale];
      [dateFormatter setDateStyle:NSDateFormatterFullStyle];

      [[self dayLabel] setText:[dateFormatter stringFromDate:date]];
      [self addSubview:[self dayLabel]];
      [self addSubview:_hourBarView];
      [_hourBarView didMoveToSuperview];
      [self setFrame:CGRectMake(0, 0, _hourBarView.frame.size.width,
            [self dayLabel].frame.size.height + _hourBarView.frame.size.height)];
   }
   return self;
}


/*
   Creates the hour bar underneath the day's date label.  This bar is
   a horizontal row of time blocks from the day start hour thru the
   day end hour.
*/
- (UIView *)createHourBarView {

   UIView *returnView = [[UIView alloc] initWithFrame:CGRectMake(0, 24,
         (self.endHour.intValue - self.startHour.intValue)
               * kJLJDScheduleBlockWidth, kJLJDScheduleBlockHeight / 2)];

   for (int i = self.startHour.intValue, j = 0; i < self.endHour.intValue;
        ++i, ++j) {

      JLJDHourOfDayView *hourOfDayView = [[JLJDHourOfDayView alloc]
            initWithFrame:CGRectMake(j * kJLJDScheduleBlockWidthPerHour, 0,
                  kJLJDScheduleBlockWidth,
                  kJLJDScheduleBlockHeight / 2)];
      [hourOfDayView setHourOfDay:[NSNumber numberWithInt:i]];
      [returnView addSubview:hourOfDayView];
   }
   return returnView;

}

#pragma mark Hour Of Day View Delegation
/*
   Delegated method when an hour block in the hour bar view is touched
*/
- (void)hourOfDayView:(JLJDHourOfDayView *)hourOfDayView
        didSelectHour:(NSNumber *)hour {
   //TODO implement me
   NSLog(@"hourOfDayView YAY, You Pressed It!");

}

@end