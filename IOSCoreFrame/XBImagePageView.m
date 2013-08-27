//
//  XBImagePageView.m
//  IOSCoreFrame
//
//  Created by XiaoBin on 13-8-21.
//  Copyright (c) 2013年 XiaoBin. All rights reserved.
//

#import "XBImagePageView.h"
#import "UIImageView+WebCache.h"

@implementation XBImagePageView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

- (void)setImagePath:(NSString *)imagePath
{
    if(imagePath == _imagePath || imagePath == nil) return;
    
    _imagePath = imagePath;
    
    [self.imageView setImageWithURL:[NSURL URLWithString:imagePath]
                   placeholderImage:nil];
}

@end
