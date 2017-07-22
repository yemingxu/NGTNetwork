//
//  NGTNetworkBaseModel.h
//  Youdoneed
//
//  Created by JoeXu on 2017/7/13.
//  Copyright © 2017年 李凌辉. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NGTNetworkBaseModel : NSObject

+ (NSArray *)mj_ignoredPropertyNames;

- (NSMutableDictionary *)ngt_keyValues;

+ (instancetype)modelFromKeyValues:(id)keyValues;

@end



