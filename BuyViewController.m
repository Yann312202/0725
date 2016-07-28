

#import "BuyViewController.h"
#import "ZJScrollPageView.h"
#import "SWRevealViewController.h"
#import <QuartzCore/QuartzCore.h>
#import "Page1_1ViewController.h"
#import "AppDelegate.h"//1
@interface BuyViewController (){
    
}
@property (strong, nonatomic) UIViewController *pageNext;
@end

@implementation BuyViewController
@synthesize pageNext;


- (IBAction)barBack:(id)sender {
    AppDelegate *app =  [[UIApplication sharedApplication] delegate];
    pageNext = [self.storyboard instantiateViewControllerWithIdentifier:app.pageBack];
    [self.navigationController pushViewController:pageNext animated:YES];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    AppDelegate *delegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    sqlite3 *db = [delegate getDB];
    AppDelegate *app =  [[UIApplication sharedApplication] delegate];
    app.pageName=@"pageStart";
    app.pageBack=@"pageStart";
    if (db != nil) {
        sqlite3_stmt *statement;
        NSMutableArray *arrayMsg = [[NSMutableArray alloc]init];
        NSMutableArray *arrayDialog = [[NSMutableArray alloc]init];
        NSMutableArray *arrayQty = [[NSMutableArray alloc]init];
        NSMutableArray *arrayPerPrice = [[NSMutableArray alloc]init];
        NSMutableArray *arrayCountPrice = [[NSMutableArray alloc]init];
        
        NSString *sqlNsstring = [NSString stringWithFormat:@"SELECT * FROM pageCar"];
        
        const char *sql = [sqlNsstring cStringUsingEncoding:NSUTF8StringEncoding];
        sqlite3_prepare(db, sql, -1, &statement, NULL);
        
        arrayMsg = [[NSMutableArray alloc]init];
        arrayDialog = [[NSMutableArray alloc]init];
        arrayQty = [[NSMutableArray alloc]init];
        arrayPerPrice = [[NSMutableArray alloc]init];
        arrayCountPrice = [[NSMutableArray alloc]init];
        
        
        while (sqlite3_step(statement) == SQLITE_ROW) {
            char *name = (char *)sqlite3_column_text(statement, 1);
            
            char *qty = (char *)sqlite3_column_text(statement, 13);
            
            char *perPrice = (char *)sqlite3_column_text(statement, 14);
            
            char *countPrice = (char *)sqlite3_column_text(statement, 15);
            char *note = (char *)sqlite3_column_text(statement, 16);
            [arrayMsg addObject:[NSString stringWithCString:name encoding:NSUTF8StringEncoding]];
            [arrayQty addObject:[NSString stringWithCString:qty encoding:NSUTF8StringEncoding]];
            [arrayPerPrice addObject:[NSString stringWithCString:perPrice encoding:NSUTF8StringEncoding]];
            [arrayCountPrice addObject:[NSString stringWithCString:countPrice encoding:NSUTF8StringEncoding]];
            [arrayDialog addObject:[NSString stringWithCString:note encoding:NSUTF8StringEncoding]];
        }
        
        NSNumber *sumQty = [NSNumber numberWithInt:0];
        NSNumber *sumPrice=[NSNumber numberWithInt:0];
        NSNumber *a=[NSNumber numberWithInt:0];
        NSNumber *b=[NSNumber numberWithInt:0];
        NSLog(@"ArrayQtyCount=%lu",(unsigned long)arrayQty.count);
        
        for (int i=0;i<arrayQty.count;i++){
            a = [arrayQty objectAtIndex:i];
            b=[arrayCountPrice objectAtIndex:i];
            NSLog(@"Qty=%@,countprice=%@",a,b);
            sumQty = @([a intValue] + [sumQty intValue]);
            sumPrice= @([b intValue] + [sumPrice intValue]);
            NSLog(@" SumQty = %d,sumPrice=%d", [sumQty intValue],[sumPrice intValue]);
            
        }
        _total=[NSString stringWithFormat:@"總數量：%@件,總金額：$%@",sumQty,sumPrice];
        [self.buttonTotal setTitle:_total forState:UIControlStateNormal];
        self.arrayMsg = arrayMsg;
        self.arrayDialog=arrayDialog;
    }
    
    
    
    
    
    
    
}
//按了cell的動作
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    AppDelegate *app =  [[UIApplication sharedApplication] delegate];
    app.pageNameFor1_0=@"page4";
    pageNext = [self.storyboard instantiateViewControllerWithIdentifier:@"page1_0"];
    [self.navigationController pushViewController:pageNext animated:YES];
    app.pageName=@"buy";
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if(tableView ==self.tableMsg){
        return [self.arrayMsg count];
    }else{
        return 0;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *simpleTableIdentifier = @"SimpleTableItem";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    if (cell == nil) {
        
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:NSLocaleIdentifier];
    }
    if(tableView == self.tableMsg) {
        cell.textLabel.text = [self.arrayMsg objectAtIndex:indexPath.row] ;
        cell.detailTextLabel.text=[self.arrayDialog objectAtIndex:indexPath.row] ;
        //        cell.imageView.image=[UIImage imageNamed:@"na.png"];
    }
    return cell;
}


//刪除
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        
    }
    NSString *name=[self.arrayMsg objectAtIndex:indexPath.row];
    NSLog(@"我要刪除 - %@",name);
    [self.arrayMsg removeObjectAtIndex:indexPath.row];
    [self.tableMsg deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
    
    AppDelegate *delegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    sqlite3 *db = [delegate getDB];
    if (db != nil) {
        sqlite3_stmt *statement;
        NSString *sqlNsstring = [NSString stringWithFormat:@"DELETE FROM pageCar WHERE name ='%@'",name];
        
        const char *sql = [sqlNsstring cStringUsingEncoding:NSUTF8StringEncoding];
        
        
        sqlite3_prepare(db, sql, -1, &statement, NULL);
        NSLog(@"%@",sqlNsstring);
        if (sqlite3_step(statement) == SQLITE_DONE) {
            NSLog(@"成功刪除一筆資料");
        } else {
            NSLog(@"刪除一筆資料失敗");
        }
        
        
    }
    if (db != nil) {
        sqlite3_stmt *statement;
        NSMutableArray *arrayMsg = [[NSMutableArray alloc]init];
        NSMutableArray *arrayDialog = [[NSMutableArray alloc]init];
        NSMutableArray *arrayQty = [[NSMutableArray alloc]init];
        NSMutableArray *arrayPerPrice = [[NSMutableArray alloc]init];
        NSMutableArray *arrayCountPrice = [[NSMutableArray alloc]init];
        
        NSString *sqlNsstring = [NSString stringWithFormat:@"SELECT * FROM pageCar"];
        
        const char *sql = [sqlNsstring cStringUsingEncoding:NSUTF8StringEncoding];
        sqlite3_prepare(db, sql, -1, &statement, NULL);
        
        arrayMsg = [[NSMutableArray alloc]init];
        arrayDialog = [[NSMutableArray alloc]init];
        arrayQty = [[NSMutableArray alloc]init];
        arrayPerPrice = [[NSMutableArray alloc]init];
        arrayCountPrice = [[NSMutableArray alloc]init];
        
        
        while (sqlite3_step(statement) == SQLITE_ROW) {
            char *name = (char *)sqlite3_column_text(statement, 1);
            
            char *qty = (char *)sqlite3_column_text(statement, 13);
            
            char *perPrice = (char *)sqlite3_column_text(statement, 14);
            
            char *countPrice = (char *)sqlite3_column_text(statement, 15);
            char *note = (char *)sqlite3_column_text(statement, 16);
            [arrayMsg addObject:[NSString stringWithCString:name encoding:NSUTF8StringEncoding]];
            [arrayQty addObject:[NSString stringWithCString:qty encoding:NSUTF8StringEncoding]];
            [arrayPerPrice addObject:[NSString stringWithCString:perPrice encoding:NSUTF8StringEncoding]];
            [arrayCountPrice addObject:[NSString stringWithCString:countPrice encoding:NSUTF8StringEncoding]];
            [arrayDialog addObject:[NSString stringWithCString:note encoding:NSUTF8StringEncoding]];
        }
        
        NSNumber *sumQty = [NSNumber numberWithInt:0];
        NSNumber *sumPrice=[NSNumber numberWithInt:0];
        NSNumber *a=[NSNumber numberWithInt:0];
        NSNumber *b=[NSNumber numberWithInt:0];
        NSLog(@"ArrayQtyCount=%lu",(unsigned long)arrayQty.count);
        
        for (int i=0;i<arrayQty.count;i++){
            a = [arrayQty objectAtIndex:i];
            b=[arrayCountPrice objectAtIndex:i];
            NSLog(@"Qty=%@,countprice=%@",a,b);
            sumQty = @([a intValue] + [sumQty intValue]);
            sumPrice= @([b intValue] + [sumPrice intValue]);
            NSLog(@" SumQty = %d,sumPrice=%d", [sumQty intValue],[sumPrice intValue]);
            
        }
        _total=[NSString stringWithFormat:@"總數量：%@件,總金額：$%@",sumQty,sumPrice];
        [self.buttonTotal setTitle:_total forState:UIControlStateNormal];
        self.arrayMsg = arrayMsg;
        self.arrayDialog=arrayDialog;
    }
    
}
- (IBAction)buttonSend:(id)sender {
    // 產生一個UIAlertController，其風格為UIAlertControllerStyleAlert
    // 風格還可以換成 UIAlertControllerStyleActionSheet
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"是否送出訂單?" message:_total preferredStyle:UIAlertControllerStyleAlert];
    // 宣告一個「確定」按鈕
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"確定" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        // 按鈕按下去後要做的事情寫在這
        
        UIAlertController *alertController2 = [UIAlertController alertControllerWithTitle:@"抱歉目前尚未開放訂購" message:_total preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *okAction2= [UIAlertAction actionWithTitle:@"確定" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
            // 按鈕按下去後要做的事情寫在這
            
            [self dismissViewControllerAnimated:YES completion:nil];
            
        }];
        
            [alertController2 addAction:okAction2];
            [self presentViewController:alertController2 animated:YES completion:nil];
        
//        [self dismissViewControllerAnimated:YES completion:nil];
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

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath{
    return YES;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
@end
