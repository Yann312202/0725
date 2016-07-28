//
//  ZJVc3Controller.m
//  ZJScrollPageView
//
//  Created by jasnig on 16/5/7.
//  Copyright © 2016年 ZeroJ. All rights reserved.
//

#import "ZJVc3Controller.h"
#import "ZJScrollPageView.h"
#import "SWRevealViewController.h"
@interface ZJVc3Controller ()

@end

//    bool mobileStatus=true;
@implementation ZJVc3Controller
//- (IBAction)fav:(id)sender {
//
//
//    if (mobileStatus==true){
//    self.navigationController.navigationBar.barStyle = UIStatusBarStyleDefault;
//    [self.navigationController.navigationBar setTintColor:[UIColor redColor]];
//        mobileStatus=false;
//    }else{
//        self.navigationController.navigationBar.barStyle = UIStatusBarStyleDefault;
//        [self.navigationController.navigationBar setTintColor:[UIColor lightGrayColor]];
//        mobileStatus=true;
//    }
//
//
////
//}

- (void)viewDidLoad {
    [super viewDidLoad];
    _barbutton.target=self.revealViewController;
    _barbutton.action=@selector(revealToggle:);
    [self.view addGestureRecognizer:self.revealViewController.panGestureRecognizer];
    
    
    
    //    self.navigationController.navigationBar.barStyle = UIStatusBarStyleDefault;
    //    [self.navigationController.navigationBar setTintColor:[UIColor greenColor]];
    
        self.title = @"你農我農";
    
    
    //必要的设置, 如果没有设置可能导致内容显示不正常
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    ZJSegmentStyle *style = [[ZJSegmentStyle alloc] init];
    //显示滚动条
    style.showLine = YES;
    // 颜色渐变
    style.gradualChangeTitleColor = YES;
    
    // 设置子控制器 --- 注意子控制器需要设置title, 将用于对应的tag显示title
    NSArray *childVcs = [NSArray arrayWithArray:[self setupChildVcAndTitle]];
    // 初始化
    ZJScrollPageView *scrollPageView = [[ZJScrollPageView alloc] initWithFrame:CGRectMake(0, 64.0, self.view.bounds.size.width, self.view.bounds.size.height - 64.0) segmentStyle:style childVcs:childVcs parentViewController:self];
    
    [self.view addSubview:scrollPageView];
}

- (NSArray *)setupChildVcAndTitle {
    
    UIViewController *vc1 = [self.storyboard instantiateViewControllerWithIdentifier:@"page1_1"];
    vc1.view.backgroundColor = [UIColor whiteColor];
    vc1.title = @"         簡介         ";
    
    UIViewController *vc2 = [self.storyboard instantiateViewControllerWithIdentifier:@"page1_2"];
    vc2.view.backgroundColor = [UIColor whiteColor];
    vc2.title = @"         地圖         ";
    
    UIViewController *vc3 = [self.storyboard instantiateViewControllerWithIdentifier:@"page1_3"];
    vc3.view.backgroundColor = [UIColor whiteColor];
    vc3.title = @"         評分         ";
    

    
    
    NSArray *childVcs = [NSArray arrayWithObjects:vc1, vc2, vc3, nil];
    return childVcs;
}

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

@end
