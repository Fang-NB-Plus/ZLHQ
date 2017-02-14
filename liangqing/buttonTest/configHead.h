//
//  configHead.h
//  liangqing
//
//  Created by Macbook 13.3 on 2017/1/24.
//  Copyright © 2017年 方正泉. All rights reserved.
//

#ifndef configHead_h
#define configHead_h

#define SCREENHIGHT [UIScreen mainScreen].bounds.size.height

#define SCREENWIDTH [UIScreen mainScreen].bounds.size.width
#define UIColorFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

#endif /* configHead_h */
