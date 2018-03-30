//
//  DYScrollPageView.m
//  DYScrollPageView
//
//  Created by admin on 2018/3/28.
//  Copyright © 2018年 YDY. All rights reserved.
//

#import "DYScrollPageView.h"

@interface DYScrollPageView ()

@property (nonatomic, strong) DYSegmentStyle *segmentStyle;
@property (nonatomic, weak) DYScrollSegmentView *segmentView;
@property (nonatomic, weak) DYContentView *contentView;

@property (nonatomic, weak) UIViewController *parentViewController;
@property (nonatomic, strong) NSArray *childVcs;
@property (nonatomic, strong) NSArray *titlesArray;

@end

@implementation DYScrollPageView

#pragma mark - life cycle

- (instancetype)initWithFrame:(CGRect)frame segmentStyle:(DYSegmentStyle *)segmentStyle titles:(NSArray<NSString *> *)titles parentViewController:(UIViewController *)parentViewController delegate:(id<DYScrollPageViewDelegate>)delegate {
    if (self = [super initWithFrame:frame]) {
        self.segmentStyle = segmentStyle;
        self.delegate = delegate;
        self.parentViewController = parentViewController;
        self.titlesArray = titles.copy;
        [self commonInit];
    }
    return self;
}


- (void)commonInit {
    // 触发懒加载
    self.segmentView.backgroundColor = [UIColor whiteColor];
    self.contentView.backgroundColor = [UIColor whiteColor];
}

- (void)dealloc {
    NSLog(@"DYScrollPageView--销毁");
}

#pragma mark - public helper

/** 给外界设置选中的下标的方法 */
- (void)setSelectedIndex:(NSInteger)selectedIndex animated:(BOOL)animated {
    [self.segmentView setSelectedIndex:selectedIndex animated:animated];
}

/**  给外界重新设置视图内容的标题的方法 */
- (void)reloadWithNewTitles:(NSArray<NSString *> *)newTitles {
    
    self.titlesArray = nil;
    self.titlesArray = newTitles.copy;
    
    [self.segmentView reloadTitlesWithNewTitles:self.titlesArray];
    [self.contentView reload];
}


#pragma mark --- getter and setter

- (DYContentView *)contentView {
    if (!_contentView) {
        DYContentView *content = [[DYContentView alloc] initWithFrame:CGRectMake(0.0, CGRectGetMaxY(self.segmentView.frame), self.bounds.size.width, self.bounds.size.height - CGRectGetMaxY(self.segmentView.frame)) segmentView:self.segmentView parentViewController:self.parentViewController delegate:self.delegate];
        [self addSubview:content];
        _contentView = content;
    }
    
    return  _contentView;
}


- (DYScrollSegmentView *)segmentView {
    if (!_segmentView) {
        __weak typeof(self) weakSelf = self;
        DYScrollSegmentView *segment = [[DYScrollSegmentView alloc] initWithFrame:CGRectMake(0, 0, self.bounds.size.width, self.segmentStyle.segmentHeight) segmentStyle:self.segmentStyle delegate:self.delegate titles:self.titlesArray titleDidClick:^(DYTitleView *titleView, NSInteger index) {
            [weakSelf.contentView setContentOffSet:CGPointMake(weakSelf.contentView.bounds.size.width * index, 0.0) animated:weakSelf.segmentStyle.isAnimatedContentViewWhenTitleClicked];
        }];
        [self addSubview:segment];
        _segmentView = segment;
    }
    return _segmentView;
}

- (NSArray *)childVcs {
    if (!_childVcs) {
        _childVcs = [NSArray array];
    }
    return _childVcs;
}

- (NSArray *)titlesArray {
    if (!_titlesArray) {
        _titlesArray = [NSArray array];
    }
    return _titlesArray;
}

- (void)setExtraBtnOnClick:(ExtraBtnOnClick)extraBtnOnClick {
    _extraBtnOnClick = extraBtnOnClick;
    self.segmentView.extraBtnOnClick = extraBtnOnClick;
}

@end
