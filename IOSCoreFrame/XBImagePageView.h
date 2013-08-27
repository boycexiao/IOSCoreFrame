//
//  XBImagePageView.h
//  IOSCoreFrame
//
//  Created by XiaoBin on 13-8-21.
//  Copyright (c) 2013年 XiaoBin. All rights reserved.
//

#import "NIPageView.h"

@interface XBImagePageView : NIPageView

@property (weak, nonatomic) IBOutlet UIImageView *imageView;

@property (strong, nonatomic) NSString *imagePath;

@end
