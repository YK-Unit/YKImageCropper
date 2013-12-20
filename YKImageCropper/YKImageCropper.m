//
//  YKImageCropper.m
//  YKImageCropperDemo
//
//  Created by zhang zhiyu on 13-12-20.
//  Copyright (c) 2013年 YK-Unit. All rights reserved.
//

#import "YKImageCropper.h"

@interface YKImageCropper ()
- (void)cancelCropping;
- (void)finishCropping;
@end

@implementation YKImageCropper

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (id)initWithImage:(UIImage *)image cropSize:(CGSize)size delegate:(id<YKImageCropperDelegate>)delegate
{
    if (!image) {
        return nil;
    }
    
    self = [self init];
    if (self) {
        if (CGSizeEqualToSize(size, CGSizeZero)) {
            _cropSize = CGSizeMake(120, 120);
        }else{
            _cropSize = size;
        }
        _delegate = delegate;
        
#if(__has_feature(objc_arc))
        _baseImage = image;
#else
        _baseImage = [image retain];
#endif
        
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    [self.view setBackgroundColor:[UIColor blackColor]];
    
    CGRect cropFrame = CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height - 44);
    _cropImageView = [[YKCropImageView alloc] initWithFrame:cropFrame image:_baseImage cropSize:_cropSize];
    [self.view addSubview:_cropImageView];
    
    UIToolbar *toolBar = [[UIToolbar alloc] initWithFrame:CGRectMake(0, self.view.bounds.size.height - 44, self.view.bounds.size.width, 44)];
    [toolBar setBarStyle:UIBarStyleBlackTranslucent];
    UIBarButtonItem *cancelItem = [[UIBarButtonItem alloc] initWithTitle:NSLocalizedString(@"取消", @"") style:UIBarButtonItemStyleBordered target:self action:@selector(cancelCropping)];
    UIBarButtonItem *flexibleItem1 = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
    UIBarButtonItem *titleItem = [[UIBarButtonItem alloc] initWithTitle:NSLocalizedString(@"移动和缩放", @"") style:UIBarButtonItemStylePlain target:nil action:nil];
    UIBarButtonItem *flexibleItem2 = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
    UIBarButtonItem *doneItem = [[UIBarButtonItem alloc] initWithTitle:NSLocalizedString(@"选取", @"") style:UIBarButtonItemStyleDone target:self action:@selector(finishCropping)];
    NSArray *items = [[NSArray alloc] initWithObjects:cancelItem,flexibleItem1,titleItem,flexibleItem2,doneItem, nil];
    [toolBar setItems:items];
    [self.view addSubview:toolBar];
    
#if(!__has_feature(objc_arc))
    [cancelItem release];
    [flexibleItem1 release];
    [titleItem release];
    [flexibleItem2 release];
    [doneItem release];
    [items release];
#endif
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc
{
#if(!__has_feature(objc_arc))
    [_baseImage release];
    _baseImage = nil;
    
    [_cropImageView release];
    _cropImageView = nil;
    
    [super dealloc];
#endif
}

- (void)cancelCropping
{
    if (_delegate && [_delegate respondsToSelector:@selector(imageCropperDidCancel:)])
    {
        [_delegate imageCropperDidCancel:self];
    }
}

- (void)finishCropping
{
    if (_delegate && [_delegate respondsToSelector:@selector(imageCropper:didFinishCroppingWithImage:)]) {
        UIImage *croppedImage = [_cropImageView cropImage];
        
        [_delegate imageCropper:self didFinishCroppingWithImage:croppedImage];
    }
}
@end
