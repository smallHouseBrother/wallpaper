//
//  StyleView.m
//  XMG
//
//  Created by jrweid on 2018/6/1.
//  Copyright © 2018年 小马哥. All rights reserved.
//

#import "StyleView.h"
#import "StyleInfo.h"

@interface StyleView () <UITableViewDelegate, UITableViewDataSource>
{
    UITableView * _tableView;
    NSArray     * _dataArray;
}
@end

@implementation StyleView

- (instancetype)initWithStyleArray:(NSArray *)dataArray
{
    self = [super init];
    if (self)
    {
        _dataArray = [dataArray copy];
        
        [self addSubviews];
    }
    return self;
}

- (void)addSubviews
{
    _tableView = [[UITableView alloc] init];
    _tableView.tableFooterView = [[UIView alloc] init];
    _tableView.backgroundColor = COLOR_HEX(@"#f5f5f5");
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.rowHeight = 50;
    [self addSubview:_tableView];
    _tableView.sd_layout.spaceToSuperView(UIEdgeInsetsZero);

    [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
    
    [_tableView reloadData];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    StyleInfo * info = _dataArray[indexPath.row];
    cell.textLabel.text = info.name;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];

    StyleInfo * info = _dataArray[indexPath.row];

    [self.delegate didSelectRowWithInfo:info];
}

@end
