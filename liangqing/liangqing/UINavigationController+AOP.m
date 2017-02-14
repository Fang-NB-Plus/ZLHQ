//
//  UINavigationController+AOP.m
//  liangqing
//
//  Created by Macbook 13.3 on 2017/2/4.
//  Copyright © 2017年 方正泉. All rights reserved.
//

#import "UINavigationController+AOP.h"
#import <objc/runtime.h>

@implementation UIViewController (AOP)
+ (void)load{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        Class class = [self class];
        swizzleMethod(class, @selector(viewDidLoad), @selector(aop_viewDidload));
        swizzleMethod(class, @selector(viewWillAppear:), @selector(aop_viewWillAppear:));
    });

}
/*
//方法交换
void swizzleMethod(Class class, SEL originalSelector, SEL swizzledSelector)  {
    Method originalMethod = class_getInstanceMethod(class, originalSelector);
    Method swizzledMethod = class_getInstanceMethod(class, swizzledSelector);
    BOOL didAddMethod =
    class_addMethod(class,
                    originalSelector,
                    method_getImplementation(swizzledMethod),
                    method_getTypeEncoding(swizzledMethod));
    
    if (didAddMethod) {
        class_replaceMethod(class,
                            swizzledSelector,
                            method_getImplementation(originalMethod),
                            method_getTypeEncoding(originalMethod));
    } else {
        method_exchangeImplementations(originalMethod, swizzledMethod);
    }
}*/

void swizzleMethod (Class class,SEL originalSEL,SEL swizzleSEL){
    
    Method original = class_getInstanceMethod(class, originalSEL);
    Method swizzled = class_getInstanceMethod(class,  swizzleSEL);
    
    BOOL DidAddMethod = class_addMethod(class,
                                        originalSEL,
                                        method_getImplementation(swizzled),
                                        method_getTypeEncoding(swizzled));
    if (DidAddMethod) {
        class_replaceMethod(class, swizzleSEL, method_getImplementation(original), method_getTypeEncoding(original));
    }else{
        method_exchangeImplementations(original, swizzled);
    }
    
}
- (void)aop_viewDidload{
    
    [self aop_viewDidload];

    
}
- (void)aop_viewWillAppear:(BOOL)animated{
    [self aop_viewWillAppear:animated];

}

@end
