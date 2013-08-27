//
//  XBPersonManager.m
//  IOSCoreFrame
//
//  Created by XiaoBin on 13-8-27.
//  Copyright (c) 2013年 XiaoBin. All rights reserved.
//

#import "XBPersonManager.h"

@implementation XBPersonManager

+ (XBPersonManager *)sharedPersonManger
{
    static XBPersonManager *personManager;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        personManager = [[XBPersonManager alloc] init];
    });
    
    return personManager;
}




@end
