//
//  BGEmotionTextView.h
//  BGWeiBo
//
//  Created by ZHU on 15/9/1.
//  Copyright (c) 2015年 ZHU. All rights reserved.
//

#import "BGTextView.h"
#import "BGEmotion.h"

@interface BGEmotionTextView : BGTextView
- (void)insertEmotion:(BGEmotion *)emotion;

- (NSString *)fullText;
@end
