//
//  ViewController.m
//  SameMethodInTwoCategory
//
//  Created by fernando on 2017/3/15.
//  Copyright © 2017年 fernando. All rights reserved.
//

#import "ViewController.h"
#import "OneObjectClass.h"
#import "OneObjectClass+First.h"
#import "OneObjectClass+Second.h"
#import <objc/runtime.h>

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    OneObjectClass *oneClass = [[OneObjectClass alloc] init];
    [oneClass methodOfCallingTest];
    
    [self printMethodListOfClass:[OneObjectClass class]];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)printMethodListOfClass:(Class)cls {
    unsigned int methodCount;
    Method *methodList = class_copyMethodList(cls, &methodCount);
    for (int i = 0; i < methodCount; i ++) {
        Method method = methodList[i];
        NSLog(@"method---->%@", NSStringFromSelector(method_getName(method)));
    }
}

@end
