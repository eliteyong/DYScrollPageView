//
//  DYDemo1ViewController.m
//  DYScrollPageView
//
//  Created by admin on 2018/4/2.
//  Copyright © 2018年 YDY. All rights reserved.
//

#import "DYDemo1ViewController.h"

#import "DYScrollPageView.h"
#import "DYPageTableViewController.h"

@interface DYDemo1ViewController () <DYScrollPageViewDelegate>

@property (nonatomic, strong) NSArray <NSString *> *titles;

@end

@implementation DYDemo1ViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"效果示例";
    //必要的设置, 如果没有设置可能导致内容显示不正常
    self.automaticallyAdjustsScrollViewInsets = NO;
    DYSegmentStyle *style = [[DYSegmentStyle alloc] init];
    //缩放标题
    style.scaleTitle = YES;
    //显示滚动条
    style.showLine = YES;
    //颜色渐变
    style.gradualChangeTitleColor = YES;
    
    self.titles = @[@"新闻头条",@"国际要闻",@"体育",@"中国足球",@"汽车",@"囧途旅游",@"幽默搞笑",@"视频",@"无厘头",@"今日房价",@"头像",];
    //初始化
    DYScrollPageView *scrollPageView = [[DYScrollPageView alloc] initWithFrame:CGRectMake(0, 64.0, self.view.bounds.size.width, self.view.bounds.size.height - 64.0) segmentStyle:style titles:self.titles parentViewController:self delegate:self];
    //这里可以设置头部视图的属性(背景色, 圆角, 背景图片...)
//    scrollPageView.segmentView.backgroundColor = [UIColor blackColor];
    [self.view addSubview:scrollPageView];
}

#pragma mark --- DYScollPageViewDelegate

- (NSInteger)numberOfChildViewControllers {
    return self.titles.count;
}

- (UIViewController<DYScrollPageViewChildViewControllerDelegate> *)childViewController:(UIViewController<DYScrollPageViewChildViewControllerDelegate> *)reuseViewController forIndex:(NSInteger)index {
    UIViewController <DYScrollPageViewChildViewControllerDelegate> *chileVc = reuseViewController;
    if (!chileVc) {
        chileVc = [[DYPageTableViewController alloc] init];
        chileVc.title = self.titles[index];
    }
    return chileVc;
}

- (void)scrollPageController:(UIViewController *)scrollPageController childViewControllWillAppear:(UIViewController *)childViewController forIndex:(NSInteger)index {
    NSLog(@"%ld ---将要出现",index);
}

- (void)scrollPageController:(UIViewController *)scrollPageController childViewControllDidAppear:(UIViewController *)childViewController forIndex:(NSInteger)index {
    NSLog(@"%ld ---已经出现",index);
}

- (void)scrollPageController:(UIViewController *)scrollPageController childViewControllWillDisappear:(UIViewController *)childViewController forIndex:(NSInteger)index {
    NSLog(@"%ld ---将要消失",index);
}

- (void)scrollPageController:(UIViewController *)scrollPageController childViewControllDidDisappear:(UIViewController *)childViewController forIndex:(NSInteger)index {
    NSLog(@"%ld ---已经消失",index);
}


@end
