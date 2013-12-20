//
//  DemoViewController.m
//  YKImageCropperDemo
//
//  Created by zhang zhiyu on 13-12-20.
//  Copyright (c) 2013年 YK-Unit. All rights reserved.
//

#import "DemoViewController.h"

@interface DemoViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *headerImageView;
- (IBAction)doGetPhoto:(id)sender;
- (void)openPhotoAlbum;
- (void)showCamera;
- (void)openEditor:(UIImage *)image;
@end

@implementation DemoViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)doGetPhoto:(id)sender {
    UIActionSheet *menuSheet = [[UIActionSheet alloc]initWithTitle:nil delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"本地图库",@"照相机", nil];
    menuSheet.tag = 100;
    [menuSheet setActionSheetStyle:UIActionSheetStyleBlackTranslucent];
    [menuSheet showInView:self.view];
}

- (void)openPhotoAlbum
{
    UIImagePickerController *controller = [[UIImagePickerController alloc] init];
    controller.delegate = self;
    controller.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    
    [self presentViewController:controller animated:YES completion:NULL];
}

- (void)showCamera
{
    UIImagePickerController *controller = [[UIImagePickerController alloc] init];
    controller.delegate = self;
    controller.sourceType = UIImagePickerControllerSourceTypeCamera;
    controller.videoQuality = UIImagePickerControllerQualityTypeLow;
    
    [self presentViewController:controller animated:YES completion:NULL];
}

- (void)openEditor:(UIImage *)image
{
    YKImageCropper *cropper = [[YKImageCropper alloc]initWithImage:image cropSize:CGSizeMake(300, 300) delegate:self];
    
    [self presentViewController:cropper animated:YES completion:NULL];
}

#pragma mark - UIActionSheetDelegate
- (void)actionSheet:(UIActionSheet *)actionSheet didDismissWithButtonIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 0) {
        [self openPhotoAlbum];
    }else if (buttonIndex == 1){
        [self showCamera];
    }
}

#pragma mark - UIImagePickerControllerDelegate
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    UIImage *image = [info objectForKey:UIImagePickerControllerOriginalImage];
    
    [picker dismissViewControllerAnimated:NO completion:^{
        [self openEditor:image];
    }];
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [picker dismissViewControllerAnimated:YES completion:^{
        
    }];
}

#pragma mark - YKImageCropperDelegate
- (void)imageCropper:(YKImageCropper *)cropper didFinishCroppingWithImage:(UIImage *)image
{
    self.headerImageView.image = image;
    
    [cropper dismissViewControllerAnimated:YES completion:^{
    }];
}

- (void)imageCropperDidCancel:(YKImageCropper *)cropper
{
    [cropper dismissViewControllerAnimated:YES completion:^{
    }];
}

@end
