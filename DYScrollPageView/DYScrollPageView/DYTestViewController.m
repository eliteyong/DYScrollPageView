//
//  DYTestViewController.m
//  DYScrollPageView
//
//  Created by admin on 2018/4/8.
//  Copyright © 2018年 YDY. All rights reserved.
//

#import "DYTestViewController.h"

@interface DYTestViewController ()

@end

@implementation DYTestViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSInteger R = (arc4random() % 256);
    NSInteger G = (arc4random() % 256);
    NSInteger B = (arc4random() % 256);
    
    self.view.backgroundColor = [UIColor colorWithRed:R/255.0 green:G/255.0 blue:B/255.0 alpha:1];
}



@end
