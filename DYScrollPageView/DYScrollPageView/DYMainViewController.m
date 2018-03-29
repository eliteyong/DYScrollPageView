//
//  DYMainViewController.m
//  DYScrollPageView
//
//  Created by admin on 2018/3/28.
//  Copyright © 2018年 YDY. All rights reserved.
//

#import "DYMainViewController.h"
#import "DYScrollPageViewDelegate.h"

@interface DYMainViewController () <UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSArray *dataArray;

@end

@implementation DYMainViewController

#pragma mark --- 生命周期
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupNavgationBar];
    
    [self setUpMainView];
}


#pragma mark --- 创建视图
//navigation
- (void)setupNavgationBar {
    self.view.backgroundColor = [UIColor whiteColor];
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.navigationItem.title = @"";
    
}

- (void)setUpMainView {
    
}


//- (UITableView *)tableView {
//    if (_tableView == nil) {
//        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, f_Device_w, f_Device_h - 49) style:UITableViewStyleGrouped];
//        _tableView.delegate = self;
//        _tableView.dataSource = self;
//        _tableView.separatorStyle  = UITableViewCellSeparatorStyleNone;
//        _tableView.showsVerticalScrollIndicator = NO;
//    }
//    return _tableView;
//}


@end
