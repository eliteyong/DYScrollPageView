//
//  DYPageViewController.m
//  DYScrollPageView
//
//  Created by admin on 2018/4/2.
//  Copyright © 2018年 YDY. All rights reserved.
//

#import "DYPageViewController.h"

@interface DYPageViewController () <UIScrollViewDelegate>

@end

@implementation DYPageViewController

//extern NSString *const DYParentTableViewDidLeaveFromTopNotification;

- (void)viewDidLoad {
    [super viewDidLoad];
    self.automaticallyAdjustsScrollViewInsets = NO;
    //利用通知可以同时修改所有的子控制器的scrollView的contentOffset为CGPointZero
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(leaveFromTop) name:@"DYParentTableViewDidLeaveFromTopNotification" object:nil];
}

- (void)leaveFromTop {
    _scrollView.contentOffset = CGPointZero;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    if (!_scrollView) {
        _scrollView = scrollView;
        //        _scrollView.bounces = NO;
    }
    if (self.delegate && [self.delegate respondsToSelector:@selector(scrollViewIsScrolling:)]) {
        [self.delegate scrollViewIsScrolling:scrollView];
    }
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}


@end
