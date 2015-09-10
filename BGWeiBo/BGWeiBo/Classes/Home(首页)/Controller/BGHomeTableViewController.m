//
//  BGHomeTableViewController.m
//  BGWeiBo
//
//  Created by ZHU on 15/8/29.
//  Copyright (c) 2015年 ZHU. All rights reserved.
//

#import "BGHomeTableViewController.h"
#import "BGHomeNavBtn.h"
#import "BGMenuView.h"
#import "BGMenuTableViewController.h"
#import "UIView+Extexsion.h"
#import "UIBarButtonItem+Extension.h"
#import "BGAcountTool.h"
#import "BGAcount.h"
#import "BGHttpTool.h"
#import "MJExtension.h"
#import "BGUser.h"
#import "BGStatus.h"
#import "BGStatusFrame.h"
#import "BGStatusTableViewCell.h"
#import "MJRefresh.h"
#import "MBProgressHUD+MJ.h"

@interface BGHomeTableViewController ()<BGMenuViewDelegate>

/**
 *  微博数组（里面放的都是HWStatusFrame模型，一个HWStatusFrame对象就代表一条微博）
 */
@property (nonatomic, strong) NSMutableArray *statusFrames;

@end



@implementation BGHomeTableViewController

- (NSMutableArray *)statusFrames{
    if (!_statusFrames) {
        self.statusFrames = [NSMutableArray array];
    }
    return _statusFrames;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.backgroundColor = [UIColor colorWithRed:211/255.0 green:211/255.0 blue:211/255.0 alpha:1.0];
    
    [self setUpNav];
    [self getUserInfo];
    [self setFreshPlug];
    [self loadData];
    [self getstatus];
}

- (void)setFreshPlug{
    __weak UITableView *tableView = self.tableView;
    
    tableView.header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        
        BGAcount *acount = [BGAcountTool acount];
        NSMutableDictionary *params = [NSMutableDictionary dictionary];
        params[@"access_token"] = acount.access_token;
        BGStatusFrame *firstStatusF = [self.statusFrames firstObject];
        if (firstStatusF) {
            // 若指定此参数，则返回ID比since_id大的微博（即比since_id时间晚的微博），默认为0
            params[@"since_id"] = firstStatusF.status.idstr;
        }
        
        [BGHttpTool get:@"https://api.weibo.com/2/statuses/friends_timeline.json" params:params success:^(id json) {
            NSArray *newStatuses = [BGStatus objectArrayWithKeyValuesArray:json[@"statuses"]];
            // 将 BGStatus数组 转为 BGStatusFrame数组
            NSArray *newFrames = [self stausFramesWithStatuses:newStatuses];
            
            NSRange range = NSMakeRange(0, newFrames.count);
            NSIndexSet *set = [NSIndexSet indexSetWithIndexesInRange:range];
            
            [self.statusFrames insertObjects:newFrames atIndexes:set];
            
            [self.tableView reloadData];
            
        } failure:^(NSError *error) {
            [MBProgressHUD showError:@"请求失败"];
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [MBProgressHUD hideHUD];
            });
        }];
        
            [tableView.header endRefreshing];
            
            // 显示最新微博的数量
//            [self showNewStatusCount:newStatuses.count];
    }];
    
    tableView.header.automaticallyChangeAlpha = YES;
    
    tableView.footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        BGAcount *acount = [BGAcountTool acount];
        NSMutableDictionary *params = [NSMutableDictionary dictionary];
        params[@"access_token"] = acount.access_token;
        BGStatusFrame *lastStatusF = [self.statusFrames lastObject];
        long long maxId = lastStatusF.status.idstr.longLongValue - 1;
        // 若指定此参数，则返回ID小于或等于max_id的微博，默认为0。
        // id这种数据一般都是比较大的，一般转成整数的话，最好是long long类型
        params[@"max_id"] = @(maxId);
        [BGHttpTool get:@"https://api.weibo.com/2/statuses/friends_timeline.json" params:params success:^(id json) {
            // 将 "微博字典"数组 转为 "微博模型"数组
            NSArray *newStatuses = [BGStatus objectArrayWithKeyValuesArray:json[@"statuses"]];
            
            // 将 HWStatus数组 转为 HWStatusFrame数组
            NSArray *newFrames = [self stausFramesWithStatuses:newStatuses];
            
            // 将更多的微博数据，添加到总数组的最后面
            [self.statusFrames addObjectsFromArray:newFrames];
            
            // 刷新表格
            [tableView reloadData];
            
            // 结束刷新(隐藏footer)
            [tableView.footer endRefreshing];
        } failure:^(NSError *error) {
            [MBProgressHUD showError:@"请求失败"];
            // 结束刷新
            [tableView.footer endRefreshing];
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [MBProgressHUD hideHUD];
            });
        }];
    }];
}

- (void)loadData{
    BGAcount *acount = [BGAcountTool acount];
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"access_token"] = acount.access_token;
    BGStatusFrame *firstStatusF = [self.statusFrames firstObject];
    if (firstStatusF) {
        // 若指定此参数，则返回ID比since_id大的微博（即比since_id时间晚的微博），默认为0
        params[@"since_id"] = firstStatusF.status.idstr;
    }
    
    [BGHttpTool get:@"https://api.weibo.com/2/statuses/friends_timeline.json" params:params success:^(id json) {
        NSArray *newStatuses = [BGStatus objectArrayWithKeyValuesArray:json[@"statuses"]];
        // 将 BGStatus数组 转为 BGStatusFrame数组
        NSArray *newFrames = [self stausFramesWithStatuses:newStatuses];
        self.statusFrames = (NSMutableArray *)newFrames;
        [self.tableView reloadData];
        
    } failure:^(NSError *error) {
        [MBProgressHUD showError:@"请求失败"];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [MBProgressHUD hideHUD];
        });
    }];

}

- (void)getstatus{
    BGAcount *acount = [BGAcountTool acount];
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"access_token"] = acount.access_token;
    BGStatusFrame *firstStatusF = [self.statusFrames firstObject];
    if (firstStatusF) {
        // 若指定此参数，则返回ID比since_id大的微博（即比since_id时间晚的微博），默认为0
        params[@"since_id"] = firstStatusF.status.idstr;
    }
    
    [BGHttpTool get:@"https://api.weibo.com/2/statuses/friends_timeline.json" params:params success:^(id json) {
        NSArray *newStatuses = [BGStatus objectArrayWithKeyValuesArray:json[@"statuses"]];
        // 将 BGStatus数组 转为 BGStatusFrame数组
        NSArray *newFrames = [self stausFramesWithStatuses:newStatuses];
        self.statusFrames = (NSMutableArray *)newFrames;
//        NSRange range = NSMakeRange(0, newFrames.count);
//        NSIndexSet *set = [NSIndexSet indexSetWithIndexesInRange:range];
//        [self.statusFrames insertObjects:newFrames atIndexes:set];
        [self.tableView reloadData];
        
    } failure:^(NSError *error) {
        
    }];

}

- (NSArray *)stausFramesWithStatuses:(NSArray *)statuses{
    NSMutableArray *frames = [NSMutableArray array];
    for (BGStatus *status in statuses) {
        BGStatusFrame *statusF = [[BGStatusFrame alloc] init];
        statusF.status = status;
        [frames addObject:statusF];
    }
    return frames;
}

- (void)setUpNav{
    //设置左右的按键
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithTarget:self action:@selector(friendSearch) image:@"navigationbar_friendsearch" highLightedImg:@"navigationbar_friendsearch_highlighted"];
    
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem itemWithTarget:self action:@selector(pop) image:@"navigationbar_pop" highLightedImg:@"navigationbar_pop_highlighted"];
    
    //设置标题
    BGHomeNavBtn *titleBtn = [[BGHomeNavBtn alloc] init];
    [titleBtn setTitle:@"我的首页" forState:UIControlStateNormal];
    [titleBtn addTarget:self action:@selector(titleBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
    
    self.navigationItem.titleView = titleBtn;
}

- (void)titleBtnClicked:(BGHomeNavBtn *)btn{
    //创建向下菜单view
    BGMenuView *menuView = [BGMenuView menu];
    
    BGMenuTableViewController *menuVC = [[BGMenuTableViewController alloc] init];
    menuVC.view.height = 150;
    menuVC.view.width = 150;
    
    menuView.contentController = menuVC;
    menuView.delegate = self;
    
    [menuView showFrom:btn];
    
}

- (void)menuViewDidShow:(BGMenuView *)view{
    UIButton *titleButton = (UIButton *)self.navigationItem.titleView;
    // 让箭头向下
    titleButton.selected = YES;
}

- (void)menuViewWillDismiss:(BGMenuView *)view{
    UIButton *titleButton = (UIButton *)self.navigationItem.titleView;
    // 让箭头向下
    titleButton.selected = NO;
}

- (void)friendSearch{

}

- (void)pop{

}

- (void)getUserInfo{
    BGAcount *acount = [BGAcountTool acount];
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"access_token"] = acount.access_token;
    params[@"uid"] = acount.uid;
    
    [BGHttpTool get:@"https://api.weibo.com/2/users/show.json" params:params success:^(id json) {
        UIButton *titleButton = (UIButton *)self.navigationItem.titleView;
        // 设置名字
        BGUser *user = [BGUser objectWithKeyValues:json];
        [titleButton setTitle:user.name forState:UIControlStateNormal];
        
        // 存储昵称到沙盒中
        acount.name = user.name;
        [BGAcountTool saveAcount:acount];
    } failure:^(NSError *error) {
        
    }];
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.statusFrames.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    BGStatusTableViewCell *cell = [BGStatusTableViewCell cellWithTableView:tableView];
    cell.statusFrame = self.statusFrames[indexPath.row];
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    BGStatusFrame *frame = self.statusFrames[indexPath.row];
    return frame.cellHeight;
}



@end
