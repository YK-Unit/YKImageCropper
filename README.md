YKImageCropper
==============
If you want to get a avater from a big image, YKImageCropper can help you to crop it. 

**PS: it supports ARC and Non-ARC**

![](YKImageCropper.gif)

---
##Usage#
See the code snippet below for an example of how to implement the YKImageCropper. There is also a simple demo app within the project.

First create a YKImageCropper:
```Obj-c
- (void)openEditor:(UIImage *)image
{
	YKImageCropper *cropper = [[YKImageCropper alloc]initWithImage:image cropSize:CGSizeMake(120, 120) delegate:self];
	[self presentViewController:cropper animated:YES completion:NULL];
}
```

Then respond to the required delegate methods:
```Obj-c
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
```