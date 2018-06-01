//
//  XGNavigationController.m
//  XMG
//
//  Created by 小马哥 on 2017/9/18.
//  Copyright © 2017年 Zhao Chen. All rights reserved.
//

#import "XGNavigationController.h"

@interface XGNavigationController ()

@end

@implementation XGNavigationController

- (instancetype)initWithRootViewController:(UIViewController *)rootViewController
{
    self = [super initWithRootViewController:rootViewController];
    if (self)
    {
        self.navigationBar.barStyle = UIBarStyleBlack;
        self.navigationBar.tintColor = COLOR_HEX(@"#ffffff");
        self.navigationBar.barTintColor = COLOR_HEX(@"#1f79ff");
        [self.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor], NSFontAttributeName:[UIFont systemFontOfSize:18]}];

        [[UIApplication sharedApplication] setStatusBarHidden:NO withAnimation:UIStatusBarAnimationNone];
        [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault];
        
        //设置导航栏的字体包括backBarButton和leftBarButton，rightBarButton的字体
        UIBarButtonItem * appearance = [UIBarButtonItem appearanceWhenContainedIn:[UINavigationBar class], nil];
        [appearance setTitleTextAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:14]} forState:UIControlStateNormal];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
}

@end
