/*
  Created by Jason Davidson on 9/11/13.
  Copyright (c) 2013 JLJDavidson, LLC. All rights reserved.

  Represents a resource whose schedule will be displayed.
  A resource can be a person, place, or object (ala projector, room)

*/


#import "JLJDResource.h"


@implementation JLJDResource

@synthesize resourceName = _resourceName;
@synthesize eventArray = _eventArray;
@synthesize resourceType = _resourceType;

- (id)initWithEventArray:(NSArray *)eventArray
            resourceName:(NSString *)resourceName
            resourceType:(NSString *)resourceType {
   self = [super init];
   if (self) {
      self.eventArray = eventArray;
      self.resourceName = resourceName;
   }

   return self;
}

+ (id)resourceWithEventArray:(NSArray *)eventArray
                resourceName:(NSString *)resourceName
                resourceType:(NSString *)resourceType {
   return [[self alloc] initWithEventArray:eventArray resourceName:resourceName
         resourceType:resourceType ];
}

@end