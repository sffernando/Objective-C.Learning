//
//  ResolveMethodViewController.m
//  RunTimePractice
//
//  Created by fernando on 2017/3/2.
//  Copyright © 2017年 fernando. All rights reserved.
//

#import "ResolveMethodViewController.h"
#import <objc/runtime.h>

@interface SolveMethod : NSObject
- (void)noThisMethod:(NSString *)value;

- (void)hahaha;
@end

@implementation SolveMethod
- (void)noThisMethod:(NSString *)value {
    NSLog(@"SecondClass中的方法实现%@", value);
}

- (void)hahaha {
    NSLog(@"hahaha");
}
@end

@interface ResolveMethodViewController ()

@end

@implementation ResolveMethodViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    [self performSelector:@selector(hahaha) withObject:@"???"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//运行时方法拦截
- (void)dynamicAddMethod: (NSString *) value {
    NSLog(@"OC替换的方法：%@", value);
}

/**
 没有找到SEL的IML实现时会执行下方的方法
 
 @param sel 当前对象调用并且找不到IML的SEL
 @return 找到其他的执行方法，并返回yes
 */
+ (BOOL)resolveInstanceMethod:(SEL)sel {
    //    return NO;    //当返回NO时，会接着执行forwordingTargetForSelector:方法，
    SEL selector = @selector(dynamicAddMethod:);
    Method met = class_getInstanceMethod([self class], selector);
    class_addMethod([self class], selector, method_getImplementation(met), method_getTypeEncoding(met));
    return YES;
}

- (id)forwardingTargetForSelector:(SEL)aSelector {
    //    return self;
    return [SolveMethod new];   //让SecondClass中相应的SEL去执行该方法
}

- (NSMethodSignature *)methodSignatureForSelector:(SEL)selector {
    //查找父类的方法签名
    NSMethodSignature *signature = [super methodSignatureForSelector:selector];
    if(signature == nil) {
        //        NSString *sel = NSStringFromSelector(selector);
        signature = [NSMethodSignature signatureWithObjCTypes:"@@:"];
        
    }
    return signature;
}

- (void)forwardInvocation:(NSInvocation *)invocation {
    //拿到函数名
    NSString *key = NSStringFromSelector([invocation selector]);
    NSLog(@"%@", key);
}


@end
