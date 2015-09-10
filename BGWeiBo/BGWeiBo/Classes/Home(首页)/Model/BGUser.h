//
//  BGUser.h
//  BGWeiBo
//
//  Created by ZHU on 15/8/31.
//  Copyright (c) 2015年 ZHU. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum {
    BGUserVerifiedTypeNone = -1, // 没有任何认证
    
    BGUserVerifiedPersonal = 0,  // 个人认证
    
    BGUserVerifiedOrgEnterprice = 2, // 企业官方：CSDN、EOE、搜狐新闻客户端
    BGUserVerifiedOrgMedia = 3, // 媒体官方：程序员杂志、苹果汇
    BGUserVerifiedOrgWebsite = 5, // 网站官方：猫扑
    
    BGUserVerifiedDaren = 220 // 微博达人
} BGUserVerifiedType;

@interface BGUser : NSObject
@property (nonatomic, copy) NSString *idstr;

/**	string	友好显示名称*/
@property (nonatomic, copy) NSString *name;

/**	string	用户头像地址，50×50像素*/
@property (nonatomic, copy) NSString *profile_image_url;

/** 会员类型 > 2代表是会员 */
@property (nonatomic, assign) int mbtype;
/** 会员等级 */
@property (nonatomic, assign) int mbrank;
@property (nonatomic, assign, getter = isVip) BOOL vip;

/** 认证类型 */
@property (nonatomic, assign) BGUserVerifiedType verified_type;

@end
