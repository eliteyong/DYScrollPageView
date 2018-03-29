//
//  UIViewController+DYScrollPageController.h
//  DYScrollPageView
//
//  Created by admin on 2018/3/28.
//  Copyright © 2018年 YDY. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIViewController (DYScrollPageController)

/**
 *  所有子控制的父控制器, 方便在每个子控制页面直接获取到父控制器进行其他操作
 */
@property (nonatomic, weak, readonly) UIViewController *dy_scrollViewController;

/**
 当前vc的index
 */
@property (nonatomic, assign) NSInteger dy_currentIndex;

@end
