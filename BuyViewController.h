//
//  BuyViewController.h
//  proj0628
//
//  Created by YannLin on 2016/7/17.
//  Copyright © 2016年 ZeroJ. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BuyViewController : UIViewController

@property (strong, nonatomic) IBOutlet UIButton *buttonTotal;
@property (strong, nonatomic) IBOutlet UITableView *tableMsg;
@property(strong , nonatomic) NSMutableArray *arrayMsg;
@property(strong , nonatomic) NSMutableArray *arrayDialog;
@property (strong , nonatomic)NSString *total;
@end
