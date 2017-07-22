//
//  NGTNetworkEngine.h
//  Youdoneed
//
//  Created by JoeXu on 2017/7/13.
//  Copyright © 2017年 李凌辉. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^NGTNetworkCompletion)(id result, NSError *error);


@interface NGTNetworkManager : NSObject

+ (instancetype)manager;

/**
 *  GET请求
 */
- (void)GET:(NSString *)url
      param:(NSDictionary *)param
 completion:(NGTNetworkCompletion)completion;



/**
 *  POST请求
 */
- (void)POST:(NSString *)url
       param:(NSDictionary *)param
  completion:(NGTNetworkCompletion)completion;



@end



