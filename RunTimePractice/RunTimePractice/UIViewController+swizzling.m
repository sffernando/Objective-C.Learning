//
//  UIViewController+swizzling.m
//  RunTimePractice
//
//  Created by fernando on 2017/2/21.
//  Copyright © 2017年 fernando. All rights reserved.
//

#import "UIViewController+swizzling.h"
#import <objc/runtime.h>

@implementation UIViewController (swizzling)

+ (void)load {

    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        Class class = [self class];
        
        SEL originalSelector = @selector(viewWillAppear:);
        SEL swizzleSelector = @selector(swizzle_viewWillAppear:);
        
        Method originalMethod = class_getInstanceMethod(class, originalSelector);
        Method swizzleMethod = class_getInstanceMethod(class, swizzleSelector);
        
        BOOL didAddMethod = class_addMethod(class, swizzleSelector, method_getImplementation(swizzleMethod), method_getTypeEncoding(swizzleMethod));
        if (didAddMethod) {
            class_replaceMethod(class, swizzleSelector, method_getImplementation(originalMethod), method_getTypeEncoding(originalMethod));
        } else {
            method_exchangeImplementations(originalMethod, swizzleMethod);
        }
        
        SEL selector1 = @selector(viewDidLoad);
        SEL selector2 = @selector(swizzlingViewDidLoad);
        
        Method method1 = class_getInstanceMethod(class, selector1);
        Method method2 = class_getInstanceMethod(class, selector2);
        
        BOOL add = class_addMethod(class, selector1, method_getImplementation(method1), method_getTypeEncoding(method1));
        if (add) {
            class_replaceMethod(class, selector1, method_getImplementation(method2), method_getTypeEncoding(method2));
        } else {
            method_exchangeImplementations(method1, method2);
        }
    });
}

- (void)swizzlingViewDidLoad {
    NSLog(@"%@ swizzlingViewDidLoad我在这里交换了", NSStringFromClass([self class]));
}

- (void)swizzle_viewWillAppear:(BOOL)animated {
    NSLog(@"%@ swizzle_viewWillAppear我在这里交换了", NSStringFromClass([self class]));
}

@end
