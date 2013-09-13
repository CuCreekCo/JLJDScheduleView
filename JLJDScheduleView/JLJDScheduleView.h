//
//  JLJDScheduleView.h
//  JLJDScheduleView
//
//  Created by Jason Davidson on 9/11/13.
//  Copyright (c) 2013 JLJDavidson, LLC. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface JLJDScheduleView : UIView<UITableViewDelegate,UITableViewDataSource,
      UIScrollViewDelegate>
@property (nonatomic, strong) UITableView *resourceTableView;
@property (nonatomic, strong) UIScrollView *scheduleScrollView;
@property (nonatomic, strong) UIToolbar *toolbarView;
@property (nonatomic, strong) NSDate *startDate;
@property (nonatomic, strong) NSDate *endDate;

@property (nonatomic, strong) NSArray *resourceList;

- (id)initScheduleViewStarting:(NSDate *)startDate
                        ending:(NSDate *)endDate
              withResourceList:(NSArray *)resourceList;
@end
