iOS Calendar Schedule View for iOS (iPad)
================

JLJDScheduleView is an iOS scheduling assistant view similar to Microsoft Outlook's scheduling assistant view.

It displays a table of resources (people, places, things) on the left and a 
horizontally scrollable day view on the right.  The day view shows the day title and columns of hours in the day.
When a resource has an event on the visible day, the event is blocked out:

![Schedule View iOS Widget](https://s3.amazonaws.com/jljdavidson/JLJDScheduleView/JLJDScheduleView.png "Schedule View iOS Widget")

The schedule view supports user touches on resource event blocks and the hour column header. It delegates these
actions to your view controller.

**This widget is alpha.  I'd love help improving it!**  It needs these improvements:
* Support vertical scrolling on the resource table
* Object reuse on the day view horizontal scrolling
* Automatically retrieve events as the day view is scolled beyond the initial start and end date bounds
* Get rid of the initWithFrame and use autolayout
* Testing, testing, testing, and testing!


How To Use
================
Link or copy the JLJDScheduleView code into your Xcode project.  

Declare the schedule view in your controller interface
------------------------------------------------------

    #import <Foundation/Foundation.h>
    #import "JLJDScheduleView.h"
    
    @class JLJDScheduleView;
    
    @interface MyScheduleViewController :
          UIViewController<JLJDScheduleViewDelegate>
    
    @property (nonatomic, strong) JLJDScheduleView *scheduleView;
    
    @end


Load the schedule view in your controller implementation
--------------------------------------------------------

    - (void)loadView {
       [super loadView];
    
      NSDate *docketDate = [[[JWorksDataController
             appDelegateJWorksDataController] jworksDocket] docketDate];
    
       /* Set up the JLJDScheduleView.  First, set the scrollable 
      schedule view's start and end date ranges.  Then add resources (person,
      places, things) to the view using a mock buildResourceScheduleList 
      method. */
    
      /* Set the start date to 2 days ago */
      NSDate *startDate = [docketDate
        dateByAddingTimeInterval:60 * 60 * 24 * -2];
      /* Set the end to date to 7 days in the future */
      NSDate *endDate = [docketDate
        dateByAddingTimeInterval:60 * 60 * 24 * 7];
     
      [self setScheduleView:[[JLJDScheduleView alloc]
           initScheduleViewStarting:startDate ending:endDate
           withResourceList:[self buildResourceScheduleList]
           withFrame:CGRectMake(0, 0, 701, 393)
           scrollToDate:docketDate]];
      [[self scheduleView] setDelegate:self];
      [self setView:[self scheduleView]];
    }

In your view controller implementation, implement the delegate methods.

    /*  
    
       Delegates - these are called when the hour in the JLJDScheduleView 
       is touched or a resource's event block is touched.
    
    */
    #pragma mark Schedule View Handlers
    - (void)scheduleView:(JLJDScheduleView *)scheduleView
           didSelectHour:(NSNumber *)hour
                 forDate:(NSDate *)date {
    
       //Do something with the date and hour touched on the schedule view
    
    }
    
    - (void)  scheduleView:(JLJDScheduleView *)scheduleView
    didSelectResourceBlock:(JLJDResource *)resource
                  forEvent:(EKEvent *)event {
    
       //Do something with the event block touched.
    }

And methods to scroll to a date or highlight an hour column on a specific date.

    /* 
    
       Example methods to scroll to a schedule view date
       and highlight a schedule view date and hour column.
    
    */
    - (void)scrollToDate:(NSDate *)scrollDate {
       [[self scheduleView] scrollToDate:scrollDate];
    }
    
    - (void)highlightScheduleForDateTime:(NSDate *)dateTime {
       [[self scheduleView] highlightScheduledForDate:dateTime];
    }
    

The following methods are used to create mock data.  They are used by the code listed above.
In real life, the schedule view would use a calendar store or web service to
retrieve the resources and their events.

    /*
    
       Mock data building methods.
    
       Build JLJDScheduleView resource list and their calendar events.  
    
       A resource (JLJDResource) is a person, place, or thing (e.g. projector).  
       Each resource has an array of events (EKEvent).  This method builds 
       a mock list of resources and random events for each resource.  In a real
       implementation, you'd get the resources and their events from some 
       calendar store, web service, et al.
    
    */
    - (NSArray *)buildResourceScheduleList{
    
       NSDate *todaysDate = [NSDate date];
       NSMutableArray *resourceArray = [[NSMutableArray alloc] init];
       
       [resourceArray addObject:[JLJDResource resourceWithEventArray:[self
             buildRandomEventsAroundDate:todaysDate]]
             resourceName:@"Fake Name" resourceType:@"Person" ];
       [resourceArray addObject:[JLJDResource resourceWithEventArray:[self
             buildRandomEventsAroundDate:todaysDate]]
             resourceName:@"Another Fake" resourceType:@"Person" ];
       [resourceArray addObject:[JLJDResource resourceWithEventArray:[self
             buildRandomEventsAroundDate:todaysDate]]
             resourceName:@"Fakey McFakenson" resourceType:@"Person" ]];
       return resourceArray;
    }
    
    /*
    
      Build random events around a date 
      Notice it uses the iOS Event Kit event store and EKEvent object
      as the event class.
    
      Again, this is a fake method to create numerous events around a given
      date - in a real system this would be retrieved from a calendar
      store or web service.
    
    */
    - (NSArray *)buildRandomEventsAroundDate:(NSDate *) date {
    
       EKEventStore *eventStore = [[EKEventStore alloc] init];
       NSMutableArray *returnArray = [[NSMutableArray alloc] init];
    
       for (int i = 0; i < 7; ++i) {
    
          int randomNumber = arc4random() % 10;
    
          NSDate *randomDate = [date dateByAddingTimeInterval:60 * 60 * 24 *
                ((i % 2) ? randomNumber * -1 : randomNumber)];
          NSCalendar *gregorian = [[NSCalendar alloc]
                initWithCalendarIdentifier:NSGregorianCalendar];
          NSDateComponents *startDateComponents =
                [gregorian components:(NSHourCalendarUnit |
                      NSMinuteCalendarUnit | NSDayCalendarUnit |
                      NSMonthCalendarUnit | NSYearCalendarUnit)
                      fromDate:randomDate];
    
          int randomStartHour = (arc4random() % 10) + 8;
          [startDateComponents setHour:randomStartHour];
          [startDateComponents setMinute:0];
          [startDateComponents setSecond:0];
    
          NSDateComponents *endDateComponents =
                [gregorian components:(NSHourCalendarUnit |
                      NSMinuteCalendarUnit | NSDayCalendarUnit |
                      NSMonthCalendarUnit | NSYearCalendarUnit)
                      fromDate:randomDate];
          [endDateComponents setHour:[startDateComponents hour] + 1];
    
          EKEvent *event = [EKEvent eventWithEventStore:eventStore];
          [event setTitle:@"Important Event"];
          [event setStartDate:[gregorian dateFromComponents:startDateComponents]];
          [event setEndDate:[gregorian dateFromComponents:endDateComponents]];
          [returnArray addObject:event];
       }
       return returnArray;
    }

Here's How it Looks in a Real App
----------------------------------
I used a modified version of the [excellent DSLCalendarView](https://github.com/PeteC/DSLCalendarView) for 
the calendar view on the left of the JLJDScheduleView.  The user can touch a date in the calendar view and
the schedule view will scroll to the date.  Vice versa, the user can touch an hour header in the schedule view day and
the calendar view will select the date.

![Schedule View](https://s3.amazonaws.com/jljdavidson/JLJDScheduleView/JLJDScheduleViewInUse.png "Schedule View")
