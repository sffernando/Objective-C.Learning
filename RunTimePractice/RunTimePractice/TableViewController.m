//
//  TableViewController.m
//  RunTimePractice
//
//  Created by fernando on 2016/12/29.
//  Copyright © 2016年 fernando. All rights reserved.
//

#import "TableViewController.h"
#import "ClassViewController.h"
#import "OperateTableViewController.h"
#import "AssociatedObjViewController.h"
#import "SwizzlingViewController.h"
#import "ResolveMethodViewController.h"


@interface TableViewController () {
    NSArray *itemList;
}

@end

@implementation TableViewController

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
    // Uncomment the following line to preserve selection between presentations.
     self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
     self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    itemList = @[@"class", @"opration", @"ivar & property", @"associatedObject", @"selector", @"method swizzling", @"method resolve"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return itemList.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"reuseIdentifier" forIndexPath:indexPath];
    
    cell.textLabel.text = (NSString *)itemList[indexPath.row];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 0) {
        ClassViewController *c = [[ClassViewController alloc] init];
        [self.navigationController pushViewController:c animated:YES];
    } else if (indexPath.row == 1) {
        OperateTableViewController *c = [[OperateTableViewController alloc] init];
        [self.navigationController pushViewController:c animated:YES];
    } else if (indexPath.row == 5) {
        SwizzlingViewController *c = [[SwizzlingViewController alloc] init];
        [self.navigationController pushViewController:c animated:YES];
    } else if (indexPath.row == 3) {
        AssociatedObjViewController *c = [[AssociatedObjViewController alloc] init];
        [self.navigationController pushViewController:c animated:YES];
    } else if (indexPath.row == 6) {
        ResolveMethodViewController *c = [[ResolveMethodViewController alloc] init];
        [self.navigationController pushViewController:c animated:YES];
    }
}

@end
