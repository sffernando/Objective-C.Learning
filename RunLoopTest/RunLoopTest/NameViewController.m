//
//  NameViewController.m
//  RunLoopTest
//
//  Created by fernando on 2017/2/26.
//  Copyright © 2017年 fernando. All rights reserved.
//

#import "NameViewController.h"

@interface NameViewController ()
{
    NSThread *thread1;
    NSThread *thread2;
    NSThread *thread3;
}
@end

@implementation NameViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    
    NSThread *thread = [NSThread currentThread];
    NSLog(@"currentThread = %p", thread);
    
    NSRunLoop *runloop = [NSRunLoop currentRunLoop];
    
    thread1 = [[NSThread alloc] initWithTarget:self selector:@selector(test) object:nil];
    [thread1 start];
    
    thread2 = [[NSThread alloc] initWithTarget:self selector:@selector(test1) object:nil];
    [thread2 start];
}

- (void)test {
    NSRunLoop *runloop1 = [NSRunLoop currentRunLoop];
    NSLog(@"currentThread = %p", thread1);
    NSLog(@"currentrunloop1 11111 = %p", runloop1);
    NSLog(@"1111111");
    [thread1 cancel];
}

- (void)test1 {
    NSRunLoop *runloop1 = [NSRunLoop currentRunLoop];
    NSLog(@"currentThread = %p", thread2);
    NSLog(@"currentrunloop1 22222 = %p", runloop1);
    NSLog(@"22222");
    
    thread3 = [[NSThread alloc] initWithTarget:self selector:@selector(test2) object:nil];
    [thread3 start];
}

- (void)test2 {
    NSRunLoop *runloop1 = [NSRunLoop currentRunLoop];
    NSLog(@"currentThread = %p", thread3);
    NSLog(@"currentrunloop1 3333 = %p", runloop1);
    NSLog(@"3333");
    [thread2 cancel];
    [thread3 cancel];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
