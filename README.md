YKImageCropper
==============
It's easy to use YKImageCropper.
for example:
- (void)openEditor:(UIImage *)image
{
    YKImageCropper *cropper = [[YKImageCropper alloc]initWithImage:image cropSize:CGSizeMake(300, 300) delegate:self];
    
    [self presentViewController:cropper animated:YES completion:NULL];
}

#pragma mark - YKImageCropperDelegate
- (void)imageCropper:(YKImageCropper *)cropper didFinishCroppingWithImage:(UIImage *)image
{
    /*
    //you can handle the cropped image here
    
    self.imageView.image = image;
    
    */

    [cropper dismissViewControllerAnimated:YES completion:^{
    }];
}

- (void)imageCropperDidCancel:(YKImageCropper *)cropper
{
    [cropper dismissViewControllerAnimated:YES completion:^{
    }];
}
