//
//  BGStatusToolView.m
//  BGWeiBo
//
//  Created by ZHU on 15/8/31.
//  Copyright (c) 2015年 ZHU. All rights reserved.
//

#import "BGStatusToolView.h"
#import "UIView+Extexsion.h"
#import "BGStatus.h"

@interface BGStatusToolView ()
//存放所有的按钮数组
@property (nonatomic, strong) NSMutableArray *buttonsArr;
//存放所有的分割线
@property (nonatomic, strong) NSMutableArray *dividersArr;

@property (nonatomic, weak) UIButton *repostBtn;
@property (nonatomic, weak) UIButton *commentBtn;
@property (nonatomic, weak) UIButton *attitudeBtn;

@end

@implementation BGStatusToolView

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"timeline_card_bottom_background"]];
        self.repostBtn = [self setupBtn:@"转发" icon:@"timeline_icon_retweet"];
        self.commentBtn = [self setupBtn:@"评论" icon:@"timeline_icon_comment"];
        self.attitudeBtn = [self setupBtn:@"赞" icon:@"timeline_icon_unlike"];
        
        // 添加分割线
        [self setupDivider];
        [self setupDivider];
    }
    return self;
}

- (void)layoutSubviews{
    [super layoutSubviews];
    NSUInteger btnCount = self.buttonsArr.count;
    CGFloat btnW = self.width / btnCount;
    CGFloat btnH = self.height;
    
    for (int i = 0; i<btnCount; i++) {
        UIButton *btn = self.buttonsArr[i];
        btn.size = CGSizeMake(btnW, btnH);
        btn.x = i * btnW;
        btn.y = 0;
    }
    
    NSUInteger dividerCount = self.dividersArr.count;
    for (int i = 0; i<dividerCount; i++) {
        UIImageView *divider = [[UIImageView alloc] init];
        divider.width = 1;
        divider.height = btnH;
        divider.x = (i + 1) * btnW;
        divider.y = 0;
    }
}

- (void)setStatus:(BGStatus *)status{
    _status = status;
    
    // 转发
    [self setupButtonContent:status.reposts_count btn:self.repostBtn title:@"转发"];
    [self setupButtonContent:status.comments_count btn:self.commentBtn title:@"评论"];
    [self setupButtonContent:status.attitudes_count btn:self.attitudeBtn title:@"赞"];

    
}

- (void)setupButtonContent:(int)count btn:(UIButton *)btn title:(NSString *)title{
    if (count) {
        if (count < 10000) {
            title = [NSString stringWithFormat:@"%d", count];
        }else{
            double wan = count / 10000;
            title = [NSString stringWithFormat:@"%.1f万", wan];
            title = [title stringByReplacingOccurrencesOfString:@".0" withString:@""];
        }
    }
    [btn setTitle:title forState:UIControlStateNormal];
}

- (void)setupDivider{
    UIImageView *divider = [[UIImageView alloc] init];
    divider.image = [UIImage imageNamed:@"timeline_card_bottom_line"];
    [self addSubview:divider];
    
    [self.dividersArr addObject:divider];
}

- (UIButton *)setupBtn:(NSString *)title icon:(NSString *)icon{
    UIButton *btn = [[UIButton alloc] init];
    [btn setImage:[UIImage imageNamed:icon] forState:UIControlStateNormal];
    btn.titleEdgeInsets = UIEdgeInsetsMake(0, 5, 0, 0);
    [btn setTitle:title forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    [btn setBackgroundImage:[UIImage imageNamed:@"timeline_card_bottom_background_highlighted"] forState:UIControlStateHighlighted];
    btn.titleLabel.font = [UIFont systemFontOfSize:13];
    [self addSubview:btn];
    
    [self.buttonsArr addObject:btn];
    
    return btn;
}

- (NSMutableArray *)buttonsArr{
    if (!_buttonsArr) {
        self.buttonsArr = [[NSMutableArray alloc] init];
    }
    return _buttonsArr;
}

- (NSMutableArray *)dividersArr{
    if (!_dividersArr) {
        self.dividersArr = [[NSMutableArray alloc] init];
    }
    return _dividersArr;
}

+ (instancetype)toolBar{
    return [[self alloc] init];
}

@end
