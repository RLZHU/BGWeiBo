//
//  BGMenuVIew.m
//  BGWeiBo
//
//  Created by ZHU on 15/8/30.
//  Copyright (c) 2015年 ZHU. All rights reserved.
//

#import "BGMenuView.h"
#import "UIView+Extexsion.h"

@interface BGMenuView ()

@property (nonatomic, weak) UIImageView *imgView;

@end

@implementation BGMenuView

- (UIImageView *)imgView{
    if (!_imgView) {
        
        UIImageView *container = [[UIImageView alloc] init];
        container.image = [UIImage imageNamed:@"popover_background"];
        container.userInteractionEnabled = YES;
        [self addSubview:container];
        container.frame = CGRectMake(100, 100, 100, 100);
        self.imgView = container;
    }
    return _imgView;
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // 清除颜色
        self.backgroundColor = [UIColor clearColor];
    }
    return self;
}

+ (instancetype)menu{
    return [[self alloc] init];
}

- (void)setContent:(UIView *)content{
    _content = content;
    //设置content的位置
    content.x = 10;
    content.y = 15;
    
    //根据content的宽和高设置img背景的宽高
    self.imgView.height = CGRectGetMaxY(content.frame) + 11;
    self.imgView.width = CGRectGetMaxX(content.frame) +10;
    
    [self.imgView addSubview:content];
}



- (void)setContentController:(UIViewController *)contentController{
    _contentController = contentController;
    
    self.content = contentController.view;
}

- (void)showFrom:(UIView *)from{
    //获得最上层的窗口
    UIWindow *window = [[UIApplication sharedApplication].windows lastObject];
    
    //添加到窗口上，并设置尺寸
    [window addSubview:self];
    self.frame = window.bounds;
    
    //调整灰色图片的位置
    //默认情况下，frame是以父控件的左上角为原点
    //1.转换坐标系
    CGRect newFrame = [from convertRect:from.bounds toView:window];
    //    CGRect newFrame = [from.superview convertRect:from.frame toView:window];
    
    self.imgView.centerX = CGRectGetMidX(newFrame);
    self.imgView.y = CGRectGetMaxY(newFrame);
    
    if ([self.delegate respondsToSelector:@selector(menuViewDidShow:)]) {
        [self.delegate menuViewDidShow:self];
    }
}

- (void)dismiss
{
    [self removeFromSuperview];
    
    // 通知外界，自己被销毁了
    if ([self.delegate respondsToSelector:@selector(menuViewWillDismiss:)]) {
        [self.delegate menuViewWillDismiss:self];
    }
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self dismiss];
}

@end
