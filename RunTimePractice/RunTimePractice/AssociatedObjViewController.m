//
//  AssociatedObjViewController.m
//  RunTimePractice
//
//  Created by fernando on 2017/2/21.
//  Copyright © 2017年 fernando. All rights reserved.
//

#import "AssociatedObjViewController.h"
#import "NSDate+Category.h"

@interface AssociatedObjViewController ()

@end

@implementation AssociatedObjViewController

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    NSLog(@"%s",__func__);
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    NSLog(@"%s",__func__);
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    NSLog(@"%s",__func__);
}

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    NSLog(@"%s",__func__);
}

- (void)viewWillLayoutSubviews {
    [super viewWillLayoutSubviews];
    NSLog(@"%s",__func__);
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    NSLog(@"%s",__func__);
}

- (void)viewDidLoad {
    [super viewDidLoad];
    NSLog(@"%s",__func__);
    // Do any additional setup after loading the view.
    self.navigationItem.title = @"associatedObject";
    self.view.backgroundColor = [UIColor whiteColor];
    NSDate *date = [NSDate date];
    date.year = 2017;
    date.month = 2;
    date.day = 21;
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 300, self.view.frame.size.width, 30)];
    label.textAlignment = NSTextAlignmentCenter;
    label.text = [NSString stringWithFormat:@"%04zd.%02zd.%02zd",date.year, date.month, date.day];
    [self.view addSubview:label];
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
