//
//  OperateTableViewController.m
//  RunTimePractice
//
//  Created by fernando on 2016/12/30.
//  Copyright © 2016年 fernando. All rights reserved.
//

#import "OperateTableViewController.h"
#import <objc/objc-runtime.h>
#import <objc/NSObjCRuntime.h>

@interface OperateTableViewController () {
    NSMutableArray *ivarsList;
    NSMutableArray *propertiesList;
}

@end

@implementation OperateTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    self.navigationItem.title = @"oprate";
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"reuseIdentifier"];
    [self getIvars];
    [self getProperties];
}


- (void)getIvars {
    unsigned int count;
    if (class_addIvar([self class], "rtAddedIvar", sizeof(id), log2(sizeof(id)), "@")) {
        NSLog(@"add ivar success");
    } else {
        NSLog(@"add ivar failed");
    }
    
    Ivar *ivars = class_copyIvarList([self class], &count);
    for (unsigned int i = 0; i < count; i++) {
        Ivar ivar = ivars[i];
        const char *ivarName = ivar_getName(ivar);
        ptrdiff_t offset = ivar_getOffset(ivar);
        const char *type = ivar_getTypeEncoding(ivar);
        NSString *string = [NSString stringWithFormat:@"ivar:%s, offset:%zd, type:%s", ivarName, offset, type];
        if (!ivarsList) {
            ivarsList = [NSMutableArray array];
        }
        NSLog(@"%@", string);
        [ivarsList addObject:string];
    }
}


/*
 (1) 其中property_attribute的相关内容需要说明下。
 
 property_attribute为T@”NSString”、&、N、V_exprice时：
 
 T 是固定的，放在第一个
 @”NSString” 代表这个property是一个字符串对象
 & 代表强引用，其中与之并列的是：’C’代表Copy，’&’代表强引用，’W’表示weak，assign为空，默认为assign。
 N 区分的nonatomic和atomic，默认为atomic，atomic为空，’N’代表是nonatomic
 V_exprice V代表变量，后面紧跟着的是成员变量名，代表这个property的成员变量名为_exprice
 
 
 
 
 property_attribute为T@”NSNumber”、R、N、V_yearsOld时：
 
 T 是固定的，放在第一个
 @”NSNumber” 代表这个property是一个NSNumber对象
 R 代表readOnly属性，readwrite时为空
 N 区分的nonatomic和atomic，默认为atomic，atomic为空，’N’代表是nonatomic
 V_yearsOld V代表变量，后面紧跟着的是成员变量名，代表这个property的成员变量名为_yearsOld。
 */
- (void)getProperties {
    objc_property_attribute_t a1 = {"T", "@\"NSString\""};
    objc_property_attribute_t a2 = {"C", ""};
    objc_property_attribute_t a3 = {"N", ""};
    objc_property_attribute_t a4 = {"V", "_name"};
    
    objc_property_attribute_t atrList[] = {a1, a2, a3, a4};
    
    
    objc_property_attribute_t a11 = {"T", "@\"CGFloat\""};
    objc_property_attribute_t a31 = {"N", ""};
    objc_property_attribute_t a41 = {"V", "_height"};
    
    objc_property_attribute_t atrList1[] = {a11, a31, a41};
    
    
    objc_property_attribute_t a12 = {"T", "@\"id\""};
    objc_property_attribute_t a22 = {"W", ""};
    objc_property_attribute_t a32 = {"N", ""};
    objc_property_attribute_t a42 = {"V", "_delegate"};
    
    objc_property_attribute_t atrList2[] = {a12, a22, a32, a42};
    
    class_addProperty([self class], "name", atrList, 4);
    class_addProperty([self class], "height", atrList1, 3);
    class_addProperty([self class], "delegate", atrList2, 4);
    
    unsigned int count;
    objc_property_t *properties = class_copyPropertyList([self class], &count);
    for (unsigned int i = 0; i < count; i ++) {
        objc_property_t property = properties[i];
        const char *pName = property_getName(property);
        NSString *name = [NSString stringWithFormat:@"pname:%s", pName];
        unsigned int aCount = 0;
        objc_property_attribute_t *attributes = property_copyAttributeList(property, &aCount);
        for (unsigned int j = 0; j < aCount; j ++) {
            objc_property_attribute_t attribute = attributes[j];
            const char *aName = attribute.name;
            const char *aValue = attribute.value;
            NSString *a = [NSString stringWithFormat:@"%@ aName:%s, aValue:%s",name, aName, aValue];
            name = a;
        }
        if (!propertiesList) {
            propertiesList = [NSMutableArray array];
        }
        NSLog(@"%@", name);
        [propertiesList addObject:name];
    }
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return section == 0 ? ivarsList.count : propertiesList.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"reuseIdentifier" forIndexPath:indexPath];
    
    cell.textLabel.text = indexPath.section == 0 ? ivarsList[indexPath.row] : propertiesList[indexPath.row];
    
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
