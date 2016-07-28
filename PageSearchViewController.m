#import "ZJScrollPageView.h"
#import "SWRevealViewController.h"
#import "PageSearchViewController.h"
#import <QuartzCore/QuartzCore.h>
#import "AppDelegate.h"//1

@interface PageSearchViewController (){
}
@property (strong, nonatomic) UIViewController *page2;
@property(nonatomic,retain) AVSpeechSynthesizer *synthesizer;
@property(nonatomic,retain) NSString *voice;
@property(nonatomic,assign) float speed;
@end

@implementation PageSearchViewController
@synthesize synthesizer = _synthesizer;

@synthesize pageNext;
- (IBAction)barBackClick:(id)sender {
    AppDelegate *app =  [[UIApplication sharedApplication] delegate];
    pageNext = [self.storyboard instantiateViewControllerWithIdentifier:app.pageName];
    [self.navigationController pushViewController:pageNext animated:YES];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    
    
    
    
    
    _voice = @"zh-CN";
    _speed = .40f;
    [self speakText:@"你好 我甲崩喇 今天想去哪呢"];
    
    
    
    
    
    
    self.title=@"搜尋";
    UIAccessibilityPostNotification(UIAccessibilityAnnouncementNotification, @"Your text");
    [self.tabBarController.tabBar setHidden:true];//回到此頁不隱藏
    AppDelegate *app =  [[UIApplication sharedApplication] delegate];
    
    
    mySearchController = [[UISearchController alloc] initWithSearchResultsController:nil];
    // 設定那個 Controller 要負責回應searchBar的更新
    //    .searchBar.placeholder
    mySearchController.searchBar.placeholder = @"我想去....";
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
    
    mySearchController.searchBar.text=@"";
}//ViewDidLoad


//搜尋後更新的方法
-(void)updateSearchResultsForSearchController:(UISearchController *)searchController
{
    int numOfSearch;
    AppDelegate *app =  [[UIApplication sharedApplication] delegate];
    AppDelegate *delegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    const char *sql;
    NSString *searchString;
    NSString *sqlNsstring;
    sqlite3 *db = [delegate getDB];
    sqlite3_stmt *statement;
    NSMutableArray *arrayId = [[NSMutableArray alloc]init];
    NSMutableArray *arrayName = [[NSMutableArray alloc]init];
    NSMutableArray *arrayIntroduction = [[NSMutableArray alloc]init];
    NSMutableArray *arrayImg = [[NSMutableArray alloc]init];
    NSMutableArray *arrayCity = [[NSMutableArray alloc]init];
    NSMutableArray *arrayTown = [[NSMutableArray alloc]init];
    NSMutableArray *arrayArea = [[NSMutableArray alloc]init];
    
    
    
    if (searchController.isActive) {
        searchString = searchController.searchBar.text;
        
        if ([searchString length] > 0) {
            //從這開始
            
            if ([searchString  rangeOfString:@"結帳" options:NSCaseInsensitiveSearch].location != NSNotFound) {
                
                
                                pageNext = [self.storyboard instantiateViewControllerWithIdentifier:@"buy"];
                [self.navigationController pushViewController:pageNext animated:YES];
                
                NSString *speakTown = [NSString stringWithFormat:@"已魏你開啟結帳頁面"];
                [self speakText:speakTown];
                
                
                
            }else if ([searchString  rangeOfString:@"收藏" options:NSCaseInsensitiveSearch].location != NSNotFound) {
                
                
                pageNext = [self.storyboard instantiateViewControllerWithIdentifier:@"draw1"];
                [self.navigationController pushViewController:pageNext animated:YES];
                
                NSString *speakTown = [NSString stringWithFormat:@"已魏你開啟收藏頁面"];
                [self speakText:speakTown];
                
                
                
            }else if (db != nil) {
                
                
                //search------------------
                
                
                
                
                
                
                
                numOfSearch=(int)[arrayId count];
                
                //智慧搜尋Town
                if (numOfSearch==0){
                    sqlNsstring = [NSString stringWithFormat:@"SELECT  DISTINCT town   FROM pageArea"];
                    
                    sql = [sqlNsstring cStringUsingEncoding:NSUTF8StringEncoding];
                    
                    sqlite3_prepare(db, sql, -1, &statement, NULL);
                    
                    while (sqlite3_step(statement) == SQLITE_ROW) {
                        char *town= (char *)sqlite3_column_text(statement, 0);
                        [arrayTown addObject:[NSString stringWithCString:town encoding:NSUTF8StringEncoding]];
                        NSString *nsstringTown = [NSString stringWithFormat:@"%@", [arrayTown lastObject]];
                        
                        
                        NSString *nsstringTown2 = [nsstringTown substringToIndex:2];
                        
                        if ([searchString  rangeOfString:nsstringTown2 options:NSCaseInsensitiveSearch].location != NSNotFound) {
                            
                            
                            
                            NSString *speakTown = [NSString stringWithFormat:@"寶寶也想去%@但寶寶不說,已魏你搜尋%@",nsstringTown2,nsstringTown];
                            [self speakText:speakTown];
                            
                            
                            
                            
                            
                            arrayCity = [[NSMutableArray alloc]init];
                            arrayTown = [[NSMutableArray alloc]init];
                            
                            NSLog(@"%@包含此town%@,select %@",searchString,nsstringTown2,nsstringTown);
                            
                            
                            sqlNsstring = [NSString stringWithFormat:@"SELECT * FROM page1 WHERE town='%@'",nsstringTown];
                            NSLog(@"%@",sqlNsstring);
                            sql = [sqlNsstring cStringUsingEncoding:NSUTF8StringEncoding];
                            
                            sqlite3_prepare(db, sql, -1, &statement, NULL);
                            
                            while (sqlite3_step(statement) == SQLITE_ROW) {
                                char *id = (char *)sqlite3_column_text(statement, 0);
                                char *name = (char *)sqlite3_column_text(statement, 1);
                                char *introduction= (char *)sqlite3_column_text(statement, 2);
                                char *img= (char *)sqlite3_column_text(statement, 10);
                                
                                char *city= (char *)sqlite3_column_text(statement, 6);
                                char *town= (char *)sqlite3_column_text(statement, 7);
                                [arrayCity addObject:[NSString stringWithCString:city encoding:NSUTF8StringEncoding]];
                                [arrayTown addObject:[NSString stringWithCString:town encoding:NSUTF8StringEncoding]];
                                
                                [arrayId addObject:[NSString stringWithCString:id encoding:NSUTF8StringEncoding]];
                                [arrayName addObject:[NSString stringWithCString:name encoding:NSUTF8StringEncoding]];
                                [arrayIntroduction addObject:[NSString stringWithCString:introduction encoding:NSUTF8StringEncoding]];
                                [arrayImg addObject:[NSString stringWithCString:img encoding:NSUTF8StringEncoding]];
                            }
                            sqlNsstring = [NSString stringWithFormat:@"SELECT * FROM page2 WHERE town='%@'",nsstringTown];
                            NSLog(@"%@",sqlNsstring);
                            sql = [sqlNsstring cStringUsingEncoding:NSUTF8StringEncoding];
                            
                            sqlite3_prepare(db, sql, -1, &statement, NULL);
                            
                            while (sqlite3_step(statement) == SQLITE_ROW) {
                                char *id = (char *)sqlite3_column_text(statement, 0);
                                char *name = (char *)sqlite3_column_text(statement, 1);
                                char *introduction= (char *)sqlite3_column_text(statement, 2);
                                char *img= (char *)sqlite3_column_text(statement, 10);
                                
                                char *city= (char *)sqlite3_column_text(statement, 6);
                                char *town= (char *)sqlite3_column_text(statement, 7);
                                [arrayCity addObject:[NSString stringWithCString:city encoding:NSUTF8StringEncoding]];
                                [arrayTown addObject:[NSString stringWithCString:town encoding:NSUTF8StringEncoding]];
                                
                                [arrayId addObject:[NSString stringWithCString:id encoding:NSUTF8StringEncoding]];
                                [arrayName addObject:[NSString stringWithCString:name encoding:NSUTF8StringEncoding]];
                                [arrayIntroduction addObject:[NSString stringWithCString:introduction encoding:NSUTF8StringEncoding]];
                                [arrayImg addObject:[NSString stringWithCString:img encoding:NSUTF8StringEncoding]];
                            }
                            sqlNsstring = [NSString stringWithFormat:@"SELECT * FROM page3 WHERE town='%@'",nsstringTown];
                            NSLog(@"%@",sqlNsstring);
                            sql = [sqlNsstring cStringUsingEncoding:NSUTF8StringEncoding];
                            
                            sqlite3_prepare(db, sql, -1, &statement, NULL);
                            
                            while (sqlite3_step(statement) == SQLITE_ROW) {
                                char *id = (char *)sqlite3_column_text(statement, 0);
                                char *name = (char *)sqlite3_column_text(statement, 1);
                                char *introduction= (char *)sqlite3_column_text(statement, 2);
                                char *img= (char *)sqlite3_column_text(statement, 10);
                                
                                char *city= (char *)sqlite3_column_text(statement, 6);
                                char *town= (char *)sqlite3_column_text(statement, 7);
                                [arrayCity addObject:[NSString stringWithCString:city encoding:NSUTF8StringEncoding]];
                                [arrayTown addObject:[NSString stringWithCString:town encoding:NSUTF8StringEncoding]];
                                
                                [arrayId addObject:[NSString stringWithCString:id encoding:NSUTF8StringEncoding]];
                                [arrayName addObject:[NSString stringWithCString:name encoding:NSUTF8StringEncoding]];
                                [arrayIntroduction addObject:[NSString stringWithCString:introduction encoding:NSUTF8StringEncoding]];
                                [arrayImg addObject:[NSString stringWithCString:img encoding:NSUTF8StringEncoding]];
                            }
                            sqlNsstring = [NSString stringWithFormat:@"SELECT * FROM page4 WHERE town='%@'",nsstringTown];
                            NSLog(@"%@",sqlNsstring);
                            sql = [sqlNsstring cStringUsingEncoding:NSUTF8StringEncoding];
                            
                            sqlite3_prepare(db, sql, -1, &statement, NULL);
                            
                            while (sqlite3_step(statement) == SQLITE_ROW) {
                                char *id = (char *)sqlite3_column_text(statement, 0);
                                char *name = (char *)sqlite3_column_text(statement, 1);
                                char *introduction= (char *)sqlite3_column_text(statement, 2);
                                char *img= (char *)sqlite3_column_text(statement, 10);
                                
                                char *city= (char *)sqlite3_column_text(statement, 6);
                                char *town= (char *)sqlite3_column_text(statement, 7);
                                [arrayCity addObject:[NSString stringWithCString:city encoding:NSUTF8StringEncoding]];
                                [arrayTown addObject:[NSString stringWithCString:town encoding:NSUTF8StringEncoding]];
                                [arrayId addObject:[NSString stringWithCString:id encoding:NSUTF8StringEncoding]];
                                [arrayName addObject:[NSString stringWithCString:name encoding:NSUTF8StringEncoding]];
                                [arrayIntroduction addObject:[NSString stringWithCString:introduction encoding:NSUTF8StringEncoding]];
                                [arrayImg addObject:[NSString stringWithCString:img encoding:NSUTF8StringEncoding]];
                            }
                            
                            
                        }
                        
                    }
                    
                }//智能搜尋:TOWN
                
                
                
                numOfSearch=(int)[arrayId count];
                
                //智慧搜尋city
                if (numOfSearch==0){
                    sqlNsstring = [NSString stringWithFormat:@"SELECT  DISTINCT city   FROM pageArea"];
                    
                    sql = [sqlNsstring cStringUsingEncoding:NSUTF8StringEncoding];
                    
                    sqlite3_prepare(db, sql, -1, &statement, NULL);
                    
                    while (sqlite3_step(statement) == SQLITE_ROW) {
                        char *city= (char *)sqlite3_column_text(statement, 0);
                        [arrayCity addObject:[NSString stringWithCString:city encoding:NSUTF8StringEncoding]];
                        NSString *nsstringCity = [NSString stringWithFormat:@"%@", [arrayCity lastObject]];
                        
                        
                        NSString *nsstringCity2 = [nsstringCity substringToIndex:2];
                        
                        if ([searchString  rangeOfString:nsstringCity2 options:NSCaseInsensitiveSearch].location != NSNotFound) {
                            
                            
                            
                            
                            NSString *speakCity = [NSString stringWithFormat:@"今天就是要去%@啊  不然要幹麻 ",nsstringCity2];
                            
                            [self speakText:speakCity];
                            
                            
                            
                            
                            
                            
                            arrayCity = [[NSMutableArray alloc]init];
                            
                            
                            NSLog(@"%@包含此city%@,select %@",searchString,nsstringCity2,nsstringCity);
                            
                            
                            sqlNsstring = [NSString stringWithFormat:@"SELECT * FROM page1 WHERE city='%@'",nsstringCity];
                            NSLog(@"%@",sqlNsstring);
                            sql = [sqlNsstring cStringUsingEncoding:NSUTF8StringEncoding];
                            
                            sqlite3_prepare(db, sql, -1, &statement, NULL);
                            
                            arrayCity = [[NSMutableArray alloc]init];
                            arrayTown = [[NSMutableArray alloc]init];
                            while (sqlite3_step(statement) == SQLITE_ROW) {
                                char *id = (char *)sqlite3_column_text(statement, 0);
                                char *name = (char *)sqlite3_column_text(statement, 1);
                                char *introduction= (char *)sqlite3_column_text(statement, 2);
                                char *img= (char *)sqlite3_column_text(statement, 10);
                                
                                char *city= (char *)sqlite3_column_text(statement, 6);
                                char *town= (char *)sqlite3_column_text(statement, 7);
                                [arrayCity addObject:[NSString stringWithCString:city encoding:NSUTF8StringEncoding]];
                                [arrayTown addObject:[NSString stringWithCString:town encoding:NSUTF8StringEncoding]];
                                
                                [arrayId addObject:[NSString stringWithCString:id encoding:NSUTF8StringEncoding]];
                                [arrayName addObject:[NSString stringWithCString:name encoding:NSUTF8StringEncoding]];
                                [arrayIntroduction addObject:[NSString stringWithCString:introduction encoding:NSUTF8StringEncoding]];
                                [arrayImg addObject:[NSString stringWithCString:img encoding:NSUTF8StringEncoding]];
                            }
                            sqlNsstring = [NSString stringWithFormat:@"SELECT * FROM page2 WHERE city='%@'",nsstringCity];
                            NSLog(@"%@",sqlNsstring);
                            sql = [sqlNsstring cStringUsingEncoding:NSUTF8StringEncoding];
                            
                            sqlite3_prepare(db, sql, -1, &statement, NULL);
                            
                            while (sqlite3_step(statement) == SQLITE_ROW) {
                                char *id = (char *)sqlite3_column_text(statement, 0);
                                char *name = (char *)sqlite3_column_text(statement, 1);
                                char *introduction= (char *)sqlite3_column_text(statement, 2);
                                char *img= (char *)sqlite3_column_text(statement, 10);
                                
                                char *city= (char *)sqlite3_column_text(statement, 6);
                                char *town= (char *)sqlite3_column_text(statement, 7);
                                [arrayCity addObject:[NSString stringWithCString:city encoding:NSUTF8StringEncoding]];
                                [arrayTown addObject:[NSString stringWithCString:town encoding:NSUTF8StringEncoding]];
                                
                                [arrayId addObject:[NSString stringWithCString:id encoding:NSUTF8StringEncoding]];
                                [arrayName addObject:[NSString stringWithCString:name encoding:NSUTF8StringEncoding]];
                                [arrayIntroduction addObject:[NSString stringWithCString:introduction encoding:NSUTF8StringEncoding]];
                                [arrayImg addObject:[NSString stringWithCString:img encoding:NSUTF8StringEncoding]];
                            }
                            sqlNsstring = [NSString stringWithFormat:@"SELECT * FROM page3 WHERE city='%@'",nsstringCity];
                            NSLog(@"%@",sqlNsstring);
                            sql = [sqlNsstring cStringUsingEncoding:NSUTF8StringEncoding];
                            
                            sqlite3_prepare(db, sql, -1, &statement, NULL);
                            
                            while (sqlite3_step(statement) == SQLITE_ROW) {
                                char *id = (char *)sqlite3_column_text(statement, 0);
                                char *name = (char *)sqlite3_column_text(statement, 1);
                                char *introduction= (char *)sqlite3_column_text(statement, 2);
                                char *img= (char *)sqlite3_column_text(statement, 10);
                                
                                char *city= (char *)sqlite3_column_text(statement, 6);
                                char *town= (char *)sqlite3_column_text(statement, 7);
                                [arrayCity addObject:[NSString stringWithCString:city encoding:NSUTF8StringEncoding]];
                                [arrayTown addObject:[NSString stringWithCString:town encoding:NSUTF8StringEncoding]];
                                
                                [arrayId addObject:[NSString stringWithCString:id encoding:NSUTF8StringEncoding]];
                                [arrayName addObject:[NSString stringWithCString:name encoding:NSUTF8StringEncoding]];
                                [arrayIntroduction addObject:[NSString stringWithCString:introduction encoding:NSUTF8StringEncoding]];
                                [arrayImg addObject:[NSString stringWithCString:img encoding:NSUTF8StringEncoding]];
                            }
                            sqlNsstring = [NSString stringWithFormat:@"SELECT * FROM page4 WHERE city='%@'",nsstringCity];
                            NSLog(@"%@",sqlNsstring);
                            sql = [sqlNsstring cStringUsingEncoding:NSUTF8StringEncoding];
                            
                            sqlite3_prepare(db, sql, -1, &statement, NULL);
                            
                            while (sqlite3_step(statement) == SQLITE_ROW) {
                                char *id = (char *)sqlite3_column_text(statement, 0);
                                char *name = (char *)sqlite3_column_text(statement, 1);
                                char *introduction= (char *)sqlite3_column_text(statement, 2);
                                char *img= (char *)sqlite3_column_text(statement, 10);
                                
                                char *city= (char *)sqlite3_column_text(statement, 6);
                                char *town= (char *)sqlite3_column_text(statement, 7);
                                [arrayCity addObject:[NSString stringWithCString:city encoding:NSUTF8StringEncoding]];
                                [arrayTown addObject:[NSString stringWithCString:town encoding:NSUTF8StringEncoding]];
                                [arrayId addObject:[NSString stringWithCString:id encoding:NSUTF8StringEncoding]];
                                [arrayName addObject:[NSString stringWithCString:name encoding:NSUTF8StringEncoding]];
                                [arrayIntroduction addObject:[NSString stringWithCString:introduction encoding:NSUTF8StringEncoding]];
                                [arrayImg addObject:[NSString stringWithCString:img encoding:NSUTF8StringEncoding]];
                            }
                            
                            
                        }
                        
                    }
                    
                }//智能搜尋:city
                
                
                numOfSearch=(int)[arrayId count];
                
                //智慧搜尋area
                if (numOfSearch==0){
                    sqlNsstring = [NSString stringWithFormat:@"SELECT  DISTINCT area   FROM pageArea"];
                    
                    sql = [sqlNsstring cStringUsingEncoding:NSUTF8StringEncoding];
                    
                    sqlite3_prepare(db, sql, -1, &statement, NULL);
                    
                    while (sqlite3_step(statement) == SQLITE_ROW) {
                        char *area= (char *)sqlite3_column_text(statement, 0);
                        [arrayArea addObject:[NSString stringWithCString:area encoding:NSUTF8StringEncoding]];
                        NSString *nsstringArea = [NSString stringWithFormat:@"%@", [arrayArea lastObject]];
                        
                        
                        NSString *nsstringArea2 = [nsstringArea substringToIndex:2];
                        
                        if ([searchString  rangeOfString:nsstringArea2 options:NSCaseInsensitiveSearch].location != NSNotFound) {
                            

                            
                            
                            NSString *speakArea = [NSString stringWithFormat:@"已魏你搜尋%@ 順便帶我到%@弄假牙",nsstringArea2,nsstringArea2];
                            
                            [self speakText:speakArea];
                            
                            
                            
                            
                            
                            
                            
                            
                            
                            NSLog(@"%@包含此area%@,select %@",searchString,nsstringArea2,nsstringArea);
                            
                            
                            sqlNsstring = [NSString stringWithFormat:@"SELECT * FROM page1 WHERE area='%@'",nsstringArea];
                            NSLog(@"%@",sqlNsstring);
                            sql = [sqlNsstring cStringUsingEncoding:NSUTF8StringEncoding];
                            
                            sqlite3_prepare(db, sql, -1, &statement, NULL);
                            
                            arrayCity = [[NSMutableArray alloc]init];
                            arrayTown = [[NSMutableArray alloc]init];
                            while (sqlite3_step(statement) == SQLITE_ROW) {
                                char *id = (char *)sqlite3_column_text(statement, 0);
                                char *name = (char *)sqlite3_column_text(statement, 1);
                                char *introduction= (char *)sqlite3_column_text(statement, 2);
                                char *img= (char *)sqlite3_column_text(statement, 10);
                                
                                char *city= (char *)sqlite3_column_text(statement, 6);
                                char *town= (char *)sqlite3_column_text(statement, 7);
                                [arrayCity addObject:[NSString stringWithCString:city encoding:NSUTF8StringEncoding]];
                                [arrayTown addObject:[NSString stringWithCString:town encoding:NSUTF8StringEncoding]];
                                
                                [arrayId addObject:[NSString stringWithCString:id encoding:NSUTF8StringEncoding]];
                                [arrayName addObject:[NSString stringWithCString:name encoding:NSUTF8StringEncoding]];
                                [arrayIntroduction addObject:[NSString stringWithCString:introduction encoding:NSUTF8StringEncoding]];
                                [arrayImg addObject:[NSString stringWithCString:img encoding:NSUTF8StringEncoding]];
                            }
                            sqlNsstring = [NSString stringWithFormat:@"SELECT * FROM page2 WHERE area='%@'",nsstringArea];
                            NSLog(@"%@",sqlNsstring);
                            sql = [sqlNsstring cStringUsingEncoding:NSUTF8StringEncoding];
                            
                            sqlite3_prepare(db, sql, -1, &statement, NULL);
                            
                            while (sqlite3_step(statement) == SQLITE_ROW) {
                                char *id = (char *)sqlite3_column_text(statement, 0);
                                char *name = (char *)sqlite3_column_text(statement, 1);
                                char *introduction= (char *)sqlite3_column_text(statement, 2);
                                char *img= (char *)sqlite3_column_text(statement, 10);
                                
                                char *city= (char *)sqlite3_column_text(statement, 6);
                                char *town= (char *)sqlite3_column_text(statement, 7);
                                [arrayCity addObject:[NSString stringWithCString:city encoding:NSUTF8StringEncoding]];
                                [arrayTown addObject:[NSString stringWithCString:town encoding:NSUTF8StringEncoding]];
                                
                                [arrayId addObject:[NSString stringWithCString:id encoding:NSUTF8StringEncoding]];
                                [arrayName addObject:[NSString stringWithCString:name encoding:NSUTF8StringEncoding]];
                                [arrayIntroduction addObject:[NSString stringWithCString:introduction encoding:NSUTF8StringEncoding]];
                                [arrayImg addObject:[NSString stringWithCString:img encoding:NSUTF8StringEncoding]];
                            }
                            sqlNsstring = [NSString stringWithFormat:@"SELECT * FROM page3 WHERE area='%@'",nsstringArea];
                            NSLog(@"%@",sqlNsstring);
                            sql = [sqlNsstring cStringUsingEncoding:NSUTF8StringEncoding];
                            
                            sqlite3_prepare(db, sql, -1, &statement, NULL);
                            
                            while (sqlite3_step(statement) == SQLITE_ROW) {
                                char *id = (char *)sqlite3_column_text(statement, 0);
                                char *name = (char *)sqlite3_column_text(statement, 1);
                                char *introduction= (char *)sqlite3_column_text(statement, 2);
                                char *img= (char *)sqlite3_column_text(statement, 10);
                                
                                char *city= (char *)sqlite3_column_text(statement, 6);
                                char *town= (char *)sqlite3_column_text(statement, 7);
                                [arrayCity addObject:[NSString stringWithCString:city encoding:NSUTF8StringEncoding]];
                                [arrayTown addObject:[NSString stringWithCString:town encoding:NSUTF8StringEncoding]];
                                
                                [arrayId addObject:[NSString stringWithCString:id encoding:NSUTF8StringEncoding]];
                                [arrayName addObject:[NSString stringWithCString:name encoding:NSUTF8StringEncoding]];
                                [arrayIntroduction addObject:[NSString stringWithCString:introduction encoding:NSUTF8StringEncoding]];
                                [arrayImg addObject:[NSString stringWithCString:img encoding:NSUTF8StringEncoding]];
                            }
                            sqlNsstring = [NSString stringWithFormat:@"SELECT * FROM page4 WHERE area='%@'",nsstringArea];
                            NSLog(@"%@",sqlNsstring);
                            sql = [sqlNsstring cStringUsingEncoding:NSUTF8StringEncoding];
                            
                            sqlite3_prepare(db, sql, -1, &statement, NULL);
                            
                            while (sqlite3_step(statement) == SQLITE_ROW) {
                                char *id = (char *)sqlite3_column_text(statement, 0);
                                char *name = (char *)sqlite3_column_text(statement, 1);
                                char *introduction= (char *)sqlite3_column_text(statement, 2);
                                char *img= (char *)sqlite3_column_text(statement, 10);
                                
                                char *city= (char *)sqlite3_column_text(statement, 6);
                                char *town= (char *)sqlite3_column_text(statement, 7);
                                [arrayCity addObject:[NSString stringWithCString:city encoding:NSUTF8StringEncoding]];
                                [arrayTown addObject:[NSString stringWithCString:town encoding:NSUTF8StringEncoding]];
                                [arrayId addObject:[NSString stringWithCString:id encoding:NSUTF8StringEncoding]];
                                [arrayName addObject:[NSString stringWithCString:name encoding:NSUTF8StringEncoding]];
                                [arrayIntroduction addObject:[NSString stringWithCString:introduction encoding:NSUTF8StringEncoding]];
                                [arrayImg addObject:[NSString stringWithCString:img encoding:NSUTF8StringEncoding]];
                            }
                            
                            
                            
                            
                        }
                        
                    }
                    
                }//智能搜尋:area
                
                
                numOfSearch=(int)[arrayId count];
                
                
                
                
                
                
                
                
                
                
                
                
                
                numOfSearch=(int)[arrayId count];
                //搜尋所有欄位
                if (numOfSearch==0){

                    
                    NSString*searchString3=searchString;
                    NSString*searchString3_2=searchString;
                    NSString*searchString4=searchString;
                    NSString*searchString4_2=searchString;
                    NSLog(@"截取的值为：%@",searchString3_2);
                    int num=(int)[searchString length];
                    if (num>4){
                        searchString3 =[searchString substringFromIndex:3];//截取掉下标4之前的字符串
                        searchString3_2= [searchString3 substringToIndex:2];//取4~5的值
                        
                        
                        NSLog(@"共%d個字取4~5截取的值为：%@",num,searchString3_2);
                        
                    }
                    if (num>5){
                        searchString4 =[searchString substringFromIndex:4];//截取掉下标5之前的字符串
                        searchString4_2= [searchString4 substringToIndex:2];//取5~6截取的值
                        NSLog(@"共%d個字取5~6截取的值为：%@",num,searchString4_2);
                    }
                    
                    
                    
                    
                    

                    
                    
                    
                    
                    //所有欄位查詢
                    sqlNsstring = [NSString stringWithFormat:@"SELECT * FROM page1 WHERE name like '%%%@%%' or name like '%%%@%%' or introduction like '%%%@%%' or introduction like '%%%@%%'",searchString3_2,searchString3_2,searchString4_2,searchString4_2];
                    
                    
                    sql = [sqlNsstring cStringUsingEncoding:NSUTF8StringEncoding];
                    sqlite3_prepare(db, sql, -1, &statement, NULL);
                    arrayCity = [[NSMutableArray alloc]init];
                    arrayTown = [[NSMutableArray alloc]init];
                    
                    
                    while (sqlite3_step(statement) == SQLITE_ROW) {
                        char *id = (char *)sqlite3_column_text(statement, 0);
                        char *name = (char *)sqlite3_column_text(statement, 1);
                        char *introduction= (char *)sqlite3_column_text(statement, 2);
                        char *img= (char *)sqlite3_column_text(statement, 10);
                        
                        char *city= (char *)sqlite3_column_text(statement, 6);
                        char *town= (char *)sqlite3_column_text(statement, 7);
                        [arrayCity addObject:[NSString stringWithCString:city encoding:NSUTF8StringEncoding]];
                        [arrayTown addObject:[NSString stringWithCString:town encoding:NSUTF8StringEncoding]];
                        
                        [arrayId addObject:[NSString stringWithCString:id encoding:NSUTF8StringEncoding]];
                        [arrayName addObject:[NSString stringWithCString:name encoding:NSUTF8StringEncoding]];
                        [arrayIntroduction addObject:[NSString stringWithCString:introduction encoding:NSUTF8StringEncoding]];
                        [arrayImg addObject:[NSString stringWithCString:img encoding:NSUTF8StringEncoding]];
                    }
                    numOfSearch=(int)[arrayId count];
                    if(numOfSearch>0 && [searchString length] > 2){
                    NSString *speakAll = [NSString stringWithFormat:@"就決定是你了%@ ",searchString3];
                    
                    [self speakText:speakAll];
                    }
                    
                    

                    
                }
                
                

                
                
                
                
                
                
                app.arrayIdSearch=arrayId;
                app.arrayNameSearch=arrayName;
                app.arrayDialogSearch=arrayIntroduction;
                app.arrayImgSearch=arrayImg;
                app.arrayCitySearch=arrayCity;
                app.arrayTownSearch=arrayTown;
                searchString=@"";
                numOfSearch=(int)[arrayId count];
                
                if (numOfSearch==0 && [searchString length] > 5){
                    NSString *speakOther = [NSString stringWithFormat:@"寶寶找不到,嚇死寶寶了"];
                    [self speakText:speakOther];
                }
                
                
                
            } else {
                searchResult = nil;
                
            }
        } else {
            searchResult = nil;
            
        }
        
        [self.tableMsg reloadData];
    }
    
}

//Cell內容
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    AppDelegate *app =  [[UIApplication sharedApplication] delegate];
    static NSString *simpleTableIdentifier = @"SimpleTableItem";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:NSLocaleIdentifier];
    }
    
    if(tableView == self.tableMsg) {//內容頁
        
        if (cell == nil) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"Cell"];
        }
        
        cell.textLabel.text = [app.arrayNameSearch objectAtIndex:indexPath.row];
        
        cell.imageView.image= [UIImage imageNamed:[app.arrayImgSearch objectAtIndex:(indexPath.row)]];
        
        cell.detailTextLabel.text=[NSString stringWithFormat:@"%@-%@-%@",[app.arrayCitySearch objectAtIndex:indexPath.row] ,[app.arrayTownSearch objectAtIndex:indexPath.row],[app.arrayDialogSearch objectAtIndex:indexPath.row]];
        
    }
    
    
    return cell;
}


//按了cell的動作
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    AppDelegate *delegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    sqlite3 *db = [delegate getDB];
    
    
    
    /////////////////////  點選tableMsg跳轉頁面 //////////////
    if (tableView == self.tableMsg) {
        UITableViewCell *cell = [self.tableMsg cellForRowAtIndexPath:indexPath];
        AppDelegate *app =  [[UIApplication sharedApplication] delegate];
        app.selectName = cell.textLabel.text;
        app.selectDialog=cell.detailTextLabel.text;
        app.pageName=@"page1";//來源
        app.selectImg=[app.arrayImgSearch objectAtIndex:indexPath.row];
        app.selectId=[app.arrayIdSearch objectAtIndex:indexPath.row];
        
        if (db != nil) {
            sqlite3_stmt *statement;
            NSMutableArray *arrayLat = [[NSMutableArray alloc]init];
            NSMutableArray *arrayLon = [[NSMutableArray alloc]init];
            NSMutableArray *arrayAddress = [[NSMutableArray alloc]init];
            NSMutableArray *arrayPhone = [[NSMutableArray alloc]init];
            NSMutableArray *arrayId = [[NSMutableArray alloc]init];
            NSMutableArray *arrayName = [[NSMutableArray alloc]init];
            NSMutableArray *arrayIntroduction = [[NSMutableArray alloc]init];
            NSMutableArray *arrayPrice = [[NSMutableArray alloc]init];
            NSString *sqlNsstring = [NSString stringWithFormat:@"SELECT * FROM page1 WHERE name ='%@'",app.selectName];
            const char *sql = [sqlNsstring cStringUsingEncoding:NSUTF8StringEncoding];
            sqlite3_prepare(db, sql, -1, &statement, NULL);
            
            arrayId=[[NSMutableArray alloc]init];
            arrayName = [[NSMutableArray alloc]init];
            arrayIntroduction = [[NSMutableArray alloc]init];
            arrayLat = [[NSMutableArray alloc]init];
            arrayLon= [[NSMutableArray alloc]init];
            arrayPhone = [[NSMutableArray alloc]init];
            arrayAddress = [[NSMutableArray alloc]init];
            arrayPrice=[[NSMutableArray alloc]init];
            while (sqlite3_step(statement) == SQLITE_ROW) {
                char *id = (char *)sqlite3_column_text(statement, 0);
                char *name = (char *)sqlite3_column_text(statement, 1);
                char *introduction= (char *)sqlite3_column_text(statement, 2);
                char *lat= (char *)sqlite3_column_text(statement, 3);
                char *lon= (char *)sqlite3_column_text(statement, 4);
                char *address= (char *)sqlite3_column_text(statement, 8);
                char *phone= (char *)sqlite3_column_text(statement, 9);
                //                char *price= (char *)sqlite3_column_text(statement, 15);
                [arrayId addObject:[NSString stringWithCString:id encoding:NSUTF8StringEncoding]];
                [arrayName addObject:[NSString stringWithCString:name encoding:NSUTF8StringEncoding]];
                [arrayLat addObject:[NSString stringWithCString:lat encoding:NSUTF8StringEncoding]];
                [arrayLon addObject:[NSString stringWithCString:lon encoding:NSUTF8StringEncoding]];
                [arrayIntroduction addObject:[NSString stringWithCString:introduction encoding:NSUTF8StringEncoding]];
                [arrayPhone addObject:[NSString stringWithCString:phone encoding:NSUTF8StringEncoding]];
                [arrayAddress addObject:[NSString stringWithCString:address encoding:NSUTF8StringEncoding]];
                //                [arrayPrice addObject:[NSString stringWithCString:price encoding:NSUTF8StringEncoding]];
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




//Cell數量
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    AppDelegate *app =  [[UIApplication sharedApplication] delegate];
    if(tableView ==self.tableMsg){
        
        return [app.arrayNameSearch count];
    }else{
        return 0;
    }
    
}






- (void)speakText:(NSString*)text{
    
    if(_synthesizer == nil)
        _synthesizer = [[AVSpeechSynthesizer alloc] init];
    _synthesizer.delegate = self;
    
    AVSpeechUtterance *utterence = [[AVSpeechUtterance alloc] initWithString:text];
    utterence.rate = _speed;
    
    AVSpeechSynthesisVoice *voice = [AVSpeechSynthesisVoice voiceWithLanguage:_voice];
    [utterence setVoice:voice];
    
    [_synthesizer speakUtterance:utterence];
}

// Enable all buttons at once



- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text{
    if ([text isEqualToString:@"\n"]) {
        [textView resignFirstResponder];
        return YES;
    }
    return YES;
}

#pragma mark- AVSpeechSynthesizerDelegate


- (void)speechSynthesizer:(AVSpeechSynthesizer *)synthesizer willSpeakRangeOfSpeechString:(NSRange)characterRange utterance:(AVSpeechUtterance *)utterance{
    NSString *text = [utterance speechString];
    
    NSMutableAttributedString * all = [[NSMutableAttributedString alloc] initWithString:text];
    [all addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:characterRange];
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

- (void)audioInterrupted:(NSNotification *)notification
{
    NSUInteger type = [notification.userInfo[AVAudioSessionInterruptionTypeKey] intValue];
    NSUInteger option = [notification.userInfo[AVAudioSessionInterruptionOptionKey] intValue];
    
    if (type == AVAudioSessionInterruptionTypeBegan) {
        NSLog(@"音樂中斷");
    } else if (type == AVAudioSessionInterruptionTypeEnded) {
        if (option == AVAudioSessionInterruptionOptionShouldResume) {
            NSLog(@"中斷恢復");
            if ([audioPlayer prepareToPlay]) {
                // 這一行必須要加，否則在來電結束後，音樂不會繼續播放
                // 目前原因不明
                [NSThread sleepForTimeInterval:0.1];
                [audioPlayer play];
            }
        }
    }
}
@end

//                            [NSThread sleepForTimeInterval:3.0];
//
//
//                            // 找到 music.mp3 的路徑
//                            NSString *filePath = [[NSBundle mainBundle] pathForResource:@"pikachu" ofType:@"mp3"];
//                            NSData *fileData = [NSData dataWithContentsOfFile:filePath];
//
//                            // 設定 AVAudioSession，並且註冊 audioInterrupted: 方法
//                            // 讓音樂播放過程中有任何狀態改變就會收到通知
//                            [[AVAudioSession sharedInstance] setCategory:AVAudioSessionCategoryPlayback error:nil];
//                            NSNotificationCenter *center = [NSNotificationCenter defaultCenter];
//                            [center addObserver:self selector:@selector(audioInterrupted:) name:AVAudioSessionInterruptionNotification object:nil];
//
//                            // 初始化 audioPlayer
//                            audioPlayer = [[AVAudioPlayer alloc] initWithData:fileData error:nil];
//
//                            // 檢查是否一切就緒，如果沒有問題就播放音樂
//                            if (audioPlayer != nil) {
//                                if ([audioPlayer prepareToPlay]) {
//                                    [audioPlayer play];
//                                }
//                            }