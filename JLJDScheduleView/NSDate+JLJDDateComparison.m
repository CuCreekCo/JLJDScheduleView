/*
  Created by Jason Davidson on 9/14/13.
  Copyright (c) 2013 JLJDavidson, LLC. All rights reserved.

  Date category for date stuff.

*/


#import "NSDate+JLJDDateComparison.h"


@implementation NSDate (JLJDDateComparison)

- (BOOL)isSameDayAsDate:(NSDate *)otherDate{
   NSCalendar *gregorian = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
   NSDateComponents *dateComponents =
         [gregorian components:(NSHourCalendarUnit |
               NSMinuteCalendarUnit | NSDayCalendarUnit |
               NSMonthCalendarUnit | NSYearCalendarUnit)
               fromDate:self];
   NSDateComponents *otherDateComponents =
         [gregorian components:(NSHourCalendarUnit |
               NSMinuteCalendarUnit | NSDayCalendarUnit |
               NSMonthCalendarUnit | NSYearCalendarUnit)
               fromDate:otherDate];

   return ([dateComponents day] == [otherDateComponents day] &&
         [dateComponents month] == [otherDateComponents month] &&
         [dateComponents year] == [otherDateComponents year]);
}
@end