//
//  XBServiceManager.m
//  IOSCoreFrame
//
//  Created by XiaoBin on 13-8-9.
//  Copyright (c) 2013年 XiaoBin. All rights reserved.
//

#import "XBServiceManager.h"
#import "AFJSONRequestOperation.h"

#define XBSERVICEMANAGER_BASEURL            @""

typedef enum {
    XBSERVICEMANAGER_METHOD_GET,
    XBSERVICEMANAGER_METHOD_POST
    
} XBSERVICEMANAGER_METHOD;

@implementation XBServiceManager

+ (XBServiceManager *)sharedServiceManager
{
    static XBServiceManager *xbServiceMananger = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        xbServiceMananger = [[XBServiceManager alloc] initWithBaseURL:[NSURL URLWithString:XBSERVICEMANAGER_BASEURL]];
    });
    
    return xbServiceMananger;
}

- (id)initWithBaseURL:(NSURL *)url
{
    self = [super initWithBaseURL:url];
    if (self) {
        [self registerHTTPOperationClass:[AFJSONRequestOperation class]];
        [self setDefaultHeader:@"Accept" value:@"application/json"];
  
    }
    return self;
}


- (void)executeRequestWithRelativePath:(NSString *)relativePath
                                method:(XBSERVICEMANAGER_METHOD)methodType
                            parameters:(NSDictionary *)parameters
                               success:(XBSuccessCallBack)success
                               failure:(XBFailureCallBack)failure
{
    
    NSString *methodString = @"";
    switch (methodType) {
        case XBSERVICEMANAGER_METHOD_GET:
        {
            methodString = @"GET";
            break;
        }
        case XBSERVICEMANAGER_METHOD_POST:
        {
            methodString = @"POST";
            break;
        }   
        default:
        {
            methodString = @"GET";
            break;
        }
    }
    
    NSMutableURLRequest *request = [self requestWithMethod:methodString
                                                      path:relativePath
                                                parameters:parameters];
    AFJSONRequestOperation *operation = [AFJSONRequestOperation JSONRequestOperationWithRequest:request
                                                                                        success:success
                                                                                        failure:failure];
    
    [self enqueueHTTPRequestOperation:operation];
}

@end
