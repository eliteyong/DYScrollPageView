//
//  DYContentView.h
//  DYScrollPageView
//
//  Created by admin on 2018/3/28.
//  Copyright © 2018年 YDY. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DYScrollPageViewDelegate.h"
#import "DYCollectionView.h"
#import "DYScrollSegmentView.h"
#import "UIViewController+DYScrollPageController.h"

@interface DYContentView : UIView

/**
 必须设置代理和实现相关的方法
 */
@property (nonatomic, weak) id <DYScrollPageViewDelegate> delegate;

/**
 左右滑动的collectionView
 */
@property (nonatomic, strong, readonly) DYCollectionView *collectionView;

/**
 当前视图控制器
 */
@property (nonatomic, strong, readonly) UIViewController <DYScrollPageViewChildViewControllerDelegate> *currentChildViewController;

/**
 初始化方法
 */
- (instancetype)initWithFrame:(CGRect)frame segmentView:(DYScrollSegmentView *)segmentView parentViewController:(UIViewController *)parentViewController delegate:(id<DYScrollPageViewDelegate>) delegate;

/** 
 给外界可以设置ContentOffSet的方法
 */
- (void)setContentOffSet:(CGPoint)offset animated:(BOOL)animated;

/** 
 给外界重新加载内容的方法 
 */
- (void)reload;

@end
