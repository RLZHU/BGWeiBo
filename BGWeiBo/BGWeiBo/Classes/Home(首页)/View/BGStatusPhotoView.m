//
//  BGStatusPhotoView.m
//  BGWeiBo
//
//  Created by ZHU on 15/8/31.
//  Copyright (c) 2015年 ZHU. All rights reserved.
//

#import "BGStatusPhotoView.h"
#import "BGPhotoView.h"
#import "UIView+Extexsion.h"
#import "BGPhoto.h"

#define BGStatusPhotoMaxCol(count) ((count==4)?2:3)
#define BGStatusPhotoWH 70
#define BGStatusPhotoMargin 10

@implementation BGStatusPhotoView


+ (CGSize)sizeWithPhotoCount:(NSUInteger)count{
    int maxCols = BGStatusPhotoMaxCol(count);
    
    NSUInteger cols = (count >= maxCols) ? maxCols : count;
    CGFloat photosW = cols * BGStatusPhotoWH + (cols - 1) * BGStatusPhotoMargin;
    NSUInteger rows = (count + maxCols - 1) / maxCols;
    CGFloat photosH = rows * BGStatusPhotoWH + (rows - 1) * BGStatusPhotoMargin;
    
    return CGSizeMake(photosW, photosH);
}

- (void)setPhotos:(NSArray *)photos{
    _photos = photos;
    
    NSUInteger photosCount = photos.count;
    
    while (self.subviews.count < photosCount) {
        BGPhotoView *photoView = [[BGPhotoView alloc] init];
        [self addSubview:photoView];
    }
    
    for (int i = 0; i<self.subviews.count; i++) {
        BGPhotoView *photoView = self.subviews[i];
        
        if (i < photosCount) {
            photoView.photo = photos[i];
            photoView.hidden = NO;
        }else{
            photoView.hidden = YES;
        }
    }
}

- (void)layoutSubviews{
    [super layoutSubviews];
    
    NSUInteger photosCount = self.photos.count;
    int maxCols = BGStatusPhotoMaxCol(photosCount);
    for (int i = 0; i<photosCount ; i++) {
        BGPhotoView *photoView = self.subviews[i];
        
        int col = i % maxCols;
        photoView.x = col * (BGStatusPhotoWH + BGStatusPhotoMargin);
        
        int row = i / maxCols;
        
        photoView.y = row * (BGStatusPhotoWH + BGStatusPhotoMargin);
        
        photoView.width = BGStatusPhotoWH;
        photoView.height = photoView.width;
    }
}

@end
