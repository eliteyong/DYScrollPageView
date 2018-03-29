//
//  DYScrollPageView.h
//  DYScrollPageView
//
//  Created by admin on 2018/3/28.
//  Copyright © 2018年 YDY. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIView+DYFrame.h"
#import "DYContentView.h"
#import "DYTitleView.h"

typedef void(^ExtraBtnOnClick)(UIButton *extraBtn);

@interface DYScrollPageView : UIView

@property (nonatomic, copy) ExtraBtnOnClick extraBtnOnClick;

@property (nonatomic, weak, readonly) DYContentView *contentView;
@property (nonatomic, weak, readonly) DYScrollSegmentView *segmentView;

@property (nonatomic, weak) id <DYScrollPageViewDelegate> delegate;

@end
