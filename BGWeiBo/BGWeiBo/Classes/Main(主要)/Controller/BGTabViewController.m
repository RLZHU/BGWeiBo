//
//  BGTabViewController.m
//  BGWeiBo
//
//  Created by ZHU on 15/8/29.
//  Copyright (c) 2015年 ZHU. All rights reserved.
//

#import "BGTabViewController.h"
#import "BGNaviViewController.h"
#import "BGHomeTableViewController.h"
#import "BGMessageTableViewController.h"
#import "BGDiscoverTableViewController.h"
#import "BGProfileTableViewController.h"
#import "BGTabBar.h"
#import "BGComposeViewController.h"


#define BGColor(r, g, b) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:1.0]

@interface BGTabViewController ()<BGTabBarDelegate>

@end

@implementation BGTabViewController

+ (void)initialize{
    //设置tabbar的主题样式
    UIBarButtonItem *item = [UIBarButtonItem appearance];
    
    //设置普通状态
    NSMutableDictionary *textAttrs = [NSMutableDictionary dictionary];
    textAttrs[NSForegroundColorAttributeName] = [UIColor orangeColor];
    textAttrs[NSFontAttributeName] = [UIFont systemFontOfSize:15];
    
    [item setTitleTextAttributes:textAttrs forState:UIControlStateNormal];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //设置子控制器
    BGHomeTableViewController *homeVc = [[BGHomeTableViewController alloc] init];
    [self addChildViewController:homeVc title:@"首页" image:@"tabbar_home" selectedImg:@"tabbar_home_selected"];
    
    BGMessageTableViewController *messageVc = [[BGMessageTableViewController alloc] init];
    [self addChildViewController:messageVc title:@"消息" image:@"tabbar_message_center" selectedImg:@"tabbar_message_center_selected"];
    
    BGDiscoverTableViewController *discoverVc = [[BGDiscoverTableViewController alloc] init];
    [self addChildViewController:discoverVc title:@"发现" image:@"tabbar_discover" selectedImg:@"tabbar_discover_selected"];
    
    BGProfileTableViewController *profileVc = [[BGProfileTableViewController alloc] init];
    [self addChildViewController:profileVc title:@"我" image:@"tabbar_profile" selectedImg:@"tabbar_profile_selected"];
    
    //更换系统自带tabbar
    BGTabBar *tabbar = [[BGTabBar alloc] init];
    [self setValue:tabbar forKeyPath:@"tabBar"];
    
    /*
     [self setValue:tabBar forKeyPath:@"tabBar"];相当于self.tabBar = tabBar;
     [self setValue:tabBar forKeyPath:@"tabBar"];这行代码过后，tabBar的delegate就是BGTabBarViewController
     说明，不用再设置tabBar.delegate = self;
     */
    
    /*
     1.如果tabBar设置完delegate后，再执行下面代码修改delegate，就会报错
     tabBar.delegate = self;
     
     2.如果再次修改tabBar的delegate属性，就会报下面的错误
     错误信息：Changing the delegate of a tab bar managed by a tab bar controller is not allowed.
     错误意思：不允许修改TabBar的delegate属性(这个TabBar是被TabBarViewController所管理的)
     */
}


/**
 *  添加子控制器并设置各种属性
 */
- (void)addChildViewController:(UIViewController *)childVc title:(NSString *)titleStr image:(NSString *)imgStr selectedImg:(NSString *)selectedImgStr{
    childVc.title = titleStr;
    childVc.tabBarItem.image = [UIImage imageNamed:imgStr];
    childVc.tabBarItem.selectedImage = [UIImage imageNamed:selectedImgStr];
    
    NSMutableDictionary *textAttr = [NSMutableDictionary dictionary];
    textAttr[NSForegroundColorAttributeName] = BGColor(123, 123, 123);
    NSMutableDictionary *selectedTextAttr = [NSMutableDictionary dictionary];
    selectedTextAttr[NSForegroundColorAttributeName] = [UIColor orangeColor];
    
    [childVc.tabBarItem setTitleTextAttributes:textAttr forState:UIControlStateNormal];
    [childVc.tabBarItem setTitleTextAttributes:selectedTextAttr forState:UIControlStateSelected];
    
    //创建nav控制器，将chileVc加到其上面，再将nav加到tab上。
    BGNaviViewController *navVc = [[BGNaviViewController alloc] init];
    [navVc addChildViewController:childVc];
    [self addChildViewController:navVc];
    
}


#pragma 实现代理方法
- (void)tabBarDidClickPlusButton:(BGTabBar *)tabBar{
    
    BGComposeViewController *comVc = [[BGComposeViewController alloc] init];
    
    BGNaviViewController *vc = [[BGNaviViewController alloc] initWithRootViewController:comVc];
    [self presentViewController:vc animated:YES completion:nil];
}

@end
