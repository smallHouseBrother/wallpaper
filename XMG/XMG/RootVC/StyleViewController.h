//
//  StyleViewController.h
//  XMG
//
//  Created by jrweid on 2018/6/1.
//  Copyright © 2018年 小马哥. All rights reserved.
//

#import "XGBaseViewController.h"

@class StyleInfo;

@protocol StyleViewControllerDelegate <NSObject>

- (void)returnStyleInfo:(StyleInfo *)info;

@end

@interface StyleViewController : XGBaseViewController

@property (nonatomic, weak) id <StyleViewControllerDelegate> delegate;

- (instancetype)initWithStyleArray:(NSArray *)dataArray;

@end
