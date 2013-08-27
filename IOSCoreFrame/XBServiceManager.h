//
//  XBServiceManager.h
//  IOSCoreFrame
//
//  Created by XiaoBin on 13-8-9.
//  Copyright (c) 2013年 XiaoBin. All rights reserved.
//

#import "AFHTTPClient.h"

typedef void (^XBSuccessCallBack)(NSURLRequest *request, NSHTTPURLResponse *response, id JSON);
typedef void (^XBFailureCallBack)(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error, id JSON);


@interface XBServiceManager : AFHTTPClient

+ (XBServiceManager *)sharedServiceManager;

@end
