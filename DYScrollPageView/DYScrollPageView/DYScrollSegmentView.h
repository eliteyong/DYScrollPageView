//
//  DYScrollSegmentView.h
//  DYScrollPageView
//
//  Created by admin on 2018/3/28.
//  Copyright © 2018年 YDY. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "DYSegmentStyle.h"
#import "DYScrollPageViewDelegate.h"
@class DYSegmentStyle;
@class DYTitleView;

typedef void(^TitleBtnOnClickBlock)(DYTitleView *titleView, NSInteger index);
typedef void(^ExtraBtnOnClick)(UIButton *extraBtn);

@interface DYScrollSegmentView : UIView

/**
 所有的标题
 */
@property (nonatomic, strong) NSArray *titles;
/**
 所有标题的设置
 */
@property (nonatomic, strong) DYSegmentStyle *segmentStyle;

@property (nonatomic, copy) ExtraBtnOnClick extraBtnOnClick;
@property (nonatomic, weak) id <DYScrollPageViewDelegate> delegate;

@property (nonatomic, strong) UIImage *backgroundImage;


/**
 初始化方法
 */
- (instancetype)initWithFrame:(CGRect )frame segmentStyle:(DYSegmentStyle *)segmentStyle delegate:(id<DYScrollPageViewDelegate>)delegate titles:(NSArray *)titles titleDidClick:(TitleBtnOnClickBlock)titleDidClick;

/**
 切换下标的时候根据progress同步设置UI
 */
- (void)adjustUIWithProgress:(CGFloat)progress oldIndex:(NSInteger)oldIndex currentIndex:(NSInteger)currentIndex;

/**
 让选中的标题居中
 */
- (void)adjustTitleOffSetToCurrentIndex:(NSInteger)currentIndex;
/**
 设置选中的下标
 */
- (void)setSelectedIndex:(NSInteger)index animated:(BOOL)animated;
/**
 重新刷新标题的内容
 */
- (void)reloadTitlesWithNewTitles:(NSArray *)titles;

@end
