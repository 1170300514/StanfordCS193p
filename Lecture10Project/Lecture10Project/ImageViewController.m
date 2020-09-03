//
//  ImageViewController.m
//  Lecture10Project
//
//  Created by larryhzhang on 2020/9/3.
//  Copyright © 2020 larryhzhang. All rights reserved.
//

#import "ImageViewController.h"

@interface ImageViewController ()
@property(nonatomic, strong) UIImageView *imageView;
@property(nonatomic,strong) UIImage *image;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@end

@implementation ImageViewController

- (void)setScrollView:(UIScrollView *)scrollView {
    _scrollView = scrollView;
    self.scrollView.contentSize = self.image ? self.image.size : CGSizeZero;
}

// getter of imageView
- (UIImageView *)imageView {
    if (!_imageView) {
        _imageView = [[UIImageView alloc] init];
    }
    return _imageView;
}

// 错误做法：阻塞主线程
- (void)setImageURL:(NSURL *)imageURL {
    _imageURL = imageURL;
    self.image = [UIImage imageWithData:[NSData dataWithContentsOfURL:imageURL]];
}

- (UIImage *)image {
    return self.imageView.image;
}

- (void)setImage:(UIImage *)image {
    self.imageView.image = image;
    [self.imageView sizeToFit];
    self.scrollView.contentSize = self.image ? self.image.size : CGSizeZero;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.scrollView addSubview:self.imageView];
}

@end
