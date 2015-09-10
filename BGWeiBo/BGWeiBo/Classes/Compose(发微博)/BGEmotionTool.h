//
//  BGEmotionTool.h
//  BGWeiBo
//
//  Created by ZHU on 15/9/1.
//  Copyright (c) 2015年 ZHU. All rights reserved.
//

#import <UIKit/UIKit.h>
@class BGEmotion;

@interface BGEmotionTool : NSObject
+ (void)addRecentEmotion:(BGEmotion *)emotion;
+ (NSArray *)recentEmotions;
@end
