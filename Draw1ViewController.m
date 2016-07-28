

#import "Draw1ViewController.h"
#import "ZJScrollPageView.h"
#import "SWRevealViewController.h"
#import <QuartzCore/QuartzCore.h>
#import "Page1_1ViewController.h"
#import "AppDelegate.h"//1
@interface Draw1ViewController (){
    
}
@property (strong, nonatomic) UIViewController *pageNext;
@end

@implementation Draw1ViewController
@synthesize pageNext;
- (void)viewDidLoad {
    [super viewDidLoad];
    
    AppDelegate *delegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    sqlite3 *db = [delegate getDB];
        AppDelegate *app =  [[UIApplication sharedApplication] delegate];  
//    app.pageName=@"pageStart";
    app.pageName=@"draw1";
    if (db != nil) {
        sqlite3_stmt *statement;
        NSMutableArray *arrayMsg = [[NSMutableArray alloc]init];
        NSMutableArray *arrayDialog = [[NSMutableArray alloc]init];
        NSString *sqlNsstring = [NSString stringWithFormat:@"SELECT * FROM pageFav"];
        
        const char *sql = [sqlNsstring cStringUsingEncoding:NSUTF8StringEncoding];
        sqlite3_prepare(db, sql, -1, &statement, NULL);
        
        arrayMsg = [[NSMutableArray alloc]init];
        arrayDialog = [[NSMutableArray alloc]init];
        while (sqlite3_step(statement) == SQLITE_ROW) {
            char *name = (char *)sqlite3_column_text(statement, 1);
            
            [arrayMsg addObject:[NSString stringWithCString:name encoding:NSUTF8StringEncoding]];
        }
        self.dataMsg = arrayMsg;
    }
    

    
    
    
    
    
}
//按了cell的動作
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
pageNext = [self.storyboard instantiateViewControllerWithIdentifier:@"page1_0"];
[self.navigationController pushViewController:pageNext animated:YES];
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if(tableView ==self.tableMsg){
        return [self.dataMsg count];
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
        cell.textLabel.text = [self.dataMsg objectAtIndex:indexPath.row] ;
        cell.detailTextLabel.text=[self.dataMsg objectAtIndex:indexPath.row] ;
        cell.imageView.image=[UIImage imageNamed:@"na.png"];
    }
    return cell;
}


//刪除
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{

    if (editingStyle == UITableViewCellEditingStyleDelete) {

    }
    NSString *name=[self.dataMsg objectAtIndex:indexPath.row];
    NSLog(@"我要刪除 - %@",name);
    [self.dataMsg removeObjectAtIndex:indexPath.row];
    [self.tableMsg deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
    
    AppDelegate *delegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    sqlite3 *db = [delegate getDB];
    if (db != nil) {
        sqlite3_stmt *statement;
        NSString *sqlNsstring = [NSString stringWithFormat:@"DELETE FROM pageFav WHERE name ='%@'",name];
        
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
