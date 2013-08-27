//
//  XBWaterFlowCell.m
//  IOSCoreFrame
//
//  Created by XiaoBin on 13-8-7.
//  Copyright (c) 2013年 XiaoBin. All rights reserved.
//

#import "XBWaterFlowCell.h"
#import "UIImageView+WebCache.h"

@implementation XBWaterFlowCell

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


- (void)setImageURL:(NSString *)imageURL
{
    if (_imageURL == imageURL) {
        return;
    }
    
    _imageURL = imageURL;
    
    if (imageURL != nil) {
        [self.imageView setImageWithURL:[NSURL URLWithString:imageURL]];
    }
}


@end
