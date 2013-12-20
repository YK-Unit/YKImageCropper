//
//  YKCropImageView.m
//  YKImageCropperDemo
//
//  Created by zhang zhiyu on 13-12-20.
//  Copyright (c) 2013年 YK-Unit. All rights reserved.
//

#import "YKCropImageView.h"
#import <QuartzCore/QuartzCore.h>

@implementation YKCropImageView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

- (id)initWithFrame:(CGRect)frame image:(UIImage *)image cropSize:(CGSize)size
{
    self = [self initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        
        //init and setup _scrollView
        _scrollView = [[UIScrollView alloc] initWithFrame:self.bounds];
        [_scrollView setBackgroundColor:[UIColor clearColor]];
        [_scrollView setDelegate:self];
        [_scrollView setBounces:NO];
        [_scrollView setShowsHorizontalScrollIndicator:NO];
        [_scrollView setShowsVerticalScrollIndicator:NO];
        [_scrollView setContentSize:self.bounds.size];
        //setup ContentInset
        CGFloat x = (CGRectGetWidth(self.bounds) - size.width) / 2;
        CGFloat y = (CGRectGetHeight(self.bounds) - size.height) / 2;
        CGFloat top = y;
        CGFloat left = x;
        CGFloat right = CGRectGetWidth(self.bounds)- size.width - x;
        CGFloat bottom = CGRectGetHeight(self.bounds)- size.height - y;
        UIEdgeInsets imageInset = UIEdgeInsetsMake(top, left, bottom, right);
        [_scrollView setContentInset:imageInset];
        
        [self addSubview:_scrollView];
        
        
        //init and setup _maskView
        _maskView = [[YKCropImageMaskView alloc] initWithFrame:self.bounds];
        [_maskView setCropSize:size];
        [_maskView setBackgroundColor:[UIColor clearColor]];
        [_maskView setUserInteractionEnabled:NO];
        [self addSubview:_maskView];
        [self bringSubviewToFront:_maskView];
        
        
        //init _cropSize
        _cropSize = size;
        
        
        //init _imageView
        _imageView = [[UIImageView alloc]initWithImage:image];
        [_scrollView addSubview:_imageView];
        
        
        //setup _scrollView's zoomScale and _imageView's frame
        CGFloat imgWidth = image.size.width;
        CGFloat imgHeight = image.size.height;
        
        CGFloat xScale = size.width / imgHeight;
        CGFloat yScale = size.height / imgHeight;
        CGFloat min = MAX(xScale, yScale);
        CGFloat max = 1.0;
        if ([[UIScreen mainScreen] respondsToSelector:@selector(scale)]) {
            max = 1.0 / [[UIScreen mainScreen] scale];
        }
        if (min > max) {
            min = max;
        }
        [_scrollView setMinimumZoomScale:1.0f];
        [_scrollView setMaximumZoomScale:max+5.0f];
        
        imgWidth = imgWidth * min;
        imgHeight = imgHeight * min;
        [_imageView setFrame:CGRectMake(0, 0, imgWidth, imgHeight)];
        
        [_scrollView setZoomScale:1.0f];
    }
    return self;
}

- (void)dealloc
{
#if(!__has_feature(objc_arc))
    [_scrollView release];
    _scrollView = nil;
    
    [_imageView release];
    _imageView = nil;
    
    [_maskView release];
    _maskView = nil;
    
    [super dealloc];
#endif
}

- (UIImage *)cropImage
{
    UIGraphicsBeginImageContext(self.frame.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    [self.layer renderInContext:context];
    UIImage *fullImage = UIGraphicsGetImageFromCurrentImageContext();
    
    CGFloat x = (self.frame.size.width - _cropSize.width)/2;
    CGFloat y = (self.frame.size.height - _cropSize.height)/2;
    CGRect cropRect = CGRectMake(x, y, _cropSize.width,_cropSize.height);
    UIImage *croppedImage = [UIImage imageWithCGImage:CGImageCreateWithImageInRect([fullImage CGImage], cropRect)];
//    UIImageWriteToSavedPhotosAlbum(croppedImage, nil, nil, nil);
    
    UIGraphicsEndImageContext();
    
    return [croppedImage copy];
}

#pragma UIScrollViewDelegate
- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView
{
    return _imageView;
}
@end

#pragma YKCropImageMaskView

#define kMaskViewBorderWidth 2.0f

@implementation YKCropImageMaskView

- (void)setCropSize:(CGSize)size
{
    CGFloat x = (CGRectGetWidth(self.bounds) - size.width) / 2;
    CGFloat y = (CGRectGetHeight(self.bounds) - size.height) / 2;
    _cropRect = CGRectMake(x, y, size.width, size.height);
    
    [self setNeedsDisplay];
}

- (CGSize)cropSize
{
    return _cropRect.size;
}

- (void)drawRect:(CGRect)rect
{
    [super drawRect:rect];
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    CGContextSetRGBFillColor(ctx, 0, 0, 0, 0.6);
    CGContextFillRect(ctx, self.bounds);
    
    CGContextSetStrokeColorWithColor(ctx, [UIColor whiteColor].CGColor);
    CGContextStrokeRectWithWidth(ctx, _cropRect, kMaskViewBorderWidth);
    
    CGContextClearRect(ctx, _cropRect);
}
@end

