//
//  DYPageTableViewController.h
//  DYScrollPageView
//
//  Created by admin on 2018/4/2.
//  Copyright © 2018年 YDY. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DYPageViewController.h"
#import "DYScrollPageViewDelegate.h"

@interface DYPageTableViewController : DYPageViewController <DYScrollPageViewChildViewControllerDelegate>

/**
 数据源
 */
@property (nonatomic, strong) NSArray *data;

@end
