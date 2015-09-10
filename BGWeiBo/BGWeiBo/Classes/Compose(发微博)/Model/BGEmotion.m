//
//  BGEmotion.m
//  BGWeiBo
//
//  Created by ZHU on 15/9/1.
//  Copyright (c) 2015年 ZHU. All rights reserved.
//

#import "BGEmotion.h"
#import "MJExtension.h"

@implementation BGEmotion

MJCodingImplementation;

- (BOOL)isEqual:(BGEmotion  *)other{
    return [self.chs isEqualToString:other.chs] || [self.code isEqualToString:other.code];}

@end
