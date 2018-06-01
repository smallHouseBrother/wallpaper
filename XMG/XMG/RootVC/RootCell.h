//
//  RootCell.h
//  XMG
//
//  Created by jrweid on 2018/6/1.
//  Copyright © 2018年 小马哥. All rights reserved.
//

#import <UIKit/UIKit.h>

@class RootInfo;

@interface RootCell : UICollectionViewCell

- (void)reloadRootCellWithInfo:(RootInfo *)info;

@end


@interface advCell : UICollectionViewCell

- (void)reloadAdvCellWithInfo:(RootInfo *)info;

@end

