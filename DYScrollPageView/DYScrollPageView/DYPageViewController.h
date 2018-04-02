//
//  DYPageViewController.h
//  DYScrollPageView
//
//  Created by admin on 2018/4/2.
//  Copyright © 2018年 YDY. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol DYPageViewControllerDelegate <NSObject>

- (void)scrollViewIsScrolling:(UIScrollView *)scrollView;

@end

@interface DYPageViewController : UIViewController

@property (nonatomic, weak) id <DYPageViewControllerDelegate> delegate;

@property (nonatomic, strong) UIScrollView *scrollView;

@end
