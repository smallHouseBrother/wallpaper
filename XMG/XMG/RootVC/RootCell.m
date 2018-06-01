//
//  RootCell.m
//  XMG
//
//  Created by jrweid on 2018/6/1.
//  Copyright © 2018年 小马哥. All rights reserved.
//

#import "RootCell.h"
#import "RootInfo.h"

@interface RootCell ()
{
    UIImageView * _imageView;
}
@end

@implementation RootCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        [self addSubViews];
    }
    return self;
}

- (void)addSubViews
{
    _imageView = [[UIImageView alloc] init];
    _imageView.backgroundColor = COLOR_HEX(@"#f2f2f2");
    [self.contentView addSubview:_imageView];
    _imageView.sd_layout.spaceToSuperView(UIEdgeInsetsZero);
}

- (void)reloadRootCellWithInfo:(RootInfo *)info
{
    [_imageView sd_setImageWithURL:[NSURL URLWithString:info.url]];
}

@end


@interface advCell ()
{
    
}
@end

@implementation advCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        [self addSubViews];
    }
    return self;
}

- (void)addSubViews
{
    
}

- (void)reloadAdvCellWithInfo:(RootInfo *)info
{
    
}

@end
