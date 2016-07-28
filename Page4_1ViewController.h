//
//  Page4_2ViewController.h
//  proj0628
//
//  Created by YannLin on 2016/7/14.
//  Copyright © 2016年 ZeroJ. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface Page4_1ViewController : UIViewController
@property (strong, nonatomic) IBOutlet UITextField *textQty;
@property (strong, nonatomic) IBOutlet UIStepper *stepperQty;
@property (strong, nonatomic) IBOutlet UITextField *textCountPrice;
@property (strong, nonatomic) IBOutlet UITextField *textPerPrice;

@property (strong, nonatomic) IBOutlet UILabel *labelTitle;
@property (strong, nonatomic) IBOutlet UIImageView *img;
@property (strong, nonatomic) IBOutlet UITextView *textViewDialog;
@property (strong, nonatomic) IBOutlet UIButton *buttonAddress;


@property NSInteger perPrice;

@end
