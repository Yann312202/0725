

#import "Draw2ViewController.h"
#import "ZJScrollPageView.h"
#import "SWRevealViewController.h"
#import <QuartzCore/QuartzCore.h>
#import "Page1_1ViewController.h"
#import "AppDelegate.h"//1
@interface Draw2ViewController (){
    
}
@property (strong, nonatomic) UIViewController *pageNext;
@end

@implementation Draw2ViewController
@synthesize pageNext;
- (void)viewDidLoad {
    [super viewDidLoad];
    
    AppDelegate *delegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    sqlite3 *db = [delegate getDB];
    AppDelegate *app =  [[UIApplication sharedApplication] delegate];
    app.pageName=@"pageStart";
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
        self.arrayMsg = arrayMsg;
        self.arrayDialog=arrayDialog;
    }
    
    
    
    
    
    
    
}
//按了cell的動作
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
        AppDelegate *app =  [[UIApplication sharedApplication] delegate];

    pageNext = [self.storyboard instantiateViewControllerWithIdentifier:@"page1_0"];
    [self.navigationController pushViewController:pageNext animated:YES];
    app.pageName=@"draw2";
    app.pageNameFor1_0=@"page4";
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
    
    
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath{
    return YES;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
@end
