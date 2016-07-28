#import "Page1_1ViewController.h"
#import "ZJVc2Controller.h"
#import "AppDelegate.h"//1
@interface Page1_1ViewController ()
@property (strong, nonatomic) NSString *receiveData;
@property NSString *page1Select;
@end

@implementation Page1_1ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    AppDelegate *app =  [[UIApplication sharedApplication] delegate];
    app.pageNameFor1_0=@"page1";
    self.labelTitle.text=app.selectName;
    self.img.image=[UIImage imageNamed:app.selectImg];
    self.textViewDialog.text=app.selectDialog;

    [_buttonPhone setTitle:app.selectPhone forState:UIControlStateNormal];
    [_buttonAddress setTitle:app.selectAddress forState:UIControlStateNormal];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

-(void)sendTextToViewController:(NSString *)string{

    self.labelTitle.text=string;
}
- (IBAction)btnPhoneClick:(id)sender {
    // 產生一個UIAlertController，其風格為UIAlertControllerStyleAlert
    // 風格還可以換成 UIAlertControllerStyleActionSheet
    AppDelegate *app =  [[UIApplication sharedApplication] delegate];
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"是否撥打電話" message:@"" preferredStyle:UIAlertControllerStyleAlert];
    // 宣告一個「確定」按鈕
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"確定撥出" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        // 按鈕按下去後要做的事情寫在這
        AppDelegate *app =  [[UIApplication sharedApplication] delegate];
        
        
        
        
        NSString *phoneNum = [NSString stringWithFormat:@"tel://%@",app.selectPhone];
        NSURL *url = [NSURL URLWithString:phoneNum];
        [[UIApplication sharedApplication] openURL:url];
        [self dismissViewControllerAnimated:YES completion:nil];
    }];
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        // 按鈕按下去後要做的事情寫在這
        [self dismissViewControllerAnimated:YES completion:nil];
    }];
    // 將確定按鈕加到UIAlertController中
    [alertController addAction:okAction];
    [alertController addAction:cancelAction];
    
    // 顯示這個controller，也就是訊息框
    [self presentViewController:alertController animated:YES completion:nil];
    
    
    
    
    

}

@end
