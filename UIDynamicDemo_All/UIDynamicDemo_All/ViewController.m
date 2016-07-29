//
//  ViewController.m
//  UIDynamicDemo_All
//
//  Created by lcc on 16/7/26.
//  Copyright © 2016年 ws. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,copy)NSArray *titleArray;
@end
static NSString *cllString = @"cllString";
@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    UITableView *tablev = [[UITableView alloc] initWithFrame:self.view.bounds style:0];
    [tablev registerClass:[UITableViewCell class] forCellReuseIdentifier:cllString];
    tablev.delegate = self;
    tablev.dataSource = self;
    [self.view addSubview:tablev];
    
    self.titleArray = @[@"Gravity_VC",@"GravityAndCollision_VC",@"ABC_UIAttachmentBehavior_VC",@"ABC_UIDynamicItemBehavior_VC",@"ABC_UIPushBehavior_VC",@"ABC_UISnapBehavior_VC"];
    
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cll = [tableView dequeueReusableCellWithIdentifier:cllString];
    cll.textLabel.text = self.titleArray[indexPath.row];
    cll.selectionStyle = UITableViewCellSelectionStyleNone;
    return cll;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.titleArray count];
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    UIViewController *clas = [[NSClassFromString(self.titleArray[indexPath.row]) alloc] init];
    clas.title = self.titleArray[indexPath.row];
    [self.navigationController pushViewController:clas animated:YES];
}


@end
