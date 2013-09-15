/*
  Created by Jason Davidson on 9/11/13.
  Copyright (c) 2013 JLJDavidson, LLC. All rights reserved.

  The resource time block displays a rectangle from the start date time
  through the end date time.  This rectangle is then added to the resource
  day view.

*/


#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@protocol JLJDResourceTimeBlockViewDelegate;
@class JLJDResource;
@class EKEvent;

/* Constants */
extern float const kJLJDScheduleBlockWidthPerHour;
extern float const kJLJDScheduleBlockHeight;
extern float const kJLJDScheduleBlockWidth;


@interface JLJDResourceTimeBlockView : UIView

@property (nonatomic, weak) id<JLJDResourceTimeBlockViewDelegate>delegate;
@property (nonatomic, strong) NSDate *startDateTime;
@property (nonatomic, strong) NSDate *endDateTime;
@property (nonatomic, strong) JLJDResource *resource;
@property (nonatomic, strong) EKEvent *event;

- (id)initWithStartDate:(NSDate *)start
                endDate:(NSDate *)end
              xPosition:(float)x
              yPosition:(float)y;
@end

/*
   Delegation to handle touching on a resources block
 */
@protocol JLJDResourceTimeBlockViewDelegate<NSObject>
@optional
- (void)resourceTimeBlockView:(JLJDResourceTimeBlockView *)timeBlockView
         didSelectTimeBlockStartDateTime:(NSDate *)startDateTime
                  endDateTime:(NSDate *)endDateTime
                     resource:(JLJDResource *)resource
                     withEvent:(EKEvent *)event;
@end