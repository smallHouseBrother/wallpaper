//
//  RootView.h
//  XMG
//
//  Created by jrweid on 2018/6/1.
//  Copyright © 2018年 小马哥. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RootView : UIView

@property (nonatomic, strong) UICollectionView * collectionView;

- (void)reloadRootCollectionWithArray:(NSArray *)dataArray;

@end
