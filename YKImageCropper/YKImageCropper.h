//
//  YKImageCropper.h
//  YKImageCropperDemo
//
//  Created by zhang zhiyu on 13-12-20.
//  Copyright (c) 2013年 YK-Unit. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YKCropImageView.h"

@protocol YKImageCropperDelegate;

@interface YKImageCropper : UIViewController
{
@private
    id <YKImageCropperDelegate> _delegate;
    UIImage *_baseImage;
    YKCropImageView *_cropImageView;
    CGSize  _cropSize;
}
- (id)initWithImage:(UIImage *)image cropSize:(CGSize)size delegate:(id <YKImageCropperDelegate>)delegate;
@end


@protocol YKImageCropperDelegate <NSObject>
- (void)imageCropper:(YKImageCropper *)cropper didFinishCroppingWithImage:(UIImage *)image;
- (void)imageCropperDidCancel:(YKImageCropper *)cropper;
@end
