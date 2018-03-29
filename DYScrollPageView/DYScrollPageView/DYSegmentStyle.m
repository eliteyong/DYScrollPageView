//
//  DYSegmentStyle.m
//  DYScrollPageView
//
//  Created by admin on 2018/3/28.
//  Copyright © 2018年 YDY. All rights reserved.
//

#import "DYSegmentStyle.h"

@implementation DYSegmentStyle

- (instancetype)init {
    if (self = [super init]) {
        _showCover = NO;
        _showLine = NO;
        _scaleTitle = NO;
        _scrollTitle = YES;
        _segmentViewBounces = YES;
        _contentViewBounces = YES;
        _gradualChangeTitleColor = NO;
        _showExtraButton = NO;
        _scrollContentView = YES;
        _adjustCoverOrLineWidth = NO;
        _showImage = NO;
        _autoAdjustTitlesWidth = NO;
        _animatedContentViewWhenTitleClicked = YES;
        _extraBtnBackgroundImageName = nil;
        _scrollLineHeight = 2.0;
        _scrollLineColor = [UIColor brownColor];
        _coverBackgroundColor = [UIColor lightGrayColor];
        _coverCornerRadius = 14.0;
        _coverHeight = 28.0;
        _titleMargin = 15.0;
        _titleFont = [UIFont systemFontOfSize:14.0];
        _titleBigScale = 1.3;
        _normalTitleColor = [UIColor colorWithRed:51.0/255.0 green:53.0/255.0 blue:75/255.0 alpha:1.0];
        _selectedTitleColor = [UIColor colorWithRed:255.0/255.0 green:0.0/255.0 blue:121/255.0 alpha:1.0];
        _segmentHeight = 44.0;
    }
    return self;
}

- (void)setSegmentViewComponent:(DYSegmentViewComponent)segmentViewComponent {
    
    if (segmentViewComponent & DYSegmentViewComponentShowCover) {
        _showCover = YES;
    } else if (segmentViewComponent & DYSegmentViewComponentShowLine) {
        _showLine = YES;
    } else if (segmentViewComponent & DYSegmentViewComponentShowImage) {
        _showImage = YES;
    } else if (segmentViewComponent & DYSegmentViewComponentShowExtraButton) {
        _showExtraButton = YES;
    } else if (segmentViewComponent & DYSegmentViewComponentScaleTitle) {
        _scaleTitle = YES;
    } else if (segmentViewComponent & DYSegmentViewComponentScrollTitle) {
        _scrollTitle = YES;
    } else if (segmentViewComponent & DYSegmentViewComponentBounces) {
        _segmentViewBounces = YES;
    } else if (segmentViewComponent & DYSegmentViewComponentGraduallyChangeTitleColor) {
        _gradualChangeTitleColor = YES;
    } else if (segmentViewComponent & DYSegmentViewComponentAdjustCoverOrLineWidth) {
        _adjustCoverOrLineWidth = YES;
    } else  {
        _autoAdjustTitlesWidth = YES;
    }
}

@end
