//
//  StyleViewController.m
//  XMG
//
//  Created by jrweid on 2018/6/1.
//  Copyright © 2018年 小马哥. All rights reserved.
//

#import "StyleViewController.h"
#import "StyleView.h"
#import "StyleInfo.h"

@interface StyleViewController () <StyleViewDelegate>
{
    NSArray * _dataArray;
}
@end

@implementation StyleViewController

- (instancetype)initWithStyleArray:(NSArray *)dataArray
{
    self = [super init];
    if (self)
    {
        _dataArray = [dataArray copy];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self setNavigation];
    
    [self addSubViews];
}

- (void)setNavigation
{
    self.title = @"分类";
    
    UIBarButtonItem * right = [[UIBarButtonItem alloc] initWithTitle:@"关闭" style:0 target:self action:@selector(closeStyleSelect)];
    self.navigationItem.rightBarButtonItem = right;
}

- (void)addSubViews
{
    StyleView * selfView = [[StyleView alloc] initWithStyleArray:_dataArray];
    selfView.delegate = self;
    self.view = selfView;
}

- (void)closeStyleSelect
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)didSelectRowWithInfo:(StyleInfo *)info
{
    [self.delegate returnStyleInfo:info];
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
