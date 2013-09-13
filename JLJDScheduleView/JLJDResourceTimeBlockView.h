/*
  Created by Jason Davidson on 9/11/13.
  Copyright (c) 2013 JLJDavidson, LLC. All rights reserved.

  To change the template use AppCode | Preferences | File Templates.

*/


#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@protocol JLJDResourceTimeBlockViewDelegate;

/* Constants */
extern float const kJLJDScheduleBlockWidthPerHour;

@interface JLJDResourceTimeBlockView : UIView

@property (nonatomic, weak) id<JLJDResourceTimeBlockViewDelegate>delegate;
@property (nonatomic, strong) NSDate *startDateTime;
@property (nonatomic, strong) NSDate *endDateTime;

- (id)initWithStartDate:(NSDate *)start
                endDate:(NSDate *)end
              xPosition:(float)x
              yPosition:(float)y;
@end

@protocol JLJDResourceTimeBlockViewDelegate<NSObject>
@optional
- (void)resourceTimeBlockView:(JLJDResourceTimeBlockView *)timeBlockView
         didSelectTimeBlockStartDateTime:(NSDate *)startDateTime
                  endDateTime:(NSDate *)endDateTime;
@end