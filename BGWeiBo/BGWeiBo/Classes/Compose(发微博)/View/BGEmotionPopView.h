//
//  BGEmotionPopView.h
//  BGWeiBo
//
//  Created by ZHU on 15/9/1.
//  Copyright (c) 2015年 ZHU. All rights reserved.
//

#import <UIKit/UIKit.h>
@class BGEmotionButton;

@interface BGEmotionPopView : UIView
+ (instancetype)popView;

- (void)showFrom:(BGEmotionButton *)button;
@end
