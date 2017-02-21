//
//  NSDate+Category.m
//  RunTimePractice
//
//  Created by fernando on 2017/2/21.
//  Copyright © 2017年 fernando. All rights reserved.
//

#import "NSDate+Category.h"
#import <objc/runtime.h>

static const char *yearKey = "year";
static const char *monthKey = "month";
static const char *dayKey = "day";

@implementation NSDate (Category)

- (NSInteger)year {
    NSNumber *num = objc_getAssociatedObject(self, yearKey);
    return num.integerValue;
}

- (void)setYear:(NSInteger)year {
    objc_setAssociatedObject(self, yearKey, [NSNumber numberWithInteger:year], OBJC_ASSOCIATION_ASSIGN);
}

- (NSInteger)month {
    NSNumber *num = objc_getAssociatedObject(self, monthKey);
    return num.integerValue;
}

- (void)setMonth:(NSInteger)month {
    NSNumber *num = [NSNumber numberWithInteger:month];
    objc_setAssociatedObject(self, monthKey, num, OBJC_ASSOCIATION_ASSIGN);
}

- (NSInteger)day {
    NSNumber *num = objc_getAssociatedObject(self, dayKey);
    return num.integerValue;
}

- (void)setDay:(NSInteger)day {
    NSNumber *num = [NSNumber numberWithInteger:day];
    objc_setAssociatedObject(self, dayKey, num, OBJC_ASSOCIATION_ASSIGN);
}
@end
