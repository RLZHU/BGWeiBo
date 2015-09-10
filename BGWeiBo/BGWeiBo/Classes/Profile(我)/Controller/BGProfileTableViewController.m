//
//  BGProfileTableViewController.m
//  BGWeiBo
//
//  Created by ZHU on 15/8/29.
//  Copyright (c) 2015年 ZHU. All rights reserved.
//

#import "BGProfileTableViewController.h"
#import "UIBarButtonItem+Extension.h"
#import "BGNaviViewController.h"
#import "BGSettingTableViewController.h"

@interface BGProfileTableViewController ()

@end

@implementation BGProfileTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"设置" style:0 target:self action:@selector(setting)];
    
}

- (void)setting{
    
    BGSettingTableViewController *vc = [[BGSettingTableViewController alloc] init];
    
    [self.navigationController pushViewController:vc animated:YES];
    
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
#warning Potentially incomplete method implementation.
    // Return the number of sections.
    return 0;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
#warning Incomplete method implementation.
    // Return the number of rows in the section.
    return 0;
}

@end
