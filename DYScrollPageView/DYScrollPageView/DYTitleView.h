//
//  DYTitleView.h
//  DYScrollPageView
//
//  Created by admin on 2018/3/28.
//  Copyright © 2018年 YDY. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DYSegmentStyle.h"

@interface DYTitleView : UIView

@property (nonatomic, assign) CGFloat currentTransformSx;
@property (nonatomic, assign) DYTitleImagePosition imagePosition;

@property (nonatomic, strong) NSString *text;
@property (nonatomic, strong) UIColor *textColor;
@property (nonatomic, strong) UIFont *font;
@property (nonatomic, assign, getter=isSelected) BOOL selected;
@property (nonatomic, strong) UIImage *normalImage;
@property (nonatomic, strong) UIImage *selectedImage;

@property (nonatomic, strong, readonly) UIImageView *imageView;
@property (nonatomic, strong, readonly) UILabel *label;

- (CGFloat)titleViewWidth;
- (void)adjustSubviewFrame;

@end
