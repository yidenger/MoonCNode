//
//  MoonTabBarController.m
//  MoonCNode
//
//  Created by seth on 16/6/1.
//  Copyright © 2016年 seth. All rights reserved.
//

#import "MoonTabBarController.h"
#import "MoonEssenceTableViewController.h"
#import "MoonHomeTableViewController.h"
#import "MoonQATableViewController.h"
#import "MoonRecruitTableViewController.h"
#import "MoonShareTableViewController.h"

@interface MoonTabBarController ()

@end

@implementation MoonTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSLog(@"come into...");
    
    //首页
    MoonHomeTableViewController *homeVC = [[MoonHomeTableViewController alloc]init];
    [self setupOneChildController:homeVC image:[UIImage imageNamed:@"Home"] andSelectedImage:[UIImage imageNamed:@"Home_selected"] WithTitle:@"首页"];
    //精华
    MoonEssenceTableViewController *essenceVC = [[MoonEssenceTableViewController alloc]init];
    [self setupOneChildController:essenceVC image:[UIImage imageNamed:@"Essence"] andSelectedImage:[UIImage imageNamed:@"Essence_selected"] WithTitle:@"精华"];
    //分享
    MoonShareTableViewController *shareVC = [[MoonShareTableViewController alloc]init];
    [self setupOneChildController:shareVC image:[UIImage imageNamed:@"Share"] andSelectedImage:[UIImage imageNamed:@"Share_selected"] WithTitle:@"分享"];
    //问答
    MoonQATableViewController *qaVC = [[MoonQATableViewController alloc]init];
    [self setupOneChildController:qaVC image:[UIImage imageNamed:@"QA"] andSelectedImage:[UIImage imageNamed:@"QA_selected"] WithTitle:@"问答"];
    //招聘
    MoonRecruitTableViewController *restrictVC = [[MoonRecruitTableViewController alloc]init];
    [self setupOneChildController:restrictVC image:[UIImage imageNamed:@"Recruit"] andSelectedImage:[UIImage imageNamed:@"Recruit_selected"] WithTitle:@"招聘"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

-(void)setupOneChildController:(UIViewController *)vc image:(UIImage *)image andSelectedImage:(UIImage *)selectedImg WithTitle: (NSString *)title{

    UINavigationController *nav = [[UINavigationController alloc]initWithRootViewController:vc];
    
    nav.tabBarItem = [[UITabBarItem alloc]initWithTitle:title image:[image imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] selectedImage:[selectedImg imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
    vc.navigationItem.title = title;
    
    [self addChildViewController:nav];
}



@end
