//
//  UIView+DYFrame.m
//  DYScrollPageView
//
//  Created by admin on 2018/3/28.
//  Copyright © 2018年 YDY. All rights reserved.
//

#import "UIView+DYFrame.h"

@implementation UIView (DYFrame)

- (CGFloat)dy_height {
    return self.frame.size.height;
}

- (CGFloat)dy_width {
    return self.frame.size.width;
}

- (void)setDy_height:(CGFloat)dy_height {
    CGRect frame = self.frame;
    frame.size.height = dy_height;
    self.frame = frame;
}
- (void)setDy_width:(CGFloat)dy_width {
    CGRect frame = self.frame;
    frame.size.width = dy_width;
    self.frame = frame;
}

- (CGFloat)dy_x {
    return self.frame.origin.x;
}

- (void)setDy_x:(CGFloat)dy_x {
    CGRect frame = self.frame;
    frame.origin.x = dy_x;
    self.frame = frame;
}

- (CGFloat)dy_y {
    return self.frame.origin.y;
}

- (void)setDy_y:(CGFloat)dy_y {
    CGRect frame = self.frame;
    frame.origin.y = dy_y;
    self.frame = frame;
}

- (void)setDy_centerX:(CGFloat)dy_centerX {
    CGPoint center = self.center;
    center.x = dy_centerX;
    self.center = center;
}

- (CGFloat)dy_centerX {
    return self.center.x;
}

- (void)setDy_centerY:(CGFloat)dy_centerY {
    CGPoint center = self.center;
    center.y = dy_centerY;
    self.center = center;
}

- (CGFloat)dy_centerY {
    return self.center.y;
}

@end
