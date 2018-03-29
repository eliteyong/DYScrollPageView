//
//  DYCollectionView.m
//  DYScrollPageView
//
//  Created by admin on 2018/3/28.
//  Copyright © 2018年 YDY. All rights reserved.
//

#import "DYCollectionView.h"

@interface DYCollectionView ()

@property (nonatomic, copy) DYScrollViewShouldBeginPanGestureHandler gestureBeginHandler;

@end

@implementation DYCollectionView

/**
 解决手势冲突
 */
- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer {
    if (_gestureBeginHandler && gestureRecognizer == self.panGestureRecognizer) {
        return _gestureBeginHandler(self,(UIPanGestureRecognizer *)gestureRecognizer);
    } else {
        return [super gestureRecognizerShouldBegin:gestureRecognizer];
    }
}

- (void)setupScrollViewShouldBeginPanGestureHandler:(DYScrollViewShouldBeginPanGestureHandler)gestureBeginHandler {
    _gestureBeginHandler = [gestureBeginHandler copy];
}

@end
