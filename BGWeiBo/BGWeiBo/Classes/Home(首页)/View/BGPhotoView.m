//
//  BGPhotoView.m
//  BGWeiBo
//
//  Created by ZHU on 15/8/31.
//  Copyright (c) 2015年 ZHU. All rights reserved.
//

#import "BGPhotoView.h"
#import "UIImageView+WebCache.h"
#import "BGPhoto.h"
#import "UIView+Extexsion.h"

@interface BGPhotoView ()

@property (nonatomic, weak) UIImageView *gifView;

@end

@implementation BGPhotoView
- (UIImageView *)gifView{
    if (!_gifView) {
        UIImage *image = [UIImage imageNamed:@"timeline_image_gif"];
        UIImageView *gifView = [[UIImageView alloc] initWithImage:image];
        [self addSubview:gifView];
        self.gifView = gifView;
    }
    return _gifView;
}

- (id)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        // 内容模式
        self.contentMode = UIViewContentModeScaleAspectFill;
        // 超出边框的内容都剪掉
        self.clipsToBounds = YES;
    }
    return self;
}

- (void)setPhoto:(NSDictionary *)photo{
    _photo = photo;
    
    // 设置图片
    NSString *thumbUrl = photo[@"thumbnail_pic"];
    [self sd_setImageWithURL:[NSURL URLWithString:thumbUrl] placeholderImage:[UIImage imageNamed:@"timeline_image_placeholder"]];
    
    // 显示\隐藏gif控件
    // 判断是够以gif或者GIF结尾
    self.gifView.hidden = ![thumbUrl.lowercaseString hasSuffix:@"gif"];
}

- (void)layoutSubviews{
    [super layoutSubviews];
    
    self.gifView.x = self.width - self.gifView.width;
    self.gifView.y = self.height - self.gifView.height;
}

@end
