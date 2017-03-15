//
//  OneObjectClass+First.m
//  SameMethodInTwoCategory
//
//  Created by fernando on 2017/3/15.
//  Copyright © 2017年 fernando. All rights reserved.
//

#import "OneObjectClass+First.h"

@implementation OneObjectClass (First)

- (void)methodOfCallingTest {
    NSLog(@"OneObjectClass+First %@ %@ +++%s+++", NSStringFromClass([self class]), NSStringFromClass([super class]), __func__);
}

@end
