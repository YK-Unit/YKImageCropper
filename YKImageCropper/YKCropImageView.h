//
//  YKCropImageView.h
//  YKImageCropperDemo
//
//  Created by zhang zhiyu on 13-12-20.
//  Copyright (c) 2013年 YK-Unit. All rights reserved.
//

#import <UIKit/UIKit.h>

@class YKCropImageMaskView;

@interface YKCropImageView : UIView
 <UIScrollViewDelegate>
{
@private
    UIScrollView        *_scrollView;
    UIImageView         *_imageView;
    YKCropImageMaskView *_maskView;
    UIEdgeInsets        _imageInset;
    CGSize              _cropSize;
}
- (id)initWithFrame:(CGRect)frame image:(UIImage *)image cropSize:(CGSize)size;
- (UIImage *)cropImage;
@end

@interface YKCropImageMaskView : UIView
{
@private
    CGRect  _cropRect;
}
- (void)setCropSize:(CGSize)size;
- (CGSize)cropSize;
@end


