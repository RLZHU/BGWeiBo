//
//  BGIconView.m
//  BGWeiBo
//
//  Created by ZHU on 15/8/31.
//  Copyright (c) 2015年 ZHU. All rights reserved.
//

#import "BGIconView.h"
#import "UIImageView+WebCache.h"
#import "BGUser.h"
#import "UIView+Extexsion.h"

@interface BGIconView ()

@property (nonatomic, weak) UIImageView *vertifiedView;

@end


@implementation BGIconView

- (UIImageView *)vertifiedView{
    if (!_vertifiedView) {
        UIImageView *imgView = [[UIImageView alloc] init];
        [self addSubview:imgView];
        self.vertifiedView = imgView;
    }
    return _vertifiedView;
}

- (void)setUser:(BGUser *)user{
    _user = user;
    [self sd_setImageWithURL:[NSURL URLWithString:user.profile_image_url] placeholderImage:[UIImage imageNamed:@"avatar_default_small"]];
    
    //设置加V图片
    switch (user.verified_type) {
        case BGUserVerifiedPersonal://个人认证
            self.vertifiedView.hidden = NO;
            self.vertifiedView.image = [UIImage imageNamed:@"avatar_vip"];
            break;
        case BGUserVerifiedOrgEnterprice:
        case BGUserVerifiedOrgMedia:
        case BGUserVerifiedOrgWebsite:
            self.vertifiedView.hidden = NO;
            self.vertifiedView.image = [UIImage imageNamed:@"avatar_enterprise_vip"];
        case BGUserVerifiedDaren:
            self.vertifiedView.hidden = NO;
            self.vertifiedView.image = [UIImage imageNamed:@"avatar_grassroot"];
        default:
            self.vertifiedView.hidden = YES;
            break;
    }
    
}

- (void)layoutSubviews{
    [super layoutSubviews];
    self.vertifiedView.size = self.vertifiedView.size;
    CGFloat scale = 0.6;
    self.vertifiedView.x = self.vertifiedView.width - self.vertifiedView.width * scale;
    self.vertifiedView.y = self.vertifiedView.height - self.vertifiedView.height * scale;
}

@end
