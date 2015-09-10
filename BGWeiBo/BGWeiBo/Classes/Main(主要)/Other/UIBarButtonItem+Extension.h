//
//  UIBarButtonItem+Extension.h
//  BGWeiBo
//
//  Created by ZHU on 15/8/29.
//  Copyright (c) 2015年 ZHU. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIBarButtonItem (Extension)
+ (UIBarButtonItem *)itemWithTarget:(id)target action:(SEL)selector image:(NSString *)imgStr highLightedImg:(NSString *)hlImgStr;
@end
