//
//  DYMainViewController.m
//  DYScrollPageView
//
//  Created by admin on 2018/3/28.
//  Copyright © 2018年 YDY. All rights reserved.
//

#import "DYMainViewController.h"
#import "DYScrollPageViewDelegate.h"

#import "DYDemo1ViewController.h"
#import "DYDemo2ViewController.h"
#import "DYDemo3ViewController.h"
#import "DYDemo4ViewController.h"

@interface DYMainViewController () <UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSArray *dataArray;

/**
 跳转界面的数组
 */
@property (nonatomic, strong) NSArray *pushVcArray;

@end

@implementation DYMainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupNavgationBar];
    
    [self configData];
    
    [self setUpMainView];
}

/**
 navigation
 */
- (void)setupNavgationBar {
    self.view.backgroundColor = [UIColor whiteColor];
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.navigationItem.title = @"效果类型";
    
}

/**
 初始化数据
 */
- (void)configData {
    //@"遮盖+颜色渐变+segmentView没有弹性效果",
    self.dataArray = @[@"缩放+颜色渐变 效果",@"滚动条+颜色渐变 效果",@"标题不滚动+遮盖+颜色渐变 效果",@"自定义segmentView和contentView位置的效果",@"微博&简书个人主页效果"];
    self.pushVcArray = @[@"DYDemo1ViewController",@"DYDemo2ViewController",@"DYDemo3ViewController",@"DYDemo4ViewController",@"DYDemo5ViewController"];
}

/**
 创建视图
 */
- (void)setUpMainView {
    [self.view addSubview:self.tableView];
}

#pragma mark --- UITableViewDelegate and DataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArray.count;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 48;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 0.01;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0.01;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
        
    }
    cell.textLabel.text = self.dataArray[indexPath.row];
    cell.textLabel.font = [UIFont systemFontOfSize:15];
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    [self pushToNextViewControllerWithVcName:[self.pushVcArray objectAtIndex:indexPath.row]];
}

- (void)pushToNextViewControllerWithVcName:(NSString *)vcName {
    UIViewController *vc = [[NSClassFromString(vcName) alloc] init];;
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark --- getter
- (UITableView *)tableView {
    if (_tableView == nil) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, self.view.frame.size.width, self.view.frame.size.height - 64) style:UITableViewStyleGrouped];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.separatorStyle  = UITableViewCellSeparatorStyleSingleLine;
        _tableView.showsVerticalScrollIndicator = NO;
    }
    return _tableView;
}


@end
