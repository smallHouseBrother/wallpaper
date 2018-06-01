//
//  RootViewController.m
//  XMG
//
//  Created by Zhao Chen on 2018/1/26.
//  Copyright © 2018年 小马哥. All rights reserved.
//

#import "RootViewController.h"
#import "DataRequest.h"
#import "RootView.h"
#import "RootInfo.h"
#import "XGNavigationController.h"
#import "StyleViewController.h"
#import "StyleInfo.h"

@interface RootViewController () <StyleViewControllerDelegate>
{
    NSArray * _styleArray;
}
@end

@implementation RootViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self setNavigation];
    
    [self addSubViews];
}

- (void)setNavigation
{
    UIBarButtonItem * right = [[UIBarButtonItem alloc] initWithTitle:@"风格" style:0 target:self action:@selector(selectStyle)];
    self.navigationItem.rightBarButtonItem = right;
}

- (void)selectStyle
{
    StyleViewController * styleVC = [[StyleViewController alloc] initWithStyleArray:_styleArray];
    styleVC.delegate = self;
    XGNavigationController * styleNavi = [[XGNavigationController alloc] initWithRootViewController:styleVC];
    [self presentViewController:styleNavi animated:YES completion:nil];
}

#pragma mark - StyleViewControllerDelegate
- (void)returnStyleInfo:(StyleInfo *)info
{
    NSLog(@"______%@________%@", info.styleId, info.name);
    
    self.title = info.name;
}

- (void)addSubViews
{
    RootView * selfView = [[RootView alloc] init];
    self.view = selfView;
    
    if (@available(iOS 11.0, *)) {
        if (iPhoneX)    return;
        selfView.collectionView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    } else {
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
    
    [DataRequest getWithBaseURL:@"http://cdn.apc.360.cn/index.php?c=WallPaper&a=getAllCategoriesV2&from=360chrome" withPath:nil withParams:nil withSuccess:^(id jsonData) {
        NSArray * data = [jsonData objectForKey:@"data"];
        _styleArray = [StyleInfo parserStyleArray:data];
        for (NSDictionary * dic in data) {
            NSLog(@"%@___________", [dic objectForKey:@"name"]);
            NSString * Cid = [dic objectForKey:@"id"];
            [self requestDataWithCid:Cid withStart:@"0" withCount:@"20"];
            break;
        }
    } withFailure:^(NSError *error) {
        
    }];
}

- (void)requestDataWithCid:(NSString *)Cid withStart:(NSString *)start withCount:(NSString *)count
{
    NSString * url = [NSString stringWithFormat:@"http://wallpaper.apc.360.cn/index.php?c=WallPaper&a=getAppsByCategory&cid=%@&start=%@&count=%@&from=360chrome", Cid, start, count];
    [DataRequest getWithBaseURL:url withPath:nil withParams:nil withSuccess:^(id jsonData) {
        NSArray * data = [jsonData objectForKey:@"data"];
        NSArray * dataArray = [RootInfo parserWallPaperArray:data];
        [(RootView *)self.view reloadRootCollectionWithArray:dataArray];
    } withFailure:^(NSError *error) {
        
    }];

}

@end
