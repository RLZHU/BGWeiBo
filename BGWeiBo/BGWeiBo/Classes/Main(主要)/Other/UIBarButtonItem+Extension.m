//
//  UIBarButtonItem+Extension.m
//  BGWeiBo
//
//  Created by ZHU on 15/8/29.
//  Copyright (c) 2015年 ZHU. All rights reserved.
//

#import "UIBarButtonItem+Extension.h"
#import "UIView+Extexsion.h"

@implementation UIBarButtonItem (Extension)
+ (UIBarButtonItem *)itemWithTarget:(id)target action:(SEL)selector image:(NSString *)imgStr highLightedImg:(NSString *)hlImgStr{
    UIButton *btn = [[UIButton alloc] init];
    [btn setBackgroundImage:[UIImage imageNamed:imgStr] forState:UIControlStateNormal];
    [btn setBackgroundImage:[UIImage imageNamed:hlImgStr] forState:UIControlStateHighlighted];
    [btn addTarget:target action:selector forControlEvents:UIControlEventTouchUpInside];
    
    btn.size = btn.currentBackgroundImage.size;
    
    return [[UIBarButtonItem alloc] initWithCustomView:btn];
}
@end
