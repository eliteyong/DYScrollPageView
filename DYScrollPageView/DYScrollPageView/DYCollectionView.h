//
//  DYCollectionView.h
//  DYScrollPageView
//
//  Created by admin on 2018/3/28.
//  Copyright © 2018年 YDY. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DYCollectionView : UICollectionView

typedef BOOL(^DYScrollViewShouldBeginPanGestureHandler)(DYCollectionView *collectionView, UIPanGestureRecognizer *panGesture);

- (void)setupScrollViewShouldBeginPanGestureHandler:(DYScrollViewShouldBeginPanGestureHandler)gestureBeginHandler;


@end
