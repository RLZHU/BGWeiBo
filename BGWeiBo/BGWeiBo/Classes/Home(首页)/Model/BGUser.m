//
//  BGUser.m
//  BGWeiBo
//
//  Created by ZHU on 15/8/31.
//  Copyright (c) 2015年 ZHU. All rights reserved.
//

#import "BGUser.h"

@implementation BGUser

- (void)setMbtype:(int)mbtype
{
    _mbtype = mbtype;
    
    self.vip = mbtype > 2;
}

@end
