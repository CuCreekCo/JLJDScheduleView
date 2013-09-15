/*
  Created by Jason Davidson on 9/14/13.
  Copyright (c) 2013 JLJDavidson, LLC. All rights reserved.

  Adds methods for day comparisons.

*/


#import <Foundation/Foundation.h>

@interface NSDate (JLJDDateHelper)
- (BOOL)isSameDayAsDate:(NSDate *)otherDate;

- (int)hourOfDate;

- (int)minutesOfDate;

- (NSDate *)setHour:(NSNumber *)hour
         andMinutes:(NSNumber *)minutes;
@end