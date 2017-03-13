//
//  NSArray+BinarySort.m
//  NumberTest
//
//  Created by fernando on 2017/3/12.
//  Copyright © 2017年 fernando. All rights reserved.
//

#import "NSArray+BinarySort.h"

@implementation NSArray (BinarySort)

- (NSInteger)indexOfGivenValue:(NSInteger)targetNum {
    if (self.count <= 0) {
        return -1;
    }
    
    NSInteger count = 0;
    
    int low = 0;
    int high = (int)self.count - 1;
    int mid = 0;
    
    while (low +1 < high) {
        
        count += 1;
        NSLog(@"我是第++++%ld++++次查询", count);
        
        mid = (low + high)/2;
        if ([self[mid] integerValue] == targetNum) {
            return mid;
        } else if ([self[mid] integerValue] > targetNum) {
            high = mid;
        } else {
            low = mid;
        }
    }
    
    return -1;
}

@end
