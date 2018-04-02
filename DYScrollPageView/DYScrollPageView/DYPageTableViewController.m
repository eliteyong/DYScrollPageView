//
//  DYPageTableViewController.m
//  DYScrollPageView
//
//  Created by admin on 2018/4/2.
//  Copyright © 2018年 YDY. All rights reserved.
//

#import "DYPageTableViewController.h"

@interface DYPageTableViewController () <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, assign) NSInteger index;

@end

static NSString *const cellID = @"DYPageTableViewControllerCellID";

@implementation DYPageTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)dy_viewDidLoadForIndex:(NSInteger)index {
    self.tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:cellID];
    self.data = [NSArray array];
    [self.view addSubview:self.tableView];
}

- (void)dy_viewDidAppearForIndex:(NSInteger)index {
    self.index = index;
    NSLog(@"已经出现  标题: --- %@  index: -- %ld", self.title, index);
    
    if (index % 2 == 0) {
        self.view.backgroundColor = [UIColor blueColor];
    } else {
        self.view.backgroundColor = [UIColor redColor];
    }
    
    self.data = @[@"测试0",@"测试1",@"测试2",@"测试3",@"测试4",@"测试5",@"测试6",@"测试7",@"测试8",@"测试9",@"测试10",];
    [self.tableView reloadData];
}

#pragma mark --- UITableViewDelegate and DataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.data.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID forIndexPath:indexPath];
    cell.textLabel.text = [NSString stringWithFormat:@"这是第%ld个页面，第%ld条数据。----%@",self.index,indexPath.row,self.data[indexPath.row]];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    NSLog(@"点击了%ld行----", indexPath.row);
}

@end
