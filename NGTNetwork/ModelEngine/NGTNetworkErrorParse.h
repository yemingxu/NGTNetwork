//
//  NGTNetworkErrorParse.h
//  Youdoneed
//
//  Created by JoeXu on 2017/7/20.
//  Copyright © 2017年 李凌辉. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NGTNetworkErrorParse : NSObject
+ (NSError *)parseResponse:(NSDictionary *)response;
@end
