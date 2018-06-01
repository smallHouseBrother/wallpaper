//
//  RootView.m
//  XMG
//
//  Created by jrweid on 2018/6/1.
//  Copyright © 2018年 小马哥. All rights reserved.
//

#import "RootView.h"
#import "RootCell.h"
#import "RootInfo.h"

@interface RootView () <UICollectionViewDelegate, UICollectionViewDataSource>
{
    NSArray * _dataArray;
}
@end

@implementation RootView

- (instancetype)init
{
    self = [super init];
    if (self)
    {
        [self addSubViews];
    }
    return self;
}

- (void)addSubViews
{
    UICollectionViewFlowLayout * layout = [[UICollectionViewFlowLayout alloc] init];
    _collectionView = [[UICollectionView alloc] initWithFrame:self.bounds collectionViewLayout:layout];
    _collectionView.backgroundColor = COLOR_HEX(@"#f5f5f5");
    layout.itemSize = CGSizeMake(ScreenWidth, ScreenWidth*216/384);
    layout.minimumLineSpacing = 0;
    layout.minimumInteritemSpacing = 0;
    _collectionView.delegate = self;
    _collectionView.dataSource = self;
    [self addSubview:_collectionView];
    _collectionView.sd_layout.spaceToSuperView(UIEdgeInsetsZero);
    
    [_collectionView registerClass:[RootCell class] forCellWithReuseIdentifier:@"RootCell"];
    
//    __weak XMGServiceView * weakSelf = self;
//    _collectionView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
//        [weakSelf.delegate XMGServiceRefreshByPullDown];
//    }];
}

- (void)reloadRootCollectionWithArray:(NSArray *)dataArray
{
    _dataArray = [dataArray copy];
    
    [_collectionView reloadData];
    
//    if ([_collectionView.mj_header isRefreshing]) {
//        [_collectionView.mj_header endRefreshing];
//    }
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return _dataArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    RootCell * item = [collectionView dequeueReusableCellWithReuseIdentifier:@"RootCell" forIndexPath:indexPath];
    RootInfo * info = _dataArray[indexPath.item];
    [item reloadRootCellWithInfo:info];
    return item;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    RootInfo * info = _dataArray[indexPath.item];
    

}

@end
