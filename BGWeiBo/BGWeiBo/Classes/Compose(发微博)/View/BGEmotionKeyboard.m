//
//  BGEmotionKeyboard.m
//  BGWeiBo
//
//  Created by ZHU on 15/9/1.
//  Copyright (c) 2015年 ZHU. All rights reserved.
//

#import "BGEmotionKeyboard.h"
#import "BGEmotionListView.h"
#import "BGEmotionTabBar.h"
#import "BGEmotion.h"
#import "MJExtension.h"
#import "BGEmotionTool.h"
#import "UIView+Extexsion.h"

@interface BGEmotionKeyboard () <BGEmotionTabBarDelegate>
/** 保存正在显示listView */
@property (nonatomic, weak) BGEmotionListView *showingListView;
/** 表情内容 */
@property (nonatomic, strong) BGEmotionListView *recentListView;
@property (nonatomic, strong) BGEmotionListView *defaultListView;
@property (nonatomic, strong) BGEmotionListView *emojiListView;
@property (nonatomic, strong) BGEmotionListView *lxhListView;
/** tabbar */
@property (nonatomic, weak) BGEmotionTabBar *tabBar;

@end

@implementation BGEmotionKeyboard

#pragma mark - 懒加载
- (BGEmotionListView *)recentListView{
    if (!_recentListView) {
        self.recentListView = [[BGEmotionListView alloc] init];
        // 加载沙盒中的数据
        self.recentListView.emotions = [BGEmotionTool recentEmotions];
    }
    return _recentListView;
}

- (BGEmotionListView *)defaultListView{
    if (!_defaultListView) {
        self.defaultListView = [[BGEmotionListView alloc] init];
        NSString *path = [[NSBundle mainBundle] pathForResource:@"EmotionIcons/default/info.plist" ofType:nil];
        self.defaultListView.emotions = [BGEmotion objectArrayWithKeyValuesArray:[NSArray arrayWithContentsOfFile:path]];
    }
    return _defaultListView;
}

- (BGEmotionListView *)emojiListView{
    if (!_emojiListView) {
        self.emojiListView = [[BGEmotionListView alloc] init];
        NSString *path = [[NSBundle mainBundle] pathForResource:@"EmotionIcons/emoji/info.plist" ofType:nil];
        self.emojiListView.emotions = [BGEmotion objectArrayWithKeyValuesArray:[NSArray arrayWithContentsOfFile:path]];
    }
    return _emojiListView;
}

- (BGEmotionListView *)lxhListView{
    if (!_lxhListView) {
        self.lxhListView = [[BGEmotionListView alloc] init];
        NSString *path = [[NSBundle mainBundle] pathForResource:@"EmotionIcons/lxh/info.plist" ofType:nil];
        self.lxhListView.emotions = [BGEmotion objectArrayWithKeyValuesArray:[NSArray arrayWithContentsOfFile:path]];
    }
    return _lxhListView;
}

#pragma mark - 初始化
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // tabbar
        BGEmotionTabBar *tabBar = [[BGEmotionTabBar alloc] init];
        tabBar.delegate = self;
        [self addSubview:tabBar];
        self.tabBar = tabBar;
        
        // 表情选中的通知
        NSNotificationCenter *center = [NSNotificationCenter defaultCenter];
        [center addObserver:self selector:@selector(emotionDidSelect) name:@"BGEmotionDidSelectNotification" object:nil];
    }
    return self;
}

- (void)emotionDidSelect{
    self.recentListView.emotions = [BGEmotionTool recentEmotions];
}

- (void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)layoutSubviews{
    [super layoutSubviews];
    
    // 1.tabbar
    self.tabBar.width = self.width;
    self.tabBar.height = 37;
    self.tabBar.x = 0;
    self.tabBar.y = self.height - self.tabBar.height;
    
    // 2.表情内容
    self.showingListView.x = self.showingListView.y = 0;
    self.showingListView.width = self.width;
    self.showingListView.height = self.tabBar.y;
}

#pragma mark - HWEmotionTabBarDelegate
- (void)emotionTabBar:(BGEmotionTabBar *)tabBar didSelectButton:(BGEmotionTabBarButtonType)buttonType{
    // 移除正在显示 的listView控件
    [self.showingListView removeFromSuperview];
    
    // 根据按钮类型，切换键盘上面的listview
    switch (buttonType) {
        case BGEmotionTabBarButtonTypeRecent: { // 最近
            // 加载沙盒中的数据
            //            self.recentListView.emotions = [HWEmotionTool recentEmotions];
            [self addSubview:self.recentListView];
            break;
        }
            
        case BGEmotionTabBarButtonTypeDefault: { // 默认
            [self addSubview:self.defaultListView];
            break;
        }
            
        case BGEmotionTabBarButtonTypeEmoji: { // Emoji
            [self addSubview:self.emojiListView];
            break;
        }
            
        case BGEmotionTabBarButtonTypeLxh: { // Lxh
            [self addSubview:self.lxhListView];
            break;
        }
    }
    
    // 设置正在显示的listView
    self.showingListView = [self.subviews lastObject];
    
    // 会在适当的时候重新调用layoutsubviews重新设置FRAME
    [self setNeedsLayout];
}


@end
