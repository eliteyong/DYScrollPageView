//
//  UIViewController+DYScrollPageController.m
//  DYScrollPageView
//
//  Created by admin on 2018/3/28.
//  Copyright © 2018年 YDY. All rights reserved.
//

#import "UIViewController+DYScrollPageController.h"
#import "DYScrollPageViewDelegate.h"
#import <objc/runtime.h>

char DYIndexKey;

@implementation UIViewController (DYScrollPageController)

//找到他的父视图
- (UIViewController *)dy_scrollViewController {
    UIViewController *superController;
    while (superController) {
        if ([superController conformsToProtocol:@protocol(DYScrollPageViewChildViewControllerDelegate)]) {
            break;
        }
        superController = superController.parentViewController;
    }
    return superController;
}

/**
 利用runtime给category动态添加属性
 */
- (void)setDy_currentIndex:(NSInteger)dy_currentIndex {
    objc_setAssociatedObject(self, &DYIndexKey, [NSNumber numberWithInteger:dy_currentIndex], OBJC_ASSOCIATION_ASSIGN);
}
- (NSInteger)dy_currentIndex {
    return [objc_getAssociatedObject(self, &DYIndexKey) integerValue];
}

@end
