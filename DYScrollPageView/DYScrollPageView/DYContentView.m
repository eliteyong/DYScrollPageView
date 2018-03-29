//
//  DYContentView.m
//  DYScrollPageView
//
//  Created by admin on 2018/3/28.
//  Copyright © 2018年 YDY. All rights reserved.
//

#import "DYContentView.h"

@interface DYContentView () <UIScrollViewDelegate, UICollectionViewDelegate, UICollectionViewDataSource> {
    CGFloat _oldOffSetX;
    BOOL _isLoadFirstView;
    NSInteger _sysVersion;
}

@property (nonatomic, weak) DYScrollSegmentView *segmentView;

/**
 用于处理重用和内容的显示
 */
@property (nonatomic, strong) DYCollectionView *collectionView;
/**
 collectionView的布局
 */
@property (nonatomic, strong) UICollectionViewFlowLayout *collectionViewLayout;

/**
 父类 用于处理添加子控制器  使用weak避免循环引用
 */
@property (nonatomic, weak) UIViewController *parentViewController;

/**
 当这个属性设置为YES的时候 就不用处理 scrollView滚动的计算
 */
@property (nonatomic, assign) BOOL forbidTouchToAdjustPosition;

@property (nonatomic, assign) NSInteger itemsCount;

/**
 所有的子控制器
 */
@property (nonatomic, strong) NSMutableDictionary<NSString *, UIViewController<DYScrollPageViewChildViewControllerDelegate> *> *childVcsDic;

/**
 当前控制器
 */
@property (nonatomic, strong) UIViewController<DYScrollPageViewChildViewControllerDelegate> *currentChildViewController;

// 如果类似cell缓存一样, 虽然创建的控制器少了, 但是每个页面每次都要重新加载数据, 否则显示的内容就会出错, 貌似还不如每个页面创建一个控制器好
//@property (nonatomic, strong) NSCache *cacheChildVcs;

@property (nonatomic, assign) NSInteger currentIndex;
@property (nonatomic, assign) NSInteger oldIndex;

/**
 是否需要手动管理生命周期方法的调用
 */
@property (nonatomic, assign) BOOL needManageLifeCycle;
/**
 滚动超过页面(直接设置contentOffSet导致)
 */
@property (nonatomic, assign) BOOL scrollOverOnePage;


@end

@implementation DYContentView
#define cellID @"cellID"

#pragma mark --- life cycle
- (instancetype)initWithFrame:(CGRect)frame segmentView:(DYScrollSegmentView *)segmentView parentViewController:(UIViewController *)parentViewController delegate:(id<DYScrollPageViewDelegate>)delegate {
    if (self = [super initWithFrame:frame]) {
        
    }
    return self;
}


#pragma mark --- getter and setter

- (void)setCurrentIndex:(NSInteger)currentIndex {

}

@end
