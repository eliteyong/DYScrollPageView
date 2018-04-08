//
//  DYDemo4ViewController.m
//  DYScrollPageView
//
//  Created by admin on 2018/4/8.
//  Copyright © 2018年 YDY. All rights reserved.
//

#import "DYDemo4ViewController.h"
#import "DYScrollPageView.h"
#import "DYTestViewController.h"

@interface DYDemo4ViewController () <DYScrollPageViewDelegate>

@property (nonatomic, strong) NSArray <NSString *> *titles;
@property (nonatomic, strong) NSArray <UIViewController<DYScrollPageViewChildViewControllerDelegate> *> *childVcs;
@property (nonatomic, weak) DYScrollSegmentView *segmentView;
@property (nonatomic, weak) DYContentView *contentView;

@end

@implementation DYDemo4ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"效果示例";
    //必要的设置, 如果没有设置可能导致内容显示不正常
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.childVcs = [self setupChildVc];
    // 初始化
    [self setupSegmentView];
    [self setupContentView];
}

- (void)setupSegmentView {
    DYSegmentStyle *style = [[DYSegmentStyle alloc] init];
    style.showCover = YES;
    // 不要滚动标题, 每个标题将平分宽度
    style.scrollTitle = NO;
    
    // 渐变
    style.gradualChangeTitleColor = YES;
    // 遮盖背景颜色
    style.coverBackgroundColor = [UIColor whiteColor];
    //标题一般状态颜色 
    style.normalTitleColor = [UIColor colorWithRed:255.0/255.0 green:255.0/255.0 blue:255.0/255.0 alpha:1.0];
    //标题选中状态颜色 --- 注意一定要使用RGB空间的颜色值
    style.selectedTitleColor = [UIColor colorWithRed:235.0/255.0 green:0.0/255.0 blue:0.0/255.0 alpha:1.0];
    
    self.titles = @[@"国内新闻", @"新闻头条"];
    
    // 注意: 一定要避免循环引用!!
    __weak typeof(self) weakSelf = self;
    DYScrollSegmentView *segment = [[DYScrollSegmentView alloc] initWithFrame:CGRectMake(0, 64.0, 160.0, 28.0) segmentStyle:style delegate:self titles:self.titles titleDidClick:^(DYTitleView *titleView, NSInteger index) {
        
        [weakSelf.contentView setContentOffSet:CGPointMake(weakSelf.contentView.bounds.size.width * index, 0.0) animated:YES];
        
    }];
    // 自定义标题的样式
    segment.layer.cornerRadius = 14.0;
    segment.backgroundColor = [UIColor redColor];
    // 当然推荐直接设置背景图片的方式
    //    segment.backgroundImage = [UIImage imageNamed:@"extraBtnBackgroundImage"];
    
    self.segmentView = segment;
    self.navigationItem.titleView = self.segmentView;
}

- (void)setupContentView {
    DYContentView *content = [[DYContentView alloc] initWithFrame:CGRectMake(0.0, 64.0, self.view.bounds.size.width, self.view.bounds.size.height - 64.0) segmentView:self.segmentView parentViewController:self delegate:self];
    self.contentView = content;
    [self.view addSubview:self.contentView];
}

- (NSArray *)setupChildVc {
    
    DYTestViewController *vc1 = [DYTestViewController new];
    vc1.view.backgroundColor = [UIColor redColor];
    
    DYTestViewController *vc2 = [DYTestViewController new];
    vc2.view.backgroundColor = [UIColor greenColor];
    
    NSArray *childVcs = [NSArray arrayWithObjects:vc2, vc1, nil];
    return childVcs;
}


- (NSInteger)numberOfChildViewControllers {
    return self.titles.count;
}




- (UIViewController<DYScrollPageViewChildViewControllerDelegate> *)childViewController:(UIViewController<DYScrollPageViewChildViewControllerDelegate> *)reuseViewController forIndex:(NSInteger)index {
    UIViewController<DYScrollPageViewChildViewControllerDelegate> *childVc = reuseViewController;
    
    if (!childVc) {
        childVc = self.childVcs[index];
    }
    
    return childVc;
}


- (CGRect)frameOfChildControllerForContainer:(UIView *)containerView {
    return  CGRectInset(containerView.bounds, 20, 20);
}

@end
