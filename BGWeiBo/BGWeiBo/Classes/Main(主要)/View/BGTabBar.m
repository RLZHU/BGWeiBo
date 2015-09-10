//
//  BGTabBar.m
//  BGWeiBo
//
//  Created by ZHU on 15/8/29.
//  Copyright (c) 2015年 ZHU. All rights reserved.
//

#import "BGTabBar.h"
#import "UIView+Extexsion.h"

@interface BGTabBar ()
@property (nonatomic, weak) UIButton *plusBtn;
@end

@implementation BGTabBar

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if(self){
        UIButton *plusBtn = [[UIButton alloc] init];
        [plusBtn setBackgroundImage:[UIImage imageNamed:@"tabbar_compose_button"] forState:UIControlStateNormal];
        [plusBtn setBackgroundImage:[UIImage imageNamed:@"tabbar_compose_button_highlighted"] forState:UIControlStateHighlighted];
        
        [plusBtn setImage:[UIImage imageNamed:@"tabbar_compose_icon_add"] forState:UIControlStateNormal];
        [plusBtn setImage:[UIImage imageNamed:@"tabbar_compose_icon_add_highlighted"] forState:UIControlStateHighlighted];
        plusBtn.size = plusBtn.currentBackgroundImage.size;
        
        [plusBtn addTarget:self action:@selector(plusClick) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:plusBtn];
        self.plusBtn = plusBtn;
    }
    
    return self;
}
- (void)plusClick{
    if ([self.delegate respondsToSelector:@selector(tabBarDidClickPlusButton:)]) {
        [self.delegate tabBarDidClickPlusButton:self];
    }
}

- (void)layoutSubviews{
    [super layoutSubviews];//一定要调用
    
    self.plusBtn.centerX = self.width * 0.5;
    self.plusBtn.centerY = self.height * 0.5;
    
    CGFloat tabbarBtnW = self.width / 5;
    CGFloat tabbarBtnIndex = 0;
    
    for (UIView *chileView in self.subviews) {
        Class class = NSClassFromString(@"UITabBarButton");
        if ([chileView isKindOfClass:class]) {
            // 设置宽度
            chileView.width = tabbarBtnW;
            // 设置x
            chileView.x = tabbarBtnIndex * tabbarBtnW;
            
            // 增加索引
            tabbarBtnIndex++;
            if (tabbarBtnIndex == 2) {
                tabbarBtnIndex++;
            }
        }
    }
}

@end
