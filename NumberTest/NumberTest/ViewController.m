//
//  ViewController.m
//  NumberTest
//
//  Created by fernando on 2017/3/9.
//  Copyright © 2017年 fernando. All rights reserved.
//

#import "ViewController.h"
#import "NSArray+BinarySort.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
//    NSLog(@"%lu", sizeof(NSInteger));
//    NSLog(@"%ld", NSIntegerMax);
//    NSLog(@"%ld", NSIntegerMin);
    [self testSort];
    
    }

- (void)testSort {
    NSInteger num = 0;
    NSMutableArray *array = [NSMutableArray array];
    for (int i = 0; i < 1024; i ++) {
        int delX = 1 + arc4random() % 9;
        num += delX;
        [array addObject:@(num)];
    }
    
    NSInteger target = [array[309] integerValue];
    
    NSInteger result = [array indexOfGivenValue:target];
    if (result == -1) {
        NSLog(@"没有这个数");
    } else {
        NSLog(@"这个数的下标是============%zd", result);
    }
}

- (void)testGCD {
    dispatch_queue_t queue1 = dispatch_queue_create("test.queue1", DISPATCH_QUEUE_SERIAL);
    dispatch_queue_t queue2 = dispatch_queue_create("test.queue2", DISPATCH_QUEUE_SERIAL);
    dispatch_queue_t tmp1 = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_LOW, 0);
    dispatch_queue_t tmp2 = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0);
    
    dispatch_set_target_queue(queue1, tmp1);
    dispatch_set_target_queue(queue2, tmp2);
    
    
    //    dispatch_queue_attr_t attr = dispatch_queue_attr_make_with_qos_class(DISPATCH_QUEUE_SERIAL, QOS_CLASS_BACKGROUND, 0);
    //    dispatch_queue_t queue1 = dispatch_queue_create("test.1", attr);
    //
    //    dispatch_queue_attr_t attr2 = dispatch_queue_attr_make_with_qos_class(DISPATCH_QUEUE_SERIAL, QOS_CLASS_USER_INITIATED, 0);
    //    dispatch_queue_t queue2 = dispatch_queue_create("test.2", attr2);
    //
    dispatch_queue_t gl1 = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0);
    dispatch_queue_t gl2 = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0);
    //    dispatch_set_target_queue(queue1,gl2);
    NSLog(@"******************************************");
    NSLog(@"global %p",gl1);
    NSLog(@"global %p",gl2);
    NSLog(@"******************************************");
    
    for (int i = 0; i < 20; i ++) {
        dispatch_async(queue1, ^{
            NSThread *curThread = [NSThread currentThread];
            double curPrior = curThread.threadPriority;
            for (int j = 0; j < 100; j ++) {
                int var = 0;
                var ++;
            }
            NSLog(@"default cur:%@---->prior:%f--->data:%d",curThread,curPrior,i);
        });
        dispatch_async(queue2, ^{
            NSThread *curThread = [NSThread currentThread];
            double curPrior = curThread.threadPriority;
            for (int j = 0; j < 100; j ++) {
                int var = 0;
                var ++;
            }
            NSLog(@"global cur:%@++++>prior:%f+++>data:%d",curThread,curPrior,i);
        });
    };

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
