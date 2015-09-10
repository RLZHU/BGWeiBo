//
//  BGEmotionPageView.h
//  BGWeiBo
//
//  Created by ZHU on 15/9/1.
//  Copyright (c) 2015年 ZHU. All rights reserved.
//

#import <UIKit/UIKit.h>

// 一页中最多3行
#define BGEmotionMaxRows 3
// 一行中最多7列
#define BGEmotionMaxCols 7
// 每一页的表情个数
#define BGEmotionPageSize ((BGEmotionMaxRows * BGEmotionMaxCols) - 1)

@interface BGEmotionPageView : UIView
/** 这一页显示的表情（里面都是HWEmotion模型） */
@property (nonatomic, strong) NSArray *emotions;

@end
