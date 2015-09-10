//
//  BGEmotionAttachment.m
//  BGWeiBo
//
//  Created by ZHU on 15/9/1.
//  Copyright (c) 2015年 ZHU. All rights reserved.
//

#import "BGEmotionAttachment.h"
#import "BGEmotion.h"

@implementation BGEmotionAttachment

- (void)setEmotion:(BGEmotion *)emotion
{
    _emotion = emotion;
    
    self.image = [UIImage imageNamed:emotion.png];
}

@end
