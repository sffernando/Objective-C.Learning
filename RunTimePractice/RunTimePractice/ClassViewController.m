//
//  ClassViewController.m
//  RunTimePractice
//
//  Created by fernando on 2016/12/29.
//  Copyright © 2016年 fernando. All rights reserved.
//

#import "ClassViewController.h"
#import <objc/objc-runtime.h>
#import <objc/NSObjCRuntime.h>

@interface Father : NSObject

@end
@implementation Father



@end
@interface Son : Father

@end

@implementation Son


@end

@interface ClassViewController () {
    NSArray *itemList;
    Father *father;
    Son *son;
}

@end

@implementation ClassViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    /*
    self 是类的隐藏的参数，指向当前调用方法的类，另一个隐藏参数是 _cmd，代表当前类方法的 selector。这里只关注这个 self。super 是个啥？super 并不是隐藏的参数，它只是一个“编译器指示符”，它和 self 指向的是相同的消息接收者，拿上面的代码为例，不论是用 [self setName] 还是 [super setName]，接收“setName”这个消息的接收者都是 PersonMe* me 这个对象。不同的是，super 告诉编译器，当调用 setName 的方法时，要去调用父类的方法，而不是本类里的。
    
    当使用 self 调用方法时，会从当前类的方法列表中开始找，如果没有，就从父类中再找；而当使用 super 时，则从父类的方法列表中开始找。然后调用父类的这个方法
    */
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
     self.navigationItem.title = @"self & super";
    father = [[Father alloc] init];
    son = [[Son alloc] init];
    
    
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"reuseIdentifier"];
    
    NSString *str1 = [NSString stringWithFormat:@"self's className is [%@]",NSStringFromClass([self class])];
    NSString *str2 = [NSString stringWithFormat:@"super's className is [%@]",NSStringFromClass([super class])];
    NSString *str3 = [NSString stringWithFormat:@"self's superClassName is [%@]",NSStringFromClass([self superclass])];
    NSString *str4 = [NSString stringWithFormat:@"super's superClassName is [%@]",NSStringFromClass([super superclass])];
    NSString *str5 = [NSString stringWithFormat:@"Son's className is [%@]",NSStringFromClass([Son class])];
    NSString *str6 = [NSString stringWithFormat:@"Father's className is [%@]",NSStringFromClass([Father class])];
    NSString *str7 = [NSString stringWithFormat:@"Sone's superClassName is [%@]",NSStringFromClass([Son superclass])];
    NSString *str8 = [NSString stringWithFormat:@"Father's superClassName is [%@]",NSStringFromClass([Father superclass])];
    NSString *str9 = [NSString stringWithFormat:@"NSObject's className is [%@]",NSStringFromClass([NSObject class])];
    NSString *str10 = [NSString stringWithFormat:@"NSObject's superClassName is [%@]",NSStringFromClass([NSObject superclass])];
    
    NSString *str11 = [NSString stringWithFormat:@"[Son class]isKindOfClass:[NSObject class]%d",[(id)[Son class] isKindOfClass:[NSObject class]]];
    NSString *str12 = [NSString stringWithFormat:@"[Son class]isMOClass:[NSObject class]%d",[(id)[Son class] isMemberOfClass:[NSObject class]]];
    NSString *str13 = [NSString stringWithFormat:@"[Son class]isKindOfClass:[Father class]%d",[(id)[Son class] isKindOfClass:[Father class]]];
    NSString *str14 = [NSString stringWithFormat:@"[Son class]isMemberOfClass:[Father class]%d",[(id)[Son class] isMemberOfClass:[Father class]]];
    NSString *str15 = [NSString stringWithFormat:@"son isKindOfClass:[NSObject class]%d",[son isKindOfClass:[NSObject class]]];
    NSString *str16 = [NSString stringWithFormat:@"son isMemberOfClass:[NSObject class]%d",[son isMemberOfClass:[NSObject class]]];
    NSString *str17 = [NSString stringWithFormat:@"son isKindOfClass:[Father class]%d",[son isKindOfClass:[Father class]]];
    NSString *str18 = [NSString stringWithFormat:@"son isMemberOfClass:[Father class]%d",[son isMemberOfClass:[Father class]]];
    itemList = @[str1, str2, str3, str4, str5, str6, str7, str8, str9, str10, str11, str12, str13, str14, str15, str16, str17, str18];
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


/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
