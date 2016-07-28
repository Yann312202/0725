#import "Page4_1ViewController.h"
#import "AppDelegate.h"//1
@interface Page4_1ViewController ()

@end

@implementation Page4_1ViewController


- (void)viewDidLoad {
    [super viewDidLoad];

    AppDelegate *app =  [[UIApplication sharedApplication] delegate];
    NSLog(@"%@",app.selectId);
    _perPrice=45;

    if ([app.selectId isEqualToString:@"1"]){
        _perPrice=65;
    }
    if ([app.selectId isEqualToString:@"2"]){
        _perPrice=85;
    }
        if ([app.selectId isEqualToString:@"3"]){
        _perPrice=245;
    }
        
        
        
        
        NSLog(@"%ld",(long)_perPrice);
    _textPerPrice.text=[NSString stringWithFormat:@"$%d",(int)_perPrice];
    int qty=(int)_stepperQty.value;
    _textQty.text=[NSString stringWithFormat:@"%d",qty];
    int countPrice=qty*(int)_perPrice;
    _textCountPrice.text=[NSString stringWithFormat:@"$%d",countPrice];
    app.selectQty=_textQty.text;
    app.selectCountPrice=[NSString stringWithFormat:@"%d",countPrice];
    app.selectPerPrice=[NSString stringWithFormat:@"%d",(int)_perPrice];
    app.selectBuyNote=[NSString stringWithFormat:@"數量：%@件,單價：%@,小計：%@",app.selectQty,app.selectPerPrice,app.selectCountPrice];
    
    _textPerPrice.text=[NSString stringWithFormat:@"$%d",(int)_perPrice];

    self.labelTitle.text=app.selectName;
    self.img.image=[UIImage imageNamed:app.selectImg];
    self.textViewDialog.text=app.selectDialog;
    
    
    [_buttonAddress setTitle:app.selectAddress forState:UIControlStateNormal];
}
- (IBAction)btnCarClick:(id)sender {
    
    AppDelegate *app =  [[UIApplication sharedApplication] delegate];
    AppDelegate *delegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    sqlite3 *db = [delegate getDB];
    if (db != nil) {
        sqlite3_stmt *statement;
        NSString *sqlNsstring = [NSString stringWithFormat:@"INSERT INTO pageCar (iid,NAME,qty,perprice,countprice,note) VALUES ('%@','%@','%@','%@','%@','%@')",app.selectId,app.selectName,app.selectQty,app.selectPerPrice,app.selectCountPrice,app.selectBuyNote];
        NSLog(@"%@",sqlNsstring);
        const char *sql = [sqlNsstring cStringUsingEncoding:NSUTF8StringEncoding];
        sqlite3_prepare(db, sql, -1, &statement, NULL);
        
        
        if (sqlite3_step(statement) == SQLITE_DONE) {
            NSLog(@"成功插入一筆資料到購物車");
        } else {
            NSLog(@"失敗插入一筆資料到購物車");
        }
        
    }
    // 產生一個UIAlertController，其風格為UIAlertControllerStyleAlert
    // 風格還可以換成 UIAlertControllerStyleActionSheet
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"已新增至購物車" message:@"新增成功" preferredStyle:UIAlertControllerStyleAlert];
    // 宣告一個「確定」按鈕
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"確定" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        // 按鈕按下去後要做的事情寫在這
        [self dismissViewControllerAnimated:YES completion:nil];
    }];

    // 將確定按鈕加到UIAlertController中
    [alertController addAction:okAction];

    
    // 顯示這個controller，也就是訊息框
    [self presentViewController:alertController animated:YES completion:nil];
    
}

- (IBAction)stepperChanged:(id)sender {
    
    AppDelegate *app =  [[UIApplication sharedApplication] delegate];
    int qty=(int)_stepperQty.value;
    _textQty.text=[NSString stringWithFormat:@"%d",qty];
    int countPrice=qty*(int)_perPrice;
    _textCountPrice.text=[NSString stringWithFormat:@"$%d",countPrice];
    app.selectQty=[NSString stringWithFormat:@"%d",qty];
    app.selectCountPrice=[NSString stringWithFormat:@"%d",countPrice];

    

    app.selectBuyNote=[NSString stringWithFormat:@"數量：%d件,單價：%@,小計：%@",qty,app.selectPerPrice,app.selectCountPrice];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}



@end
