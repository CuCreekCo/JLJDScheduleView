/*
  Created by Jason Davidson on 9/11/13.
  Copyright (c) 2013 JLJDavidson, LLC. All rights reserved.

   JLJDDayTitleView provides the title view for a schedule day view.

*/

#import "JLJDDayTitleView.h"
#import "JLJDResourceTimeBlockView.h"
#import "JWorksDataController.h"

float _labelHeight = 20.0;
float _hourOfDayHeight = 20.0;
float _hourOfDayWidth = 20.0;

@implementation JLJDDayTitleView
@synthesize dayLabel = _dayLabel;
@synthesize endHour = _endHour;
@synthesize hourBarView = _hourBarView;
@synthesize startHour = _startHour;

/*
Init with military time
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
            initWithFrame:CGRectMake(8, 4, _hourBarView.frame.size.width-8,
                  20)]];

      [[self dayLabel] setFont:[UIFont systemFontOfSize:14]];
      [[self dayLabel] setText:[JWorksDataController dateToString:[self date]
            withFormat:@"EEE, MMM d, yyyy"]];
      [self addSubview:[self dayLabel]];
      [self addSubview:_hourBarView];
      [_hourBarView didMoveToSuperview];
      [self setFrame:CGRectMake(0, 0, _hourBarView.frame.size.width,
            [self dayLabel].frame.size.height+_hourBarView.frame.size.height)];
   }
   return self;
}


- (UIView *)createHourBarView {

   UIView *returnView = [[UIView alloc] initWithFrame:CGRectMake(0, 24,
         (self.endHour.intValue - self.startHour.intValue)
               *_hourOfDayWidth,_hourOfDayHeight)];

   for (int i = self.startHour.intValue, j = 0; i < self.endHour.intValue;
        ++i,++j) {

      JLJDHourOfDayView *hourOfDayView = [[JLJDHourOfDayView alloc]
            initWithFrame:CGRectMake(j*kJLJDScheduleBlockWidthPerHour,0,
                  _hourOfDayHeight,
                  _hourOfDayWidth)];
      [returnView addSubview:hourOfDayView];
   }
   return returnView;

}

+ (id)viewWithStartHour:(NSNumber *)startHour
                endHour:(NSNumber *)endHour
                   date:(NSDate *)date {
   return [[self alloc] initWithStartHour:startHour endHour:endHour date:nil ];
}

#pragma mark Hour Of Day View Delegation
- (void)hourOfDayView:(JLJDHourOfDayView *)hourOfDayView
        didSelectHour:(NSNumber *)hour {
   //TODO implement me
   NSLog(@"hourOfDayView YAY, You Pressed It!");

}

@end