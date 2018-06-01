//
//  RootInfo.m
//  XMG
//
//  Created by jrweid on 2018/6/1.
//  Copyright © 2018年 小马哥. All rights reserved.
//

#import "RootInfo.h"

@implementation RootInfo

- (instancetype)initWithSingleWallPaperDictionary:(NSDictionary *)dictionary
{
    self = [super init];
    if (self)
    {
        _download_times = [dictionary objectForKey:@"download_times"];
        
        _tag = [dictionary objectForKey:@"tag"];
        
        _url = [dictionary objectForKey:@"url"];
        
        _utag = [dictionary objectForKey:@"utag"];
    }
    return self;
}

+ (NSArray<RootInfo *> *)parserWallPaperArray:(NSArray *)dataArray
{
    if (!dataArray || dataArray.count == 0) return nil;
    NSMutableArray * backArray = [NSMutableArray array];
    for (NSDictionary * dic in dataArray) {
        RootInfo * info = [[RootInfo alloc] initWithSingleWallPaperDictionary:dic];
        [backArray addObject:info];
    }
    return [backArray copy];
}

@end
