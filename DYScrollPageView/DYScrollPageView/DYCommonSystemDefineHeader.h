//
//  DYCommonSystemDefineHeader.h
//  DYCommenClasses
//
//  Created by admin on 17/7/11.
//  Copyright © 2017年 admin. All rights reserved.
//

#ifndef DYCommonSystemDefineHeader_h
#define DYCommonSystemDefineHeader_h
//强弱引用
#define DYWeakSelf(type)        __weak typeof(type) weak##type = type; // weak
#define DYStrongSelf(type)      __strong typeof(type) type = weak##type; // strong

//屏幕尺寸
#define DYScreenH                [UIScreen mainScreen].bounds.size.height
#define DYScreenW                [UIScreen mainScreen].bounds.size.width

#define DYiphone5                ((DYScreenW == 320) ? 1 : 0)
#define DYiphone6                ((DYScreenW == 375) ? 1 : 0)
#define DYiphone6plus            ((DYScreenW == 414) ? 1 : 0)

#define DYiphone5W                320.0
#define DYiphone6W                375.0
#define DYiphone6plusW            414.0

//ratio Length From
#define RatioL_F5(f)             (DYScreenW * ((f)/320.f))
#define RatioL_F6(f)             (DYScreenW * ((f)/375.f))

//real Length 6 and 5 ;ratio for Plus
#define Re6and5_RaP(f)           (DYScreenW > 375 ? (DYScreenW * ((f)/375.f)):(f))



#define DYColor(r,g,b,al)         [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:al]
#define DYColorSame(r)            [UIColor colorWithRed:r/255.0 green:r/255.0 blue:r/255.0 alpha:1]
#define DYColorRGB(rgbValue)      [UIColor colorWithRed:((float)((rgbValue&0xFF0000)>>16))/255.0 green:((float)((rgbValue&0xFF00)>>8))/255.0 blue:((float)(rgbValue&0xFF))/255.0 alpha:1.0]

#define DYPlacehoderColor          DYColorRGB(0xbbbbc2)



#endif /* DYCommonSystemDefineHeader_h */
