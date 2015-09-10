//
//  BGTabBar.h
//  BGWeiBo
//
//  Created by ZHU on 15/8/29.
//  Copyright (c) 2015年 ZHU. All rights reserved.
//

#import <UIKit/UIKit.h>
@class BGTabBar;


#warning 因为HWTabBar继承自UITabBar，所以称为BGTabBar的代理，也必须实现UITabBar的代理协议
@protocol BGTabBarDelegate <UITabBarDelegate>
@optional
- (void)tabBarDidClickPlusButton:(BGTabBar *)tabBar;
@end

@interface BGTabBar : UITabBar

@property (nonatomic, weak) id<BGTabBarDelegate> delegate;

@end
