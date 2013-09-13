/*
  Created by Jason Davidson on 9/11/13.
  Copyright (c) 2013 JLJDavidson, LLC. All rights reserved.

  Represents a resource whose schedule will be displayed.
  A resource can be a person, place, or object (ala projector, room)

*/


#import <Foundation/Foundation.h>


@interface JLJDResource : NSObject
@property (nonatomic, strong) NSString *resourceName;
@property (nonatomic, strong) NSArray *eventArray;
@end