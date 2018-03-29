//
//  DYTitleView.m
//  DYScrollPageView
//
//  Created by admin on 2018/3/28.
//  Copyright © 2018年 YDY. All rights reserved.
//

#import "DYTitleView.h"

@interface DYTitleView () {
    CGSize _titleSize;
    CGFloat _imageHeight;
    CGFloat _imageWidth;
    BOOL _isShowImage;
}
@property (nonatomic, strong) UIImageView *imageView;
@property (nonatomic, strong) UILabel *label;
@property (nonatomic, strong) UIView *contentView;
/** 
 添加badge 
 */
@property (nonatomic) UIView *badgeView;

@end

@implementation DYTitleView

- (instancetype)init {
    self = [self initWithFrame:CGRectZero];
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.currentTransformSx = 1.0;
        self.userInteractionEnabled = YES;
        self.backgroundColor = [UIColor clearColor];
        _isShowImage = NO;
        [self addSubview:self.label];
    }
    return self;
}

- (void)setCurrentTransformSx:(CGFloat)currentTransformSx {
    _currentTransformSx = currentTransformSx;
    self.transform = CGAffineTransformMakeScale(currentTransformSx, currentTransformSx);
}

- (void)layoutSubviews {
    [super layoutSubviews];
    if (!_isShowImage) {
        self.label.frame = self.bounds;
    }
}

- (void)adjustSubviewFrame {
    _isShowImage = YES;
    
    CGRect contentViewFrame = self.bounds;
    contentViewFrame.size.width = [self titleViewWidth];
    contentViewFrame.origin.x = (self.frame.size.width - contentViewFrame.size.width)/2;
    self.contentView.frame = contentViewFrame;
    self.label.frame = self.contentView.bounds;
    
    [self addSubview:self.contentView];
    [self.label removeFromSuperview];
    [self.contentView addSubview:self.label];
    [self.contentView addSubview:self.imageView];
    
    switch (self.imagePosition) {
        case DYTitleImagePositionTop: {
            CGRect contentViewFrame = self.contentView.frame;
            contentViewFrame.size.height = _imageHeight + _titleSize.height;
            contentViewFrame.origin.y = (self.frame.size.height - contentViewFrame.size.height)*0.5;
            self.contentView.frame = contentViewFrame;
            
            self.imageView.frame = CGRectMake(0, 0, _imageWidth, _imageHeight);
            CGPoint center = self.imageView.center;
            center.x = self.label.center.x;
            self.imageView.center = center;
            
            CGFloat labelHeight = self.contentView.frame.size.height - _imageHeight;
            CGRect labelFrame = self.label.frame;
            labelFrame.origin.y = _imageHeight;
            labelFrame.size.height = labelHeight;
            self.label.frame = labelFrame;
        } break;
        case DYTitleImagePositionLeft: {
            
            CGRect labelFrame = self.label.frame;
            labelFrame.origin.x = _imageWidth;
            labelFrame.size.width = self.contentView.frame.size.width - _imageWidth;
            self.label.frame = labelFrame;
            
            CGRect imageFrame = CGRectZero;
            imageFrame.size.height = _imageHeight;
            imageFrame.size.width = _imageWidth;
            imageFrame.origin.y = (self.contentView.frame.size.height - imageFrame.size.height)/2;
            self.imageView.frame = imageFrame;
        } break;
        case DYTitleImagePositionRight: {
            CGRect labelFrame = self.label.frame;
            labelFrame.size.width = self.contentView.frame.size.width - _imageWidth;
            self.label.frame = labelFrame;
            
            CGRect imageFrame = CGRectZero;
            imageFrame.origin.x = CGRectGetMaxX(self.label.frame);
            imageFrame.size.height = _imageHeight;
            imageFrame.size.width = _imageWidth;
            imageFrame.origin.y = (self.contentView.frame.size.height - imageFrame.size.height)/2;
            self.imageView.frame = imageFrame;
        } break;
        case DYTitleImagePositionCenter: {
            self.imageView.frame = self.contentView.bounds;
            [self.label removeFromSuperview];
        } break;
        default:
            break;
    }
}


- (CGFloat)titleViewWidth {
    CGFloat width = 0.0f;
    switch (self.imagePosition) {
        case DYTitleImagePositionLeft:
            width = _imageWidth + _titleSize.width;
            break;
        case DYTitleImagePositionRight:
            width = _imageWidth + _titleSize.width;
            break;
        case DYTitleImagePositionCenter:
            width = _imageWidth;
            break;
        default:
            width = _titleSize.width;
            break;
    }
    return width;
}


- (void)setNormalImage:(UIImage *)normalImage {
    _normalImage = normalImage;
    _imageWidth = normalImage.size.width;
    _imageHeight = normalImage.size.height;
    self.imageView.image = normalImage;
}

- (void)setSelectedImage:(UIImage *)selectedImage {
    _selectedImage = selectedImage;
    self.imageView.highlightedImage = selectedImage;
}

- (void)setFont:(UIFont *)font {
    _font = font;
    self.label.font = font;
}

- (void)setText:(NSString *)text {
    _text = text;
    self.label.text = text;
    CGRect bounds = [text boundingRectWithSize:CGSizeMake(MAXFLOAT, 0.0) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName: self.label.font} context:nil];
    _titleSize = bounds.size;
    
}

- (void)setTextColor:(UIColor *)textColor {
    _textColor = textColor;
    self.label.textColor = textColor;
}

- (void)setSelected:(BOOL)selected {
    _selected = selected;
    self.imageView.highlighted = selected;
}

- (UIImageView *)imageView {
    if (_imageView == nil) {
        _imageView = [[UIImageView alloc] init];
        _imageView.contentMode = UIViewContentModeCenter;
    }
    return _imageView;
}

- (UILabel *)label {
    if (_label == nil) {
        _label = [[UILabel alloc] init];
        _label.textAlignment = NSTextAlignmentCenter;
    }
    return _label;
}

- (UIView *)contentView {
    if (!_contentView) {
        _contentView = [UIView new];
    }
    return _contentView;
}

@end
