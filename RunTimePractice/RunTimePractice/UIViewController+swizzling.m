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
    Method method1 = class_getInstanceMethod([self class], @selector(viewDidLoad));
    Method method2 = class_getInstanceMethod([self class], @selector(swizzlingViewDidLoad));
    
    method_exchangeImplementations(method1, method2);
}

- (void)swizzlingViewDidLoad {
    NSLog(@"%@ 我在这里交换了", NSStringFromClass([self class]));
}

@end
