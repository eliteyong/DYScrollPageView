//
//  DYScrollPageView.h
//  DYScrollPageView
//
//  Created by admin on 2018/3/28.
//  Copyright © 2018年 YDY. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIView+DYFrame.h"
#import "DYContentView.h"
#import "DYTitleView.h"

typedef void(^ExtraBtnOnClick)(UIButton *extraBtn);

@interface DYScrollPageView : UIView

@property (nonatomic, copy) ExtraBtnOnClick extraBtnOnClick;

@property (nonatomic, weak, readonly) DYContentView *contentView;
@property (nonatomic, weak, readonly) DYScrollSegmentView *segmentView;

/**
 必须设置代理并且实现相应的方法
 */
@property (nonatomic, weak) id <DYScrollPageViewDelegate> delegate;

/**
 初始化方法
 */
- (instancetype)initWithFrame:(CGRect)frame segmentStyle:(DYSegmentStyle *)segmentStyle titles:(NSArray<NSString *> *)titles parentViewController:(UIViewController *)parentViewController delegate:(id<DYScrollPageViewDelegate>)delegate;

/** 
 给外界设置选中的下标的方法 
 */
- (void)setSelectedIndex:(NSInteger)selectedIndex animated:(BOOL)animated;

/**  
 给外界重新设置的标题的方法(同时会重新加载页面的内容)
 */
- (void)reloadWithNewTitles:(NSArray<NSString *> *)newTitles;


@end
