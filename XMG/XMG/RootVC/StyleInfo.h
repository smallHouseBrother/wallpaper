//
//  StyleInfo.h
//  XMG
//
//  Created by jrweid on 2018/6/1.
//  Copyright © 2018年 小马哥. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface StyleInfo : NSObject

///类型id
@property (nonatomic, copy) NSString * styleId;
///类型名
@property (nonatomic, copy) NSString * name;

+ (NSArray <StyleInfo *> *)parserStyleArray:(NSArray *)dataArray;

@end
