//
//  designAlerView.h
//  liangqing
//
//  Created by Macbook 13.3 on 2017/2/14.
//  Copyright © 2017年 方正泉. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^myblock)(NSInteger);

@interface designAlerView : UIView

+(instancetype)alertcontent:(void(^)(NSInteger a))btnblock;

@end
