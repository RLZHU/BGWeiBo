//
//  BGEmotionPopView.m
//  BGWeiBo
//
//  Created by ZHU on 15/9/1.
//  Copyright (c) 2015年 ZHU. All rights reserved.
//

#import "BGEmotionPopView.h"
#import "BGEmotionButton.h"
#import "UIView+Extexsion.h"

@interface BGEmotionPopView ()
@property (weak, nonatomic) IBOutlet BGEmotionButton *emotionButton;

@end

@implementation BGEmotionPopView

+ (instancetype)popView
{
    return [[[NSBundle mainBundle] loadNibNamed:@"BGEmotionPopView" owner:nil options:nil] lastObject];
}

- (void)showFrom:(BGEmotionButton *)button
{
    if (button == nil) return;
    
    self.backgroundColor = [UIColor clearColor];
    
    // 给popView传递数据
    self.emotionButton.emotion = button.emotion;
    
    // 取得最上面的window
    UIWindow *window = [[UIApplication sharedApplication].windows lastObject];
    [window addSubview:self];
    
    // 计算出被点击的按钮在window中的frame
    CGRect btnFrame = [button convertRect:button.bounds toView:nil];
    self.y = CGRectGetMidY(btnFrame) - self.height; // 100
    self.centerX = CGRectGetMidX(btnFrame);
}


@end
