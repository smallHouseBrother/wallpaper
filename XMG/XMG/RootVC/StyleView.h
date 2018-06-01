//
//  StyleView.h
//  XMG
//
//  Created by jrweid on 2018/6/1.
//  Copyright © 2018年 小马哥. All rights reserved.
//

#import <UIKit/UIKit.h>

@class StyleInfo;

@protocol StyleViewDelegate <NSObject>

- (void)didSelectRowWithInfo:(StyleInfo *)info;

@end

@interface StyleView : UIView

@property (nonatomic, weak) id <StyleViewDelegate> delegate;

- (instancetype)initWithStyleArray:(NSArray *)dataArray;

@end
