//
//  RootInfo.h
//  XMG
//
//  Created by jrweid on 2018/6/1.
//  Copyright © 2018年 小马哥. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RootInfo : NSObject

@property (nonatomic, copy) NSString * download_times;

@property (nonatomic, copy) NSString * tag;

@property (nonatomic, copy) NSString * url;

@property (nonatomic, copy) NSString * utag;

+ (NSArray <RootInfo *> *)parserWallPaperArray:(NSArray *)dataArray;

@end
