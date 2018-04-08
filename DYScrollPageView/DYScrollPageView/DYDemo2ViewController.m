//
//  DYDemo2ViewController.m
//  DYScrollPageView
//
//  Created by admin on 2018/4/8.
//  Copyright © 2018年 YDY. All rights reserved.
//

#import "DYDemo2ViewController.h"
#import "DYScrollPageView.h"
#import "DYTestViewController.h"

@interface DYDemo2ViewController () <DYScrollPageViewDelegate>

@property (nonatomic, strong) NSArray <NSString *> *titles;
@property (nonatomic, strong) NSArray <UIViewController *> *childVcs;
@property (nonatomic, strong) DYScrollPageView *scrollPageView;

@end

@implementation DYDemo2ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"效果示例";
    //必要的设置, 如果没有设置可能导致内容显示不正常
    self.automaticallyAdjustsScrollViewInsets = NO;
    DYSegmentStyle *style = [[DYSegmentStyle alloc] init];
    //缩放标题
    style.scaleTitle = YES;
    //颜色渐变
    style.gradualChangeTitleColor = YES;
    //是否显示滚动条
    style.showLine = YES;
    //滚动条颜色和高度
    style.scrollLineColor = [UIColor colorWithRed:21.0/255.0 green:182.0/255.0 blue:185/255.0 alpha:1.0];
    style.scrollLineHeight = 2;
    //设置选中颜色和平时颜色
    style.normalTitleColor = [UIColor colorWithRed:153.0/255.0 green:153.0/255.0 blue:153.0/255.0 alpha:1.0];
    style.selectedTitleColor = [UIColor colorWithRed:21.0/255.0 green:182.0/255.0 blue:185/255.0 alpha:1.0];
    
    //字体大小
    style.titleFont = [UIFont systemFontOfSize:15];
    //字体缩放倍数
    style.titleBigScale = 1.1;
    
    self.titles = @[@"新闻头条",@"国际要闻",@"体育",@"中国足球",@"汽车",@"囧途旅游",@"幽默搞笑",@"视频",@"无厘头",@"今日房价",@"头像",];
    //初始化
    self.scrollPageView = [[DYScrollPageView alloc] initWithFrame:CGRectMake(0, 64.0, self.view.bounds.size.width, self.view.bounds.size.height - 64.0) segmentStyle:style titles:self.titles parentViewController:self delegate:self];
    //这里可以设置头部视图的属性(背景色, 圆角, 背景图片...)
    //    scrollPageView.segmentView.backgroundColor = [UIColor blackColor];
    [self.view addSubview:self.scrollPageView];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"标题更换" style:UIBarButtonItemStylePlain target:self action:@selector(rightBarButtonItemClick)];
}

- (void)rightBarButtonItemClick {
    
    self.titles = [self setupNewTitles];
    // 传入新的titles同时reload
    [self.scrollPageView reloadWithNewTitles:self.titles];
}
- (NSArray *)setupNewTitles {
    
    NSMutableArray *tempt = [NSMutableArray array];
    for (int  i = 0; i < 20; i ++) {
        [tempt addObject:[NSString stringWithFormat:@"新标题%d",i]];
    }
    
    return tempt;
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
