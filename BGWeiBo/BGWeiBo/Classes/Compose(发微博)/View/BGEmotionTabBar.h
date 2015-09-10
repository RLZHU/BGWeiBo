//
//  BGEEmotionTabBar.h
//  BGWeiBo
//
//  Created by ZHU on 15/9/1.
//  Copyright (c) 2015年 ZHU. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum {
    BGEmotionTabBarButtonTypeRecent, // 最近
    BGEmotionTabBarButtonTypeDefault, // 默认
    BGEmotionTabBarButtonTypeEmoji, // emoji
    BGEmotionTabBarButtonTypeLxh, // 浪小花
} BGEmotionTabBarButtonType;

@class BGEmotionTabBar;

@protocol BGEmotionTabBarDelegate <NSObject>

@optional
- (void)emotionTabBar:(BGEmotionTabBar *)tabBar didSelectButton:(BGEmotionTabBarButtonType)buttonType;
@end

@interface BGEmotionTabBar : UIView
@property (nonatomic, weak) id<BGEmotionTabBarDelegate> delegate;

@end
