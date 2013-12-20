YKImageCropper
==============
It's easy to use YKImageCropper.

for example:

//first create a YKImageCropper
- (void)openEditor:(UIImage *)image
{

    YKImageCropper *cropper = [[YKImageCropper alloc]initWithImage:image cropSize:CGSizeMake(300, 300) delegate:self];
    
    [self presentViewController:cropper animated:YES completion:NULL];
    
}

==============
//then handle the cropped image that you want in the YKImageCropperDelegate methods

//- YKImageCropperDelegate
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
