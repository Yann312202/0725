#import "ZJScrollPageView.h"
#import "SWRevealViewController.h"
#import "Page3ViewController.h"
#import <QuartzCore/QuartzCore.h>
#import "AppDelegate.h"//1

@interface Page3ViewController (){
}

@end

@implementation Page3ViewController


@synthesize pageNext;

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title=@"推廣美食";
    
    [self.tabBarController.tabBar setHidden:false];//回到此頁不隱藏
    AppDelegate *app =  [[UIApplication sharedApplication] delegate];
    app.pageName=@"page3";
    app.pageNameFor1_0=@"page3";
    
    
    _barbutton.target=self.revealViewController;//設定抽屜
    _barbutton.action=@selector(revealToggle:);//設定抽屜
    [self.view addGestureRecognizer:self.revealViewController.panGestureRecognizer];//抽屜手勢
    
    
    //設定樣式
    self.tableArea.hidden = YES;
    self.tableCity.hidden = YES;
    self.tableTown.hidden = YES;
    self.buttonSelect0.userInteractionEnabled = YES;
    [[self.buttonSelect0 layer] setBorderWidth:3.0];//設定邊框粗細
    [[self.buttonSelect0 layer] setBorderColor:[UIColor colorWithRed:1.0 green:0.75 blue:0.0 alpha:0.7].CGColor];//設定邊框顏色
    [[self.buttonSelect0 layer] setCornerRadius:10.0];//設定圓角程度
    self.buttonSelect1.userInteractionEnabled = YES;
    [[self.buttonSelect1 layer] setBorderWidth:3.0];//設定邊框粗細
    [[self.buttonSelect1 layer] setBorderColor:[UIColor colorWithRed:1.0 green:0.75 blue:0.0 alpha:0.7].CGColor];//設定邊框顏色
    [[self.buttonSelect1 layer] setCornerRadius:10.0];//設定圓角程度
    self.buttonSelect2.userInteractionEnabled = YES;
    [[self.buttonSelect2 layer] setBorderWidth:3.0];//設定邊框粗細
    [[self.buttonSelect2 layer] setBorderColor:[UIColor colorWithRed:1.0 green:0.75 blue:0.0 alpha:0.7].CGColor];//設定邊框顏色
    [[self.buttonSelect2 layer] setCornerRadius:10.0];//設定圓角程度
    
    
    //搜尋功能設定
    // 初始化 UISearchController。最後一個參數nil表示搜尋結果要顯示在目前的view上
    mySearchController = [[UISearchController alloc] initWithSearchResultsController:nil];
    // 設定那個 Controller 要負責回應searchBar的更新
    mySearchController.searchResultsUpdater = self;
    // NO代表搜尋時背景不要變暗
    mySearchController.dimsBackgroundDuringPresentation = NO;
    // 要將searBar的高度設定為44.0，searchBar才會出現，預設值為0.0
    CGRect rect = mySearchController.searchBar.frame;
    rect.size.height = 44.0;
    mySearchController.searchBar.frame = rect;
    // 將searchBar放到tableView的上方
    self.tableMsg.tableHeaderView = mySearchController.searchBar;
    // YES表示 UISearchController 的畫面可以覆蓋目前的 controller
    self.definesPresentationContext = YES;
}//ViewDidLoad


//搜尋後更新的方法
-(void)updateSearchResultsForSearchController:(UISearchController *)searchController
{
    AppDelegate *app =  [[UIApplication sharedApplication] delegate];
    if (searchController.isActive) {
        NSString *searchString = searchController.searchBar.text;
        
        if ([searchString length] > 0) {
            NSPredicate *p = [NSPredicate predicateWithFormat:@"SELF CONTAINS[cd] %@", searchString];
            searchResult = [app.arrayName3 filteredArrayUsingPredicate:p];
            
        } else {
            searchResult = nil;
        }
    } else {
        searchResult = nil;
    }
    
    [self.tableMsg reloadData];
}








//Cell內容
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    AppDelegate *app =  [[UIApplication sharedApplication] delegate];
    static NSString *simpleTableIdentifier = @"SimpleTableItem";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:NSLocaleIdentifier];
    }
    
    if (tableView == self.tableArea) {
        cell.textLabel.text = [app.arrayArea objectAtIndex:indexPath.row] ;
    }if (tableView == self.tableCity) {
        cell.textLabel.text = [app.arrayCity objectAtIndex:indexPath.row] ;
        
    }if(tableView == self.tableTown) {
        cell.textLabel.text = [app.arrayTown objectAtIndex:indexPath.row] ;
    }
    [cell setBackgroundColor:[UIColor colorWithRed:1.0 green:0.75 blue:0.0 alpha:0.7]];
    
    if(tableView == self.tableMsg) {//內容頁
        
        if (cell == nil) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"Cell"];
        }
        
        if (searchResult != nil) {
            cell.textLabel.text = [searchResult objectAtIndex:indexPath.row];
        } else {
            cell.textLabel.text = [app.arrayName3 objectAtIndex:indexPath.row];
            cell.detailTextLabel.text=[app.arrayDialog3 objectAtIndex:indexPath.row] ;
        }
        
        cell.imageView.image= [UIImage imageNamed:[app.arrayImg3 objectAtIndex:(indexPath.row)]];
        cell.backgroundColor = ([indexPath row]%2)?[UIColor whiteColor]:[UIColor whiteColor];
        
    }
    
    
    return cell;
}


//按了cell的動作
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    AppDelegate *app =  [[UIApplication sharedApplication] delegate];
    AppDelegate *delegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    sqlite3 *db = [delegate getDB];
    NSMutableArray *arrayId = [[NSMutableArray alloc]init];
    NSMutableArray *arrayName = [[NSMutableArray alloc]init];
    NSMutableArray *arrayLat = [[NSMutableArray alloc]init];
    NSMutableArray *arrayLon = [[NSMutableArray alloc]init];
    NSMutableArray *arrayIntroduction = [[NSMutableArray alloc]init];
    NSMutableArray *arrayPhone = [[NSMutableArray alloc]init];
    NSMutableArray *arrayAddress = [[NSMutableArray alloc]init];
    
    ///////////////選擇Area
    if (tableView == self.tableArea) {
        UITableViewCell *cell = [self.tableArea cellForRowAtIndexPath:indexPath];
        [self.buttonSelect0 setTitle:cell.textLabel.text forState:UIControlStateNormal];
        self.tableArea.hidden = YES;
        [self.buttonSelect1 setTitle:@"所有縣市" forState:UIControlStateNormal];
        
        AppDelegate *delegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
        AppDelegate *app =  [[UIApplication sharedApplication] delegate];
        
        sqlite3 *db = [delegate getDB];
        NSString *sqlNsstring = [NSString stringWithFormat:@"SELECT DISTINCT city FROM PageArea WHERE area ='%@'",cell.textLabel.text];
        if([cell.textLabel.text  isEqual:@"所有"]){
            sqlNsstring = [NSString stringWithFormat:@"SELECT DISTINCT city FROM PageArea"];
            
        }
        
        const char *sql = [sqlNsstring cStringUsingEncoding:NSUTF8StringEncoding];
        sqlite3_stmt *statement;
        sqlite3_prepare(db, sql, -1, &statement, NULL);
        NSMutableArray *arrayCity = [[NSMutableArray alloc]init];
        while (sqlite3_step(statement) == SQLITE_ROW) {
            char *city = (char *)sqlite3_column_text(statement, 0);
            [arrayCity addObject:[NSString stringWithCString:city encoding:NSUTF8StringEncoding]];
        }
        
        app.arrayCity=arrayCity;
        [app.arrayCity insertObject:@"所有" atIndex:0];
        
        
        
        
        //-----Table
        
        sqlNsstring = [NSString stringWithFormat:@"SELECT * FROM page3 WHERE area ='%@'",cell.textLabel.text];
        if ([cell.textLabel.text isEqualToString:@"所有"]){
            sqlNsstring = [NSString stringWithFormat:@"SELECT * FROM page3"];
            [self.buttonSelect0 setTitle:@"所有區域" forState:UIControlStateNormal];
        }
        sql = [sqlNsstring cStringUsingEncoding:NSUTF8StringEncoding];
        sqlite3_prepare(db, sql, -1, &statement, NULL);
        
        NSMutableArray *arrayId = [[NSMutableArray alloc]init];
        NSMutableArray *arrayName = [[NSMutableArray alloc]init];
        NSMutableArray *arrayIntroduction = [[NSMutableArray alloc]init];
        NSMutableArray *arrayImg = [[NSMutableArray alloc]init];
        
        arrayId=[[NSMutableArray alloc]init];
        arrayName = [[NSMutableArray alloc]init];
        arrayIntroduction = [[NSMutableArray alloc]init];
        arrayImg = [[NSMutableArray alloc]init];
        while (sqlite3_step(statement) == SQLITE_ROW) {
            char *id = (char *)sqlite3_column_text(statement, 0);
            char *name = (char *)sqlite3_column_text(statement, 1);
            char *introduction= (char *)sqlite3_column_text(statement, 2);
            char *img= (char *)sqlite3_column_text(statement, 10);
 
            [arrayId addObject:[NSString stringWithCString:id encoding:NSUTF8StringEncoding]];
            [arrayName addObject:[NSString stringWithCString:name encoding:NSUTF8StringEncoding]];
            [arrayIntroduction addObject:[NSString stringWithCString:introduction encoding:NSUTF8StringEncoding]];
            [arrayImg addObject:[NSString stringWithCString:img encoding:NSUTF8StringEncoding]];
        }
        app.arrayId3=arrayId;
        app.arrayName3=arrayName;
        app.arrayDialog3=arrayIntroduction;
        app.arrayImg3=arrayImg;
        
        
        
        [self.tableCity reloadData];
        [self.tableTown reloadData];
        [self.tableMsg reloadData];
        
    }
    
    
    
    
    /////////////////////  點選tableCity //////////////
    if (tableView == self.tableCity) {
        UITableViewCell *cell = [self.tableCity cellForRowAtIndexPath:indexPath];
        [self.buttonSelect1 setTitle:cell.textLabel.text forState:UIControlStateNormal];
        self.tableCity.hidden = YES;
        [self.buttonSelect2 setTitle:@"所有鄉鎮" forState:UIControlStateNormal];
        
        if (db != nil) {
            sqlite3_stmt *statement;
            NSMutableArray *arrayMsg = [[NSMutableArray alloc]init];
            NSMutableArray *arrayDialog = [[NSMutableArray alloc]init];
            NSMutableArray *arrayTown = [[NSMutableArray alloc]init];
            NSString *sqlNsstring = [NSString stringWithFormat:@"SELECT * FROM page3 WHERE city ='%@'",cell.textLabel.text];
            if ([cell.textLabel.text isEqualToString:@"所有"]){
                sqlNsstring = [NSString stringWithFormat:@"SELECT * FROM page3"];
                [self.buttonSelect1 setTitle:@"所有縣市" forState:UIControlStateNormal];
            }
            
            const char *sql = [sqlNsstring cStringUsingEncoding:NSUTF8StringEncoding];
            sqlite3_prepare(db, sql, -1, &statement, NULL);
            
            arrayMsg = [[NSMutableArray alloc]init];
            arrayDialog = [[NSMutableArray alloc]init];
            arrayId=[[NSMutableArray alloc]init];
            arrayName = [[NSMutableArray alloc]init];
            arrayIntroduction = [[NSMutableArray alloc]init];
            arrayLat = [[NSMutableArray alloc]init];
            arrayLon= [[NSMutableArray alloc]init];
            arrayPhone = [[NSMutableArray alloc]init];
            arrayAddress = [[NSMutableArray alloc]init];
            while (sqlite3_step(statement) == SQLITE_ROW) {
                char *id = (char *)sqlite3_column_text(statement, 0);
                char *name = (char *)sqlite3_column_text(statement, 1);
                char *introduction= (char *)sqlite3_column_text(statement, 2);
                char *lat= (char *)sqlite3_column_text(statement, 3);
                char *lon= (char *)sqlite3_column_text(statement, 4);
                char *address= (char *)sqlite3_column_text(statement, 8);
                char *phone= (char *)sqlite3_column_text(statement, 9);
                
                [arrayId addObject:[NSString stringWithCString:id encoding:NSUTF8StringEncoding]];
                [arrayName addObject:[NSString stringWithCString:name encoding:NSUTF8StringEncoding]];
                [arrayLat addObject:[NSString stringWithCString:lat encoding:NSUTF8StringEncoding]];
                [arrayLon addObject:[NSString stringWithCString:lon encoding:NSUTF8StringEncoding]];
                [arrayIntroduction addObject:[NSString stringWithCString:introduction encoding:NSUTF8StringEncoding]];
                [arrayPhone addObject:[NSString stringWithCString:phone encoding:NSUTF8StringEncoding]];
                [arrayAddress addObject:[NSString stringWithCString:address encoding:NSUTF8StringEncoding]];
            }
            
            
            
            
            app.arrayName3=arrayName;
            app.arrayDialog3=arrayIntroduction;
            
            
            
            //area-------------------
            if ([cell.textLabel.text isEqualToString:@"所有"]){
                sqlNsstring = [NSString stringWithFormat:@"SELECT * FROM pageArea" ];
            }else{
                sqlNsstring = [NSString stringWithFormat:@"SELECT * FROM pageArea WHERE city ='%@'",cell.textLabel.text];
            }
            sql = [sqlNsstring cStringUsingEncoding:NSUTF8StringEncoding];
            sqlite3_prepare(db, sql, -1, &statement, NULL);
            arrayTown = [[NSMutableArray alloc]init];
            
            while (sqlite3_step(statement) == SQLITE_ROW) {
                char *town = (char *)sqlite3_column_text(statement, 2);
                [arrayTown addObject:[NSString stringWithCString:town encoding:NSUTF8StringEncoding]];
            }
            app.arrayTown=arrayTown;
            
            
        }
        
        
        
        [self.tableTown reloadData];
        [self.tableMsg reloadData];
        
    }
    
    
    
    
    /////////////////////  點選tableTown Select  //////////////
    if(tableView == self.tableTown){
        UITableViewCell *cell = [self.tableTown cellForRowAtIndexPath:indexPath];
        [self.buttonSelect2 setTitle:cell.textLabel.text forState:UIControlStateNormal];
        self.tableTown.hidden = YES;
        if (db != nil) {
            sqlite3_stmt *statement;
            NSMutableArray *arrayMsg = [[NSMutableArray alloc]init];
            NSMutableArray *arrayDialog = [[NSMutableArray alloc]init];
            
            NSString *sqlNsstring = [NSString stringWithFormat:@"SELECT * FROM page3 WHERE town ='%@'",cell.textLabel.text];
            const char *sql = [sqlNsstring cStringUsingEncoding:NSUTF8StringEncoding];
            sqlite3_prepare(db, sql, -1, &statement, NULL);
            
            arrayMsg = [[NSMutableArray alloc]init];
            arrayDialog = [[NSMutableArray alloc]init];
            arrayId=[[NSMutableArray alloc]init];
            arrayName = [[NSMutableArray alloc]init];
            arrayIntroduction = [[NSMutableArray alloc]init];
            arrayLat = [[NSMutableArray alloc]init];
            arrayLon= [[NSMutableArray alloc]init];
            arrayPhone = [[NSMutableArray alloc]init];
            arrayAddress = [[NSMutableArray alloc]init];
            while (sqlite3_step(statement) == SQLITE_ROW) {
                char *id = (char *)sqlite3_column_text(statement, 0);
                char *name = (char *)sqlite3_column_text(statement, 1);
                char *introduction= (char *)sqlite3_column_text(statement, 2);
                char *lat= (char *)sqlite3_column_text(statement, 3);
                char *lon= (char *)sqlite3_column_text(statement, 4);
                char *address= (char *)sqlite3_column_text(statement, 8);
                char *phone= (char *)sqlite3_column_text(statement, 9);
                
                [arrayId addObject:[NSString stringWithCString:id encoding:NSUTF8StringEncoding]];
                [arrayName addObject:[NSString stringWithCString:name encoding:NSUTF8StringEncoding]];
                [arrayLat addObject:[NSString stringWithCString:lat encoding:NSUTF8StringEncoding]];
                [arrayLon addObject:[NSString stringWithCString:lon encoding:NSUTF8StringEncoding]];
                [arrayIntroduction addObject:[NSString stringWithCString:introduction encoding:NSUTF8StringEncoding]];
                [arrayPhone addObject:[NSString stringWithCString:phone encoding:NSUTF8StringEncoding]];
                [arrayAddress addObject:[NSString stringWithCString:address encoding:NSUTF8StringEncoding]];
            }
            
            app.arrayName3=arrayName;
            app.arrayDialog3=arrayIntroduction;
            
            sqlite3_finalize(statement);
        }
        
        
        [self.tableMsg reloadData];
        
    }
    
    /////////////////////  點選tableMsg跳到page3-1  //////////////
    if (tableView == self.tableMsg) {
        UITableViewCell *cell = [self.tableMsg cellForRowAtIndexPath:indexPath];
        AppDelegate *app =  [[UIApplication sharedApplication] delegate];
        app.selectName = cell.textLabel.text;
        app.selectDialog=cell.detailTextLabel.text;
        app.pageName=@"page3";//來源
        app.selectImg=[app.arrayImg3 objectAtIndex:indexPath.row];
        app.selectId=[app.arrayId3 objectAtIndex:indexPath.row];
        
        if (db != nil) {
            sqlite3_stmt *statement;
            NSMutableArray *arrayLat = [[NSMutableArray alloc]init];
            NSMutableArray *arrayLon = [[NSMutableArray alloc]init];
            NSMutableArray *arrayAddress = [[NSMutableArray alloc]init];
            NSMutableArray *arrayPhone = [[NSMutableArray alloc]init];
            NSMutableArray *arrayId = [[NSMutableArray alloc]init];
            NSMutableArray *arrayName = [[NSMutableArray alloc]init];
            NSMutableArray *arrayIntroduction = [[NSMutableArray alloc]init];
            NSString *sqlNsstring = [NSString stringWithFormat:@"SELECT * FROM page3 WHERE name ='%@'",app.selectName];
            const char *sql = [sqlNsstring cStringUsingEncoding:NSUTF8StringEncoding];
            sqlite3_prepare(db, sql, -1, &statement, NULL);
            
            arrayId=[[NSMutableArray alloc]init];
            arrayName = [[NSMutableArray alloc]init];
            arrayIntroduction = [[NSMutableArray alloc]init];
            arrayLat = [[NSMutableArray alloc]init];
            arrayLon= [[NSMutableArray alloc]init];
            arrayPhone = [[NSMutableArray alloc]init];
            arrayAddress = [[NSMutableArray alloc]init];
            
            while (sqlite3_step(statement) == SQLITE_ROW) {
                char *id = (char *)sqlite3_column_text(statement, 0);
                char *name = (char *)sqlite3_column_text(statement, 1);
                char *introduction= (char *)sqlite3_column_text(statement, 2);
                char *lat= (char *)sqlite3_column_text(statement, 3);
                char *lon= (char *)sqlite3_column_text(statement, 4);
                char *address= (char *)sqlite3_column_text(statement, 8);
                char *phone= (char *)sqlite3_column_text(statement, 9);
                
                [arrayId addObject:[NSString stringWithCString:id encoding:NSUTF8StringEncoding]];
                [arrayName addObject:[NSString stringWithCString:name encoding:NSUTF8StringEncoding]];
                [arrayLat addObject:[NSString stringWithCString:lat encoding:NSUTF8StringEncoding]];
                [arrayLon addObject:[NSString stringWithCString:lon encoding:NSUTF8StringEncoding]];
                [arrayIntroduction addObject:[NSString stringWithCString:introduction encoding:NSUTF8StringEncoding]];
                [arrayPhone addObject:[NSString stringWithCString:phone encoding:NSUTF8StringEncoding]];
                [arrayAddress addObject:[NSString stringWithCString:address encoding:NSUTF8StringEncoding]];
            }
            app.selectId=[arrayId objectAtIndex:0];
            app.selectDialog=[arrayIntroduction objectAtIndex:0];
            app.selectLat=[arrayLat objectAtIndex:0];
            app.selectLon=[arrayLon objectAtIndex:0];
            app.selectPhone=[arrayPhone objectAtIndex:0];
            app.selectAddress=[arrayAddress objectAtIndex:0];
            
            sqlite3_finalize(statement);
        }
        pageNext = [self.storyboard instantiateViewControllerWithIdentifier:@"page1_0"];
        [self.navigationController pushViewController:pageNext animated:YES];
    }
}

- (IBAction)buttonSelect0Click:(id)sender {
    self.tableCity.hidden = YES;
    self.tableTown.hidden = YES;
    if (self.tableArea.hidden == YES){
        self.tableArea.hidden = NO;
    }
    else{
        self.tableArea.hidden = YES;
    }
}
- (IBAction)buttonSelect1Click:(id)sender {
    
    self.tableArea.hidden = YES;
    self.tableTown.hidden = YES;
    if (self.tableCity.hidden == YES) {
        self.tableCity.hidden = NO;
    }else{
        self.tableCity.hidden = YES;
    }
}

- (IBAction)buttonSelect2Click:(id)sender {
    
    self.tableArea.hidden = YES;
    self.tableCity.hidden = YES;
    if (self.tableTown.hidden == YES) {
        self.tableTown.hidden = NO;
    }
    else{
        self.tableTown.hidden = YES;
    }
}
- (void)didSelectedIndex: (NSNotification *)noti {
    NSDictionary *userInfo = noti.userInfo;
    
}
- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

//Cell數量
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    AppDelegate *app =  [[UIApplication sharedApplication] delegate];
    if (tableView == self.tableArea) {
        return [app.arrayArea count];
    }else if (tableView == self.tableCity) {
        return [app.arrayCity count];
    }else if(tableView == self.tableTown)  {
        return [app.arrayTown count];
    }else if(tableView ==self.tableMsg){
        if (searchResult != nil)
            return [searchResult count];
        return [app.arrayName3 count];
    }else{
        return 0;
    }
}


@end
