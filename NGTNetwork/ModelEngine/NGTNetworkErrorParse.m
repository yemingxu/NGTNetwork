//
//  NGTNetworkErrorParse.m
//  Youdoneed
//
//  Created by JoeXu on 2017/7/20.
//  Copyright © 2017年 李凌辉. All rights reserved.
//

#import "NGTNetworkErrorParse.h"

@implementation NGTNetworkErrorParse


+ (NSError *)parseResponse:(NSDictionary *)response{
    
    return nil;
    
    /*
    BOOL isSuccess = [response[@"success"] boolValue];
    if(isSuccess){
        return nil;
    }else{
        NSError *outputErr = [NSError errorWithDomain:response[@"message"]
                                                 code:[response[@"code"] intValue]
                                             userInfo:nil];
        return outputErr;
    }
    */
}

@end
