//
//  JLJDScheduleViewTests.m
//  JLJDScheduleViewTests
//
//  Created by Jason Davidson on 9/11/13.
//  Copyright (c) 2013 Jason Davidson. All rights reserved.
//

#import "JLJDScheduleViewTests.h"
#import "JLJDDayTitleView.h"

@implementation JLJDScheduleViewTests

- (void)setUp
{
    [super setUp];
    
    // Set-up code here.
}

- (void)tearDown
{
    // Tear-down code here.
    
    [super tearDown];
}

- (void)testTitleViewParameters
{
   JLJDDayTitleView *titleView = [[JLJDDayTitleView alloc]
         initWithStartHour:[NSNumber numberWithInt:10]
         endHour:[NSNumber numberWithInt:8] date:nil ];

}

@end
