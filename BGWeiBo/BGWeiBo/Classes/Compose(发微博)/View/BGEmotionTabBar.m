//
//  BGEEmotionTabBar.m
//  BGWeiBo
//
//  Created by ZHU on 15/9/1.
//  Copyright (c) 2015年 ZHU. All rights reserved.
//

#import "BGEmotionTabBar.h"
#import "BGEmotionTabBarButton.h"
#import "UIView+Extexsion.h"

@interface BGEmotionTabBar ()
@property (nonatomic, weak) BGEmotionTabBarButton *selectedBtn;
@end

@implementation BGEmotionTabBar
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setupBtn:@"最近" buttonType:BGEmotionTabBarButtonTypeRecent];
        [self setupBtn:@"默认" buttonType:BGEmotionTabBarButtonTypeDefault];
        //        [self btnClick:[self setupBtn:@"默认" buttonType:HWEmotionTabBarButtonTypeDefault]];
        [self setupBtn:@"Emoji" buttonType:BGEmotionTabBarButtonTypeEmoji];
        [self setupBtn:@"浪小花" buttonType:BGEmotionTabBarButtonTypeLxh];
    }
    return self;
}

/**
 *  创建一个按钮
 *
 *  @param title 按钮文字
 */
- (BGEmotionTabBarButton *)setupBtn:(NSString *)title buttonType:(BGEmotionTabBarButtonType)buttonType
{
    // 创建按钮
    BGEmotionTabBarButton *btn = [[BGEmotionTabBarButton alloc] init];
    [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchDown];
    btn.tag = buttonType;
    [btn setTitle:title forState:UIControlStateNormal];
    [self addSubview:btn];
    
    // 设置背景图片
    NSString *image = @"compose_emotion_table_mid_normal";
    NSString *selectImage = @"compose_emotion_table_mid_selected";
    if (self.subviews.count == 1) {
        image = @"compose_emotion_table_left_normal";
        selectImage = @"compose_emotion_table_left_selected";
    } else if (self.subviews.count == 4) {
        image = @"compose_emotion_table_right_normal";
        selectImage = @"compose_emotion_table_right_selected";
    }
    
    [btn setBackgroundImage:[UIImage imageNamed:image] forState:UIControlStateNormal];
    [btn setBackgroundImage:[UIImage imageNamed:selectImage] forState:UIControlStateDisabled];
    
    return btn;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    // 设置按钮的frame
    NSUInteger btnCount = self.subviews.count;
    CGFloat btnW = self.width / btnCount;
    CGFloat btnH = self.height;
    for (int i = 0; i<btnCount; i++) {
        BGEmotionTabBarButton *btn = self.subviews[i];
        btn.y = 0;
        btn.width = btnW;
        btn.x = i * btnW;
        btn.height = btnH;
    }
}

- (void)setDelegate:(id<BGEmotionTabBarDelegate>)delegate
{
    _delegate = delegate;
    
    // 选中“默认”按钮
    [self btnClick:(BGEmotionTabBarButton *)[self viewWithTag:BGEmotionTabBarButtonTypeDefault]];
}

/**
 *  按钮点击
 */
- (void)btnClick:(BGEmotionTabBarButton *)btn
{
    self.selectedBtn.enabled = YES;
    btn.enabled = NO;
    self.selectedBtn = btn;
    
    // 通知代理
    if ([self.delegate respondsToSelector:@selector(emotionTabBar:didSelectButton:)]) {
        [self.delegate emotionTabBar:self didSelectButton:btn.tag];
    }
}


@end
