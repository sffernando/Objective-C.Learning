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

@property (nonatomic, assign) NSInteger test;
@property(nonatomic, copy) NSMutableArray *array;


@end

@implementation ViewController

- (void)dealloc
{
    [self removeObserver:self forKeyPath:@"test"];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(100, 200, 100, 44);
    button.backgroundColor = [UIColor redColor];
    [self.view addSubview:button];
    [button addTarget:self action:@selector(ooo) forControlEvents:UIControlEventTouchUpInside];
    [self addObserver:self forKeyPath:@"test" options:NSKeyValueObservingOptionNew|NSKeyValueObservingOptionOld context:nil];
//    NSLog(@"%lu", sizeof(NSInteger));
//    NSLog(@"%ld", NSIntegerMax);
//    NSLog(@"%ld", NSIntegerMin);
    [self testSort];
    [self testApply];
    
//    self.array = [NSMutableArray array];
    [self.array addObject:@1];
    [self.array insertObject:@10 atIndex:0];
    [self.array exchangeObjectAtIndex:0 withObjectAtIndex:1];
    
    
    NSArray *a1 = [NSArray new];
    NSArray *a2 = [NSArray new];
    NSArray *aaaa = [NSArray arrayWithObjects:a1,a2, nil];
    NSArray *array2 = [aaaa copy];
    
}

- (NSMutableArray *)array {
    if (!_array) {
        _array = [NSMutableArray array];
    }
    return _array;
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context {
    if ([keyPath isEqualToString:@"test"]) {
        NSLog(@"test ===== %zd", self.test);
    }
}

-(void)ooo {
    self.test = 100;
}


- (void)testApply {
    NSArray *array = @[@1,@2,@3,@4,@5,@6,@7];
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0);
    dispatch_async(queue, ^{
        dispatch_apply([array count], queue, ^(size_t index) {
            NSLog(@"-----%zd", [array[index] integerValue]);
        });
        
        dispatch_async(dispatch_get_main_queue(), ^{
            NSLog(@"done");
        });
    });
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
