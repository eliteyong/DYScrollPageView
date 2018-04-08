//
//  DYDemo3ViewController.m
//  DYScrollPageView
//
//  Created by admin on 2018/4/8.
//  Copyright © 2018年 YDY. All rights reserved.
//

#import "DYDemo3ViewController.h"
#import "DYScrollPageView.h"
#import "DYTestViewController.h"

@interface DYDemo3ViewController () <DYScrollPageViewDelegate>

@property (nonatomic, strong) NSArray <NSString *> *titles;
@property (nonatomic, strong) NSArray <UIViewController *> *childVcs;
@property (nonatomic, strong) DYScrollPageView *scrollPageView;

@end

@implementation DYDemo3ViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"效果示例";
    //必要的设置, 如果没有设置可能导致内容显示不正常
    self.automaticallyAdjustsScrollViewInsets = NO;
    DYSegmentStyle *style = [[DYSegmentStyle alloc] init];
    //显示遮盖
    style.showCover = YES;
    // 不滚动标题
    style.scrollTitle = NO;
    
    // 根据title总宽度自动调整位置 -- 达到个数少的时候会'平分'的效果, 个数多的时候就是可以滚动的效果 只有当scrollTitle == YES的时候才有效
    style.autoAdjustTitlesWidth = YES;
    // 颜色渐变
    style.gradualChangeTitleColor = YES;
    
    self.titles = @[@"新闻头条",@"国际要闻",@"体育",@"中国足球"];
    //初始化
    self.scrollPageView = [[DYScrollPageView alloc] initWithFrame:CGRectMake(0, 64.0, self.view.bounds.size.width, self.view.bounds.size.height - 64.0) segmentStyle:style titles:self.titles parentViewController:self delegate:self];
    //这里可以设置头部视图的属性(背景色, 圆角, 背景图片...)
    //    scrollPageView.segmentView.backgroundColor = [UIColor blackColor];
    [self.view addSubview:self.scrollPageView];
}


- (NSInteger)numberOfChildViewControllers {
    return self.titles.count;
}

- (UIViewController<DYScrollPageViewChildViewControllerDelegate> *)childViewController:(UIViewController<DYScrollPageViewChildViewControllerDelegate> *)reuseViewController forIndex:(NSInteger)index {
    UIViewController<DYScrollPageViewChildViewControllerDelegate> *childVc = reuseViewController;
    if (!childVc) {
        childVc = [[DYTestViewController alloc] init];
        childVc.title = self.titles[index];
    }
    return childVc;
}


- (BOOL)shouldAutomaticallyForwardAppearanceMethods {
    return NO;
}


@end
