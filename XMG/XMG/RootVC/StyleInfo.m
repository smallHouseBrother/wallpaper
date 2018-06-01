//
//  StyleInfo.m
//  XMG
//
//  Created by jrweid on 2018/6/1.
//  Copyright © 2018年 小马哥. All rights reserved.
//

#import "StyleInfo.h"

@implementation StyleInfo

- (instancetype)initWithSingleStyleDictionary:(NSDictionary *)dictionary
{
    self = [super init];
    if (self)
    {
        _styleId = [dictionary objectForKey:@"id"];
        
        _name = [dictionary objectForKey:@"name"];
    }
    return self;
}

+ (NSArray<StyleInfo *> *)parserStyleArray:(NSArray *)dataArray
{
    if (!dataArray || dataArray.count == 0) return nil;
    NSMutableArray * backArray = [NSMutableArray array];
    for (NSDictionary * dic in dataArray) {
        StyleInfo * info = [[StyleInfo alloc] initWithSingleStyleDictionary:dic];
        [backArray addObject:info];
    }
    return [backArray copy];
}

@end
