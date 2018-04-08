//
//  DYScrollSegmentView.m
//  DYScrollPageView
//
//  Created by admin on 2018/3/28.
//  Copyright © 2018年 YDY. All rights reserved.
//

#import "DYScrollSegmentView.h"
#import "DYTitleView.h"
#import "UIView+DYFrame.h"

@interface DYScrollSegmentView () <UIScrollViewDelegate> {
    CGFloat _currentWidth;
    NSUInteger _currentIndex;
    NSUInteger _oldIndex;
//    BOOL _isScroll;
}

/**
 滚动条
 */
@property (nonatomic, strong) UIView *scrollLine;
/**
 底部的下划线
 */
@property (nonatomic, strong) UIView *bottomLineView;
/**
 遮盖
 */
@property (nonatomic, strong) UIView *coverLayer;
/**
 滚动scrollView
 */
@property (nonatomic, strong) UIScrollView *scrollView;
/**
 背景imageView
 */
@property (nonatomic, strong) UIImageView *backgroundImageView;
/**
 附件按钮
 */
@property (nonatomic, strong) UIButton *extraBtn;

// 用于懒加载计算文字的rgba差值, 用于颜色渐变的时候设置
@property (nonatomic, strong) NSArray *deltaRGBA;
@property (nonatomic, strong) NSArray *selectedColorRGBA;
@property (nonatomic, strong) NSArray *normalColorRGBA;

/**
 缓存所有标题label的数组
 */
@property (nonatomic, strong) NSMutableArray *titleViews;
/**
 缓存计算出来的每个标题宽度的数组
 */
@property (nonatomic, strong) NSMutableArray *titleWidths;

/**
 响应标题点击
 */
@property (nonatomic, copy) TitleBtnOnClickBlock titleBtnOnClick;

@end

@implementation DYScrollSegmentView

static CGFloat const xGap = 5.0;
static CGFloat const wGap = 2 * xGap;
static CGFloat const contentSizeXOff = 20.0;

#pragma mark --- life sycle
- (instancetype)initWithFrame:(CGRect)frame segmentStyle:(DYSegmentStyle *)segmentStyle delegate:(id<DYScrollPageViewDelegate>)delegate titles:(NSArray *)titles titleDidClick:(TitleBtnOnClickBlock)titleDidClick {
    if (self = [super initWithFrame:frame]) {
        self.segmentStyle = segmentStyle;
        self.titles = titles;
        self.titleBtnOnClick = titleDidClick;
        self.delegate = delegate;
        _currentIndex = 0;
        _oldIndex = 0;
        _currentWidth = frame.size.width;
        
        if (!self.segmentStyle.isScrollTitle) { // 不能滚动的时候就不要把缩放和遮盖或者滚动条同时使用, 否则显示效果不好
            self.segmentStyle.scaleTitle = !(self.segmentStyle.isShowCover || self.segmentStyle.isShowLine);
        }
        
        if (self.segmentStyle.isShowImage) {//不要有以下的显示效果
            self.segmentStyle.scaleTitle = NO;
            self.segmentStyle.showCover = NO;
            self.segmentStyle.gradualChangeTitleColor = NO;
        }
        
        // 设置了frame之后可以直接设置其他的控件的frame了, 不需要在layoutsubView()里面设置
        [self setupSubviews];
        [self setupUI];
    }
    return self;
}


- (void)setupSubviews {
    [self addSubview:self.scrollView];
    [self addScrollLineOrCoverOrExtraBtn];
    [self setupTitles];
}

- (void)addScrollLineOrCoverOrExtraBtn {
    if (self.segmentStyle.isShowLine) {
        [self.scrollView addSubview:self.scrollLine];
    }
    
    if (self.segmentStyle.isShowCover) {
        [self.scrollView insertSubview:self.coverLayer atIndex:0];
    }
    
    if (self.segmentStyle.isShowExtraButton) {
        [self addSubview:self.extraBtn];
    }
    
    if (self.segmentStyle.isShowBottomLine) {
        [self addSubview:self.bottomLineView];
    }
}

- (void)dealloc {
#if DEBUG
    NSLog(@"DYScrollSegmentView ---- 销毁");
    
#endif
}

#pragma mark --- 响应事件

- (void)titleLabelOnClick:(UITapGestureRecognizer *)tapGes {
    
    DYTitleView *currentLabel = (DYTitleView *)tapGes.view;
    
    if (!currentLabel) {
        return;
    }
    
    _currentIndex = currentLabel.tag;
    [self adjustUIWhenBtnOnClickWithAnimate:true taped:YES];
}

- (void)extraBtnOnClick:(UIButton *)extraBtn {
   
    if (self.extraBtnOnClick) {
        self.extraBtnOnClick(extraBtn);
    }
}


#pragma mark - private helper

- (void)setupTitles {
    
    if (self.titles.count == 0) return;
    
    NSInteger index = 0;
    for (NSString *title in self.titles) {
        
        DYTitleView *titleView = [[DYTitleView alloc] initWithFrame:CGRectZero];
        titleView.tag = index;
        
        titleView.font = self.segmentStyle.titleFont;
        titleView.text = title;
        titleView.textColor = self.segmentStyle.normalTitleColor;
        titleView.imagePosition = self.segmentStyle.imagePosition;
        
        if (self.delegate && [self.delegate respondsToSelector:@selector(setUpTitleView:forIndex:)]) {
            [self.delegate setUpTitleView:titleView forIndex:index];
        }
        
        UITapGestureRecognizer *tapGes = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(titleLabelOnClick:)];
        [titleView addGestureRecognizer:tapGes];
        
        CGFloat titleViewWidth = [titleView titleViewWidth];
        [self.titleWidths addObject:@(titleViewWidth)];
        
        [self.titleViews addObject:titleView];
        [self.scrollView addSubview:titleView];
        
        index++;
    }
}

- (void)setupUI {
    if (self.titles.count == 0) return;
    
    [self setupScrollViewAndExtraBtn];
    [self setUpTitleViewsPosition];
    [self setupScrollLineAndCover];
    
    if (self.segmentStyle.isScrollTitle) { // 设置滚动区域
        DYTitleView *lastTitleView = (DYTitleView *)self.titleViews.lastObject;
        
        if (lastTitleView) {
            self.scrollView.contentSize = CGSizeMake(CGRectGetMaxX(lastTitleView.frame) + contentSizeXOff, 0.0);
        }
    }
}

- (void)setupScrollViewAndExtraBtn {
    CGFloat extraBtnW = 44.0;
    CGFloat extraBtnY = 5.0;
    
    CGFloat scrollW = self.extraBtn ? _currentWidth - extraBtnW : _currentWidth;
  
    self.scrollView.frame = CGRectMake(0.0, 0.0, scrollW, self.dy_height);
    
    if (self.extraBtn) {
        self.extraBtn.frame = CGRectMake(scrollW , extraBtnY, extraBtnW, self.dy_height - 2 * extraBtnY);
    }
}

- (void)setUpTitleViewsPosition {
    
    CGFloat titleX = 0.0; CGFloat titleY = 0.0; CGFloat titleW = 0.0;
    CGFloat titleH = self.dy_height - self.segmentStyle.scrollLineHeight;
    
    if (!self.segmentStyle.isScrollTitle) {// 标题不能滚动, 平分宽度
        titleW = self.scrollView.bounds.size.width / self.titles.count;
        
        NSInteger index = 0;
        for (DYTitleView *titleView in self.titleViews) {
            titleX = index * titleW;
            titleView.frame = CGRectMake(titleX, titleY, titleW, titleH);
            if (self.segmentStyle.isShowImage) {
                [titleView adjustSubviewFrame];
            }
            index++;
        }
    } else {
        NSInteger index = 0;
        float lastLableMaxX = self.segmentStyle.titleMargin;
        float addedMargin = 0.0f;
        
        if (self.segmentStyle.isAutoAdjustTitlesWidth) {
            float allTitlesWidth = self.segmentStyle.titleMargin;
            for (int i = 0; i<self.titleWidths.count; i++) {
                allTitlesWidth = allTitlesWidth + [self.titleWidths[i] floatValue] + self.segmentStyle.titleMargin;
            }
            addedMargin = allTitlesWidth < self.scrollView.bounds.size.width ? (self.scrollView.bounds.size.width - allTitlesWidth)/self.titleWidths.count : 0 ;
        }
        
        for (DYTitleView *titleView in self.titleViews) {
            titleW = [self.titleWidths[index] floatValue];
            titleX = lastLableMaxX + addedMargin / 2;
            lastLableMaxX += (titleW + addedMargin + self.segmentStyle.titleMargin);
            titleView.frame = CGRectMake(titleX, titleY, titleW, titleH);
            if (self.segmentStyle.isShowImage) {
                [titleView adjustSubviewFrame];
            }
            index++;
        }
    }
    
    DYTitleView *currentTitleView = (DYTitleView *)self.titleViews[_currentIndex];
    currentTitleView.currentTransformSx = 1.0;
    if (currentTitleView) {
        
        // 缩放, 设置初始的label的transform
        if (self.segmentStyle.isScaleTitle) {
            currentTitleView.currentTransformSx = self.segmentStyle.titleBigScale;
        }
        // 设置初始状态文字的颜色
        currentTitleView.textColor = self.segmentStyle.selectedTitleColor;
        if (self.segmentStyle.isShowImage) {
            currentTitleView.selected = YES;
        }
    }
    
}

- (void)setupScrollLineAndCover {
    
    DYTitleView *firstLabel = (DYTitleView *)self.titleViews[0];
    CGFloat coverX = firstLabel.dy_x;
    CGFloat coverW = firstLabel.dy_width;
    CGFloat coverH = self.segmentStyle.coverHeight;
    CGFloat coverY = (self.bounds.size.height - coverH) * 0.5;
    
    if (self.scrollLine) {
        if (self.segmentStyle.isScrollTitle) {
            self.scrollLine.frame = CGRectMake(coverX , self.dy_height - self.segmentStyle.scrollLineHeight, coverW , self.segmentStyle.scrollLineHeight);
        } else {
            if (self.segmentStyle.isAdjustCoverOrLineWidth) {
                coverW = [self.titleWidths[_currentIndex] floatValue] + wGap;
                coverX = (firstLabel.dy_width - coverW) * 0.5;
            }
            self.scrollLine.frame = CGRectMake(coverX , self.dy_height - self.segmentStyle.scrollLineHeight, coverW , self.segmentStyle.scrollLineHeight);
        }
    }
    
    if (self.coverLayer) {
        if (self.segmentStyle.isScrollTitle) {
            self.coverLayer.frame = CGRectMake(coverX - xGap, coverY, coverW + wGap, coverH);
        } else {
            if (self.segmentStyle.isAdjustCoverOrLineWidth) {
                coverW = [self.titleWidths[_currentIndex] floatValue] + wGap;
                coverX = (firstLabel.dy_width - coverW) * 0.5;
            }
            self.coverLayer.frame = CGRectMake(coverX, coverY, coverW, coverH);
        }
    }
}


#pragma mark - public helper

- (void)adjustUIWhenBtnOnClickWithAnimate:(BOOL)animated taped:(BOOL)taped {
    
    if (_currentIndex == _oldIndex && taped) return;
    
    DYTitleView *oldTitleView = (DYTitleView *)self.titleViews[_oldIndex];
    DYTitleView *currentTitleView = (DYTitleView *)self.titleViews[_currentIndex];
    
    CGFloat animatedTime = animated ? 0.30 : 0.0;
    
    __weak typeof(self) weakSelf = self;
    [UIView animateWithDuration:animatedTime animations:^{
        oldTitleView.textColor = weakSelf.segmentStyle.normalTitleColor;
        currentTitleView.textColor = weakSelf.segmentStyle.selectedTitleColor;
        oldTitleView.selected = NO;
        currentTitleView.selected = YES;
        if (weakSelf.segmentStyle.isScaleTitle) {
            oldTitleView.currentTransformSx = 1.0;
            currentTitleView.currentTransformSx = weakSelf.segmentStyle.titleBigScale;
        }
        
        if (weakSelf.scrollLine) {
            if (weakSelf.segmentStyle.isScrollTitle) {
                weakSelf.scrollLine.dy_x = currentTitleView.dy_x;
                weakSelf.scrollLine.dy_width = currentTitleView.dy_width;
            } else {
                if (self.segmentStyle.isAdjustCoverOrLineWidth) {
                    CGFloat scrollLineW = [self.titleWidths[_currentIndex] floatValue] + wGap;
                    CGFloat scrollLineX = currentTitleView.dy_x + (currentTitleView.dy_width - scrollLineW) * 0.5;
                    weakSelf.scrollLine.dy_x = scrollLineX;
                    weakSelf.scrollLine.dy_width = scrollLineW;
                } else {
                    weakSelf.scrollLine.dy_x = currentTitleView.dy_x;
                    weakSelf.scrollLine.dy_width = currentTitleView.dy_width;
                }
            }
        }
        
        if (weakSelf.coverLayer) {
            if (weakSelf.segmentStyle.isScrollTitle) {
                weakSelf.coverLayer.dy_x = currentTitleView.dy_x - xGap;
                weakSelf.coverLayer.dy_width = currentTitleView.dy_width + wGap;
            } else {
                if (self.segmentStyle.isAdjustCoverOrLineWidth) {
                    CGFloat coverW = [self.titleWidths[_currentIndex] floatValue] + wGap;
                    CGFloat coverX = currentTitleView.dy_x + (currentTitleView.dy_width - coverW) * 0.5;
                    weakSelf.coverLayer.dy_x = coverX;
                    weakSelf.coverLayer.dy_width = coverW;
                } else {
                    weakSelf.coverLayer.dy_x = currentTitleView.dy_x;
                    weakSelf.coverLayer.dy_width = currentTitleView.dy_width;
                }
            }
        }
    } completion:^(BOOL finished) {
        [weakSelf adjustTitleOffSetToCurrentIndex:_currentIndex];
    }];
    
    _oldIndex = _currentIndex;
    if (self.titleBtnOnClick) {
        self.titleBtnOnClick(currentTitleView, _currentIndex);
    }
}

- (void)adjustUIWithProgress:(CGFloat)progress oldIndex:(NSInteger)oldIndex currentIndex:(NSInteger)currentIndex {
    if (oldIndex < 0 || oldIndex >= self.titles.count || currentIndex < 0 || currentIndex >= self.titles.count
        ) {
        return;
    }
    _oldIndex = currentIndex;
    
    DYTitleView *oldTitleView = (DYTitleView *)self.titleViews[oldIndex];
    DYTitleView *currentTitleView = (DYTitleView *)self.titleViews[currentIndex];
    
    CGFloat xDistance = currentTitleView.dy_x - oldTitleView.dy_x;
    CGFloat wDistance = currentTitleView.dy_width - oldTitleView.dy_width;
    
    if (self.scrollLine) {
        if (self.segmentStyle.isScrollTitle) {
            self.scrollLine.dy_x = oldTitleView.dy_x + xDistance * progress;
            self.scrollLine.dy_width = oldTitleView.dy_width + wDistance * progress;
        } else {
            if (self.segmentStyle.isAdjustCoverOrLineWidth) {
                CGFloat oldScrollLineW = [self.titleWidths[oldIndex] floatValue] + wGap;
                CGFloat currentScrollLineW = [self.titleWidths[currentIndex] floatValue] + wGap;
                wDistance = currentScrollLineW - oldScrollLineW;
                
                CGFloat oldScrollLineX = oldTitleView.dy_x + (oldTitleView.dy_width - oldScrollLineW) * 0.5;
                CGFloat currentScrollLineX = currentTitleView.dy_x + (currentTitleView.dy_width - currentScrollLineW) * 0.5;
                xDistance = currentScrollLineX - oldScrollLineX;
                self.scrollLine.dy_x = oldScrollLineX + xDistance * progress;
                self.scrollLine.dy_width = oldScrollLineW + wDistance * progress;
            } else {
                self.scrollLine.dy_x = oldTitleView.dy_x + xDistance * progress;
                self.scrollLine.dy_width = oldTitleView.dy_width + wDistance * progress;
            }
        }
    }
    
    if (self.coverLayer) {
        if (self.segmentStyle.isScrollTitle) {
            self.coverLayer.dy_x = oldTitleView.dy_x + xDistance * progress - xGap;
            self.coverLayer.dy_width = oldTitleView.dy_width + wDistance * progress + wGap;
        } else {
            if (self.segmentStyle.isAdjustCoverOrLineWidth) {
                CGFloat oldCoverW = [self.titleWidths[oldIndex] floatValue] + wGap;
                CGFloat currentCoverW = [self.titleWidths[currentIndex] floatValue] + wGap;
                wDistance = currentCoverW - oldCoverW;
                CGFloat oldCoverX = oldTitleView.dy_x + (oldTitleView.dy_width - oldCoverW) * 0.5;
                CGFloat currentCoverX = currentTitleView.dy_x + (currentTitleView.dy_width - currentCoverW) * 0.5;
                xDistance = currentCoverX - oldCoverX;
                self.coverLayer.dy_x = oldCoverX + xDistance * progress;
                self.coverLayer.dy_width = oldCoverW + wDistance * progress;
            } else {
                self.coverLayer.dy_x = oldTitleView.dy_x + xDistance * progress;
                self.coverLayer.dy_width = oldTitleView.dy_width + wDistance * progress;
            }
        }
    }
    
    // 渐变
    if (self.segmentStyle.isGradualChangeTitleColor) {
        oldTitleView.textColor = [UIColor colorWithRed:[self.selectedColorRGBA[0] floatValue] + [self.deltaRGBA[0] floatValue] * progress green:[self.selectedColorRGBA[1] floatValue] + [self.deltaRGBA[1] floatValue] * progress blue:[self.selectedColorRGBA[2] floatValue] + [self.deltaRGBA[2] floatValue] * progress alpha:[self.selectedColorRGBA[3] floatValue] + [self.deltaRGBA[3] floatValue] * progress];
        
        currentTitleView.textColor = [UIColor colorWithRed:[self.normalColorRGBA[0] floatValue] - [self.deltaRGBA[0] floatValue] * progress green:[self.normalColorRGBA[1] floatValue] - [self.deltaRGBA[1] floatValue] * progress blue:[self.normalColorRGBA[2] floatValue] - [self.deltaRGBA[2] floatValue] * progress alpha:[self.normalColorRGBA[3] floatValue] - [self.deltaRGBA[3] floatValue] * progress];
    }
    
    if (!self.segmentStyle.isScaleTitle) {
        return;
    }
    
    CGFloat deltaScale = self.segmentStyle.titleBigScale - 1.0;
    oldTitleView.currentTransformSx = self.segmentStyle.titleBigScale - deltaScale * progress;
    currentTitleView.currentTransformSx = 1.0 + deltaScale * progress;
}

- (void)adjustTitleOffSetToCurrentIndex:(NSInteger)currentIndex {
    _oldIndex = currentIndex;
    // 重置渐变/缩放效果附近其他item的缩放和颜色
    int index = 0;
    for (DYTitleView *titleView in _titleViews) {
        if (index != currentIndex) {
            titleView.textColor = self.segmentStyle.normalTitleColor;
            titleView.currentTransformSx = 1.0;
            titleView.selected = NO;
        } else {
            titleView.textColor = self.segmentStyle.selectedTitleColor;
            if (self.segmentStyle.isScaleTitle) {
                titleView.currentTransformSx = self.segmentStyle.titleBigScale;
            }
            titleView.selected = YES;
        }
        index++;
    }
    
    if (self.scrollView.contentSize.width != self.scrollView.bounds.size.width + contentSizeXOff) {// 需要滚动
        DYTitleView *currentTitleView = (DYTitleView *)_titleViews[currentIndex];
        
        CGFloat offSetx = currentTitleView.center.x - _currentWidth * 0.5;
        if (offSetx < 0) {
            offSetx = 0;
        }
        CGFloat extraBtnW = self.extraBtn ? self.extraBtn.dy_width : 0.0;
        CGFloat maxOffSetX = self.scrollView.contentSize.width - (_currentWidth - extraBtnW);
        
        if (maxOffSetX < 0) {
            maxOffSetX = 0;
        }
        
        if (offSetx > maxOffSetX) {
            offSetx = maxOffSetX;
        }
        
        [self.scrollView setContentOffset:CGPointMake(offSetx, 0.0) animated:YES];
    }
}

- (void)setSelectedIndex:(NSInteger)index animated:(BOOL)animated {
    NSAssert(index >= 0 && index < self.titles.count, @"设置的下标不合法!!");
    if (index < 0 || index >= self.titles.count) {
        return;
    }
    _currentIndex = index;
    [self adjustUIWhenBtnOnClickWithAnimate:animated taped:NO];
}

- (void)reloadTitlesWithNewTitles:(NSArray *)titles {
    [self.scrollView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    
    _currentIndex = 0;
    _oldIndex = 0;
    self.titleWidths = nil;
    self.titleViews = nil;
    self.titles = nil;
    self.titles = [titles copy];
    if (self.titles.count == 0) return;
    for (UIView *subview in self.subviews) {
        [subview removeFromSuperview];
    }
    [self setupSubviews];
    [self setupUI];
    [self setSelectedIndex:0 animated:YES];
    
}

#pragma mark --- getter and setter

- (UIView *)scrollLine {
    if (!self.segmentStyle.isShowLine) {
        return nil;
    }
    if (!_scrollLine) {
        UIView *lineView = [[UIView alloc] init];
        lineView.backgroundColor = self.segmentStyle.scrollLineColor;
        _scrollLine = lineView;
    }
    return _scrollLine;
}

- (UIView *)coverLayer {
    if (!self.segmentStyle.isShowCover) {
        return nil;
    }
    if (_coverLayer == nil) {
        UIView *coverView = [[UIView alloc] init];
        coverView.backgroundColor = self.segmentStyle.coverBackgroundColor;
        coverView.layer.cornerRadius = self.segmentStyle.coverCornerRadius;
        coverView.layer.masksToBounds = YES;
        _coverLayer = coverView;
    }
    return _coverLayer;
}

- (UIView *)bottomLineView {
    if (_bottomLineView == nil) {
        _bottomLineView = [[UIView alloc] init];
        _bottomLineView.frame = CGRectMake(0, self.segmentStyle.segmentHeight - 1, self.frame.size.width, 1);
        _bottomLineView.backgroundColor = self.segmentStyle.bottomLineColor ? :[UIColor colorWithRed:238/255.0 green:238/255.0 blue:238/255.0 alpha:1];
    }
    return _bottomLineView;
}

- (UIButton *)extraBtn {
    if (!self.segmentStyle.showExtraButton) {
        return nil;
    }
    if (!_extraBtn) {
        UIButton *btn = [UIButton new];
        [btn addTarget:self action:@selector(extraBtnOnClick:) forControlEvents:UIControlEventTouchUpInside];
        NSString *imageName = self.segmentStyle.extraBtnBackgroundImageName ? self.segmentStyle.extraBtnBackgroundImageName : @"";
        [btn setImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
        btn.backgroundColor = [UIColor whiteColor];
        // 设置边缘的阴影效果
        btn.layer.shadowColor = [UIColor whiteColor].CGColor;
        btn.layer.shadowOffset = CGSizeMake(-5, 0);
        btn.layer.shadowOpacity = 1;
        
        _extraBtn = btn;
    }
    return _extraBtn;
}

- (UIScrollView *)scrollView {
    
    if (!_scrollView) {
        UIScrollView *scrollView = [[UIScrollView alloc] init];
        scrollView.showsHorizontalScrollIndicator = NO;
        scrollView.scrollsToTop = NO;
        scrollView.bounces = self.segmentStyle.isSegmentViewBounces;
        scrollView.pagingEnabled = NO;
        scrollView.delegate = self;
        _scrollView = scrollView;
    }
    return _scrollView;
}

- (UIImageView *)backgroundImageView {
    if (!_backgroundImageView) {
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:self.bounds];
        [self insertSubview:imageView atIndex:0];
        _backgroundImageView = imageView;
    }
    return _backgroundImageView;
}

- (void)setBackgroundImage:(UIImage *)backgroundImage {
    _backgroundImage = backgroundImage;
    if (backgroundImage) {
        self.backgroundImageView.image = backgroundImage;
    }
}

- (NSMutableArray *)titleViews {
    if (_titleViews == nil) {
        _titleViews = [NSMutableArray array];
    }
    return _titleViews;
}

- (NSMutableArray *)titleWidths {
    if (_titleWidths == nil) {
        _titleWidths = [NSMutableArray array];
    }
    return _titleWidths;
}

- (NSArray *)deltaRGBA {
    if (_deltaRGBA == nil) {
        NSArray *normalColorRgb = self.normalColorRGBA;
        NSArray *selectedColorRgb = self.selectedColorRGBA;
        
        NSArray *delta;
        if (normalColorRgb && selectedColorRgb) {
            CGFloat deltaR = [normalColorRgb[0] floatValue] - [selectedColorRgb[0] floatValue];
            CGFloat deltaG = [normalColorRgb[1] floatValue] - [selectedColorRgb[1] floatValue];
            CGFloat deltaB = [normalColorRgb[2] floatValue] - [selectedColorRgb[2] floatValue];
            CGFloat deltaA = [normalColorRgb[3] floatValue] - [selectedColorRgb[3] floatValue];
            delta = [NSArray arrayWithObjects:@(deltaR), @(deltaG), @(deltaB), @(deltaA), nil];
            _deltaRGBA = delta;
        }
    }
    return _deltaRGBA;
}

- (NSArray *)normalColorRGBA {
    if (!_normalColorRGBA) {
        NSArray *normalColorRGBA = [self getColorRGBA:self.segmentStyle.normalTitleColor];
        NSAssert(normalColorRGBA, @"设置普通状态的文字颜色时 请使用RGBA空间的颜色值");
        _normalColorRGBA = normalColorRGBA;
        
    }
    return  _normalColorRGBA;
}

- (NSArray *)selectedColorRGBA {
    if (!_selectedColorRGBA) {
        NSArray *selectedColorRGBA = [self getColorRGBA:self.segmentStyle.selectedTitleColor];
        NSAssert(selectedColorRGBA, @"设置选中状态的文字颜色时 请使用RGBA空间的颜色值");
        _selectedColorRGBA = selectedColorRGBA;
        
    }
    return  _selectedColorRGBA;
}

- (NSArray *)getColorRGBA:(UIColor *)color {
    CGFloat numOfcomponents = CGColorGetNumberOfComponents(color.CGColor);
    NSArray *rgbaComponents;
    if (numOfcomponents == 4) {
        const CGFloat *components = CGColorGetComponents(color.CGColor);
        rgbaComponents = [NSArray arrayWithObjects:@(components[0]), @(components[1]), @(components[2]), @(components[3]), nil];
    }
    return rgbaComponents;
    
}

@end
