//
//  OneObjectClass+Second.m
//  SameMethodInTwoCategory
//
//  Created by fernando on 2017/3/15.
//  Copyright © 2017年 fernando. All rights reserved.
//

#import "OneObjectClass+Second.h"

@implementation OneObjectClass (Second)

- (void)methodOfCallingTest {
    NSLog(@"OneObjectClass+Second %@ %@ +++%s+++", NSStringFromClass([self class]), NSStringFromClass([super class]), __func__);
}

@end
