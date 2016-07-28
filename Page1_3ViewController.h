//
//  Page1_3ViewController.h
//  proj0628
//
//  Created by YannLin on 2016/6/30.
//  Copyright © 2016年 ZeroJ. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface Page1_3ViewController : UIViewController

@property (strong, nonatomic) IBOutlet UITextField *textLeave;
@property (strong, nonatomic) IBOutlet UITableView *tableMsg;
@property(strong , nonatomic) NSMutableArray *arrayMsg;
@property(strong , nonatomic) NSMutableArray *dataMsg;
@property (strong, nonatomic) IBOutlet UILabel *label_star;

@property (strong, nonatomic) IBOutlet UIButton *btn_Star1;
@property (strong, nonatomic) IBOutlet UIButton *btn_Star2;
@property (strong, nonatomic) IBOutlet UIButton *btn_Star3;
@property (strong, nonatomic) IBOutlet UIButton *btn_Star4;
@property (strong, nonatomic) IBOutlet UIButton *btn_Star5;

@end
