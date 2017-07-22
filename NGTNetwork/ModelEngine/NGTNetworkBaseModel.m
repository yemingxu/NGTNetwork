//
//  NGTNetworkBaseModel.m
//  Youdoneed
//
//  Created by JoeXu on 2017/7/13.
//  Copyright © 2017年 李凌辉. All rights reserved.
//

#import "NGTNetworkBaseModel.h"
#import "MJExtension.h"

@implementation NGTNetworkBaseModel

+ (NSArray *)mj_ignoredPropertyNames{
    return @[@"urlString",@"superclass",@"hash",@"description",@"debugDescription"];
}

- (NSMutableDictionary *)ngt_keyValues{
    return [self mj_keyValues];
}

+ (instancetype)modelFromKeyValues:(id)keyValues{
    return [self mj_objectWithKeyValues:keyValues];
}
@end




