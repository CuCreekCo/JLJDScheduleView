/*
  Created by Jason Davidson on 9/11/13.
  Copyright (c) 2013 JLJDavidson, LLC. All rights reserved.

  A resource's day view show a row and all its blocked out time
  spots for the given day.
*/


#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "JLJDResource.h"

@interface JLJDResourceDayView : UIView
@property (nonatomic, strong) JLJDResource *resource;

- (id)initWithFrame:(CGRect)frame
       dayStartHour:(int)start
         dayEndHour:(int)end
               date:(NSDate *)date
        andResource:(JLJDResource *)resource;
@end