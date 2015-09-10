//
//  BGNewFeatureViewController.m
//  BGWeiBo
//
//  Created by ZHU on 15/8/30.
//  Copyright (c) 2015年 ZHU. All rights reserved.
//

#import "BGNewFeatureViewController.h"
#import "UIView+Extexsion.h"
#import "BGTabViewController.h"

#define BGNewFeature 4
#define BGColor(r, g, b) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:1.0]

@interface BGNewFeatureViewController ()<UIScrollViewDelegate>

@property (nonatomic, weak) UIPageControl *pageControl;
@property (nonatomic, weak) UIScrollView *scrollView;

@end

@implementation BGNewFeatureViewController

- (void)viewDidLoad{
    [super viewDidLoad];
    
    UIScrollView *view = [[UIScrollView alloc] init];
    view.pagingEnabled = YES;
    view.frame = [UIScreen mainScreen].bounds;
    // 如果想要某个方向上不能滚动，那么这个方向对应的尺寸数值传0即可
    view.contentSize = CGSizeMake(4 * view.width, 0);
    view.showsHorizontalScrollIndicator = NO;
    view.bounces = NO;// 去除弹簧效果
    view.delegate = self;
    self.scrollView = view;
    
#warning 默认情况下，scrollView一创建出来，它里面可能就存在一些子控件了
#warning 就算不主动添加子控件到scrollView中，scrollView内部还是可能会有一些子控件
    
    for (int i = 0; i<BGNewFeature; i++) {
        UIImageView *imgView = [[UIImageView alloc] init];
        [view addSubview:imgView];
        imgView.x = i * view.width;
        imgView.y = 0;
        imgView.size = view.size;
        NSString *name = [NSString stringWithFormat:@"new_feature_%d", i + 1];
        imgView.image = [UIImage imageNamed:name];
        
        if (i == BGNewFeature - 1) {
            [self setEnterBtn:imgView];
        }
    }
    
    UIPageControl *pageControl = [[UIPageControl alloc] init];
    pageControl.numberOfPages = BGNewFeature;
    pageControl.backgroundColor = [UIColor redColor];
    pageControl.currentPageIndicatorTintColor = BGColor(253, 98, 42);
    pageControl.pageIndicatorTintColor = BGColor(189, 189, 189);
    pageControl.centerX = view.width * 0.5;
    pageControl.centerY = view.height - 50;
    self.pageControl = pageControl;
    
    [self.view addSubview:view];
    [self.view addSubview:pageControl];
}

- (void)setEnterBtn:(UIImageView *)imgView{
    imgView.userInteractionEnabled = YES;
    
    UIButton *shareBtn = [[UIButton alloc] init];
    [shareBtn setImage:[UIImage imageNamed:@"new_feature_share_false"] forState:UIControlStateNormal];
    [shareBtn setImage:[UIImage imageNamed:@"new_feature_share_true"] forState:UIControlStateSelected];
    [shareBtn setTitle:@"分享给大家" forState:UIControlStateNormal];
    [shareBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    shareBtn.titleLabel.font = [UIFont systemFontOfSize:15];
    shareBtn.width = 200;
    shareBtn.height = 30;
    shareBtn.centerX = imgView.width * 0.5;
    shareBtn.centerY = imgView.height * 0.65;
    [shareBtn addTarget:self action:@selector(shareBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [imgView addSubview:shareBtn];
    
    //    shareBtn.backgroundColor = [UIColor redColor];
    //    shareBtn.imageView.backgroundColor = [UIColor blueColor];
    //    shareBtn.titleLabel.backgroundColor = [UIColor yellowColor];
    
    // top left bottom right
    
    // EdgeInsets: 自切
    // contentEdgeInsets:会影响按钮内部的所有内容（里面的imageView和titleLabel）
    //    shareBtn.contentEdgeInsets = UIEdgeInsetsMake(10, 100, 0, 0);
    
    // titleEdgeInsets:只影响按钮内部的titleLabel
//    shareBtn.titleEdgeInsets = UIEdgeInsetsMake(0, 10, 0, 0);
    
    // imageEdgeInsets:只影响按钮内部的imageView
    //    shareBtn.imageEdgeInsets = UIEdgeInsetsMake(20, 0, 0, 50);
    //    shareBtn.titleEdgeInsets
    //    shareBtn.imageEdgeInsets
    //    shareBtn.contentEdgeInsets
    
    //开始微博按键
    UIButton *startBtn = [[UIButton alloc] init];
    [startBtn setBackgroundImage:[UIImage imageNamed:@"new_feature_finish_button"] forState:UIControlStateNormal];
    [startBtn setBackgroundImage:[UIImage imageNamed:@"new_feature_finish_button_highlighted"] forState:UIControlStateHighlighted];
    startBtn.size = startBtn.currentBackgroundImage.size;
    startBtn.centerX = shareBtn.centerX;
    startBtn.centerY = imgView.height * 0.8;
    [startBtn setTitle:@"开始微博" forState:UIControlStateNormal];
    [startBtn addTarget:self action:@selector(startBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [imgView addSubview:startBtn];
    
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    
    double page = scrollView.contentOffset.x / scrollView.width;
    self.pageControl.currentPage = (int)(page + 0.5);
}

- (void)shareBtnClick:(UIButton *)shareBtn{
    shareBtn.selected = !shareBtn.selected;
}

- (void)startBtnClick:(UIButton *)startBtn{
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    window.rootViewController = [[BGTabViewController alloc] init];
}

/*
 1.程序启动会自动加载叫做Default的图片
 1> 3.5inch 非retain屏幕：Default.png
 2> 3.5inch retina屏幕：Default@2x.png
 3> 4.0inch retain屏幕: Default-568h@2x.png
 
 2.只有程序启动时自动去加载的图片, 才会自动在4inch retina时查找-568h@2x.png
 */

/*
 一个控件用肉眼看不见，有哪些可能
 1.根本没有创建实例化这个控件
 2.没有设置尺寸
 3.控件的颜色跟父控件的背景色一样（实际上已经显示了，只不过用肉眼看不见）
 4.透明度alpha <= 0.01
 5.hidden = YES
 6.没有添加到父控件中
 7.被其他控件挡住了
 8.位置不对
 9.父控件发生了以上情况
 10.特殊情况
 * UIImageView没有设置image属性，或者设置的图片名不对
 * UILabel没有设置文字，或者文字颜色和跟父控件的背景色一样
 * UITextField没有设置文字，或者没有设置边框样式borderStyle
 * UIPageControl没有设置总页数，不会显示小圆点
 * UIButton内部imageView和titleLabel的frame被篡改了，或者imageView和titleLabel没有内容
 * .....
 
 添加一个控件的建议（调试技巧）：
 1.最好设置背景色和尺寸
 2.控件的颜色尽量不要跟父控件的背景色一样
 */

@end
