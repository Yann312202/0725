#import "ZJVc2Controller.h"
#import "ZJScrollPageView.h"
#import "Page1ViewController.h"
#import "AppDelegate.h"//1
@interface ZJVc2Controller ()
{
    bool boolFav;
}

@property (strong, nonatomic) UIViewController *page2;
@property (strong, nonatomic) NSString *receiveData;
@end
@implementation ZJVc2Controller

@synthesize page2;

- (IBAction)barFavClick:(id)sender {
    
    AppDelegate *app =  [[UIApplication sharedApplication] delegate];
    if (boolFav==true){
        self.navigationController.navigationBar.barStyle = UIStatusBarStyleDefault;
        [self.navigationController.navigationBar setTintColor:[UIColor lightGrayColor]];
        boolFav=false;
        
        
        
        AppDelegate *delegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
        sqlite3 *db = [delegate getDB];
        if (db != nil) {
            sqlite3_stmt *statement;
            
            NSString *sqlNsstring = [NSString stringWithFormat:@"DELETE FROM pageFav WHERE name ='%@'",app.selectName];
            
            const char *sql = [sqlNsstring cStringUsingEncoding:NSUTF8StringEncoding];
            sqlite3_prepare(db, sql, -1, &statement, NULL);
            
            if (sqlite3_step(statement) == SQLITE_DONE) {
                NSLog(@"true->false成功刪除一筆資料");
            } else {
                NSLog(@"true->false刪除一筆資料失敗");
            }
        }
        
    }else{
        self.navigationController.navigationBar.barStyle = UIStatusBarStyleDefault;
        [self.navigationController.navigationBar setTintColor:[UIColor redColor]];
        boolFav=true;
        
        
        AppDelegate *delegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
        sqlite3 *db = [delegate getDB];
        if (db != nil) {
            sqlite3_stmt *statement;
            NSString *sqlNsstring = [NSString stringWithFormat:@"INSERT INTO pageFav (NAME) VALUES ('%@')",app.selectName];
            const char *sql = [sqlNsstring cStringUsingEncoding:NSUTF8StringEncoding];
            sqlite3_prepare(db, sql, -1, &statement, NULL);
            
            
            if (sqlite3_step(statement) == SQLITE_DONE) {
                NSLog(@"false->true成功插入一筆資料");
            } else {
                NSLog(@"false->true插入一筆資料失敗");
            }
        }
    }
    
}
- (IBAction)barBack:(id)sender {
    AppDelegate *app =  [[UIApplication sharedApplication] delegate];
    page2 = [self.storyboard instantiateViewControllerWithIdentifier:app.pageName];
    [self.navigationController pushViewController:page2 animated:YES];
}

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    [self.tabBarController.tabBar setHidden:YES];
    AppDelegate *app =  [[UIApplication sharedApplication] delegate];
    
    self.title = app.selectName;
    //必要的设置, 如果没有设置可能导致内容显示不正常
    self.automaticallyAdjustsScrollViewInsets = NO;
    ZJSegmentStyle *style = [[ZJSegmentStyle alloc] init];
    // 缩放标题
    style.scaleTitle = YES;
    // 颜色渐变
    style.gradualChangeTitleColor = YES;
    // 设置附加按钮的背景图片
    // 设置子控制器 --- 注意子控制器需要设置title, 将用于对应的tag显示title
    NSArray *childVcs = [NSArray arrayWithArray:[self setupChildVcAndTitle]];
    // 初始化
    ZJScrollPageView *scrollPageView = [[ZJScrollPageView alloc] initWithFrame:CGRectMake(0, 64.0, self.view.bounds.size.width, self.view.bounds.size.height - 64.0) segmentStyle:style childVcs:childVcs parentViewController:self];
    [self.view addSubview:scrollPageView];
    self.navigationController.navigationBar.barStyle = UIStatusBarStyleDefault;
    [self.navigationController.navigationBar setTintColor:[UIColor lightGrayColor]];
    
    
    
    //-----------------------------------
    NSMutableArray *arrayFav = [[NSMutableArray alloc]init];
    AppDelegate *delegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    sqlite3 *db = [delegate getDB];
    if (db != nil) {
        sqlite3_stmt *statement;
        NSString *sqlNsstring = [NSString stringWithFormat:@"SELECT * FROM pageFav WHERE name ='%@'",app.selectName];
        
        const char *sql = [sqlNsstring cStringUsingEncoding:NSUTF8StringEncoding];
        
        
        sqlite3_prepare(db, sql, -1, &statement, NULL);
        
        
        while (sqlite3_step(statement) == SQLITE_ROW) {
            char *name = (char *)sqlite3_column_text(statement, 1);
            [arrayFav addObject:[NSString stringWithCString:name encoding:NSUTF8StringEncoding]];
        }
        if (arrayFav.count==0){
            boolFav=false;
            self.navigationController.navigationBar.barStyle = UIStatusBarStyleDefault;
            [self.navigationController.navigationBar setTintColor:[UIColor lightGrayColor]];
            
        }else{
            boolFav=true;
            self.navigationController.navigationBar.barStyle = UIStatusBarStyleDefault;
            [self.navigationController.navigationBar setTintColor:[UIColor redColor]];
        }
        
    }
}


- (NSArray *)setupChildVcAndTitle {
    
    UIViewController *vc1 = [self.storyboard instantiateViewControllerWithIdentifier:@"page1_1"];
    vc1.view.backgroundColor = [UIColor whiteColor];
    vc1.title = @"         簡介         ";
    AppDelegate *app =  [[UIApplication sharedApplication] delegate];

    
    UIViewController *vc1_3 = [self.storyboard instantiateViewControllerWithIdentifier:@"page3_1"];
    vc1_3.view.backgroundColor = [UIColor whiteColor];
    vc1_3.title = @"         訂房         ";
    
    
    UIViewController *vc1_4 = [self.storyboard instantiateViewControllerWithIdentifier:@"page4_1"];
    vc1_4.view.backgroundColor = [UIColor whiteColor];
    vc1_4.title = @"         訂購         ";
    
    
    UIViewController *vc2 = [self.storyboard instantiateViewControllerWithIdentifier:@"page1_2"];
    vc2.view.backgroundColor = [UIColor whiteColor];
    vc2.title = @"        地圖         ";
    
    
    UIViewController *vc3 = [self.storyboard instantiateViewControllerWithIdentifier:@"page1_3"];
    vc3.view.backgroundColor = [UIColor whiteColor];
    vc3.title = @"         評分         ";
    
    
    NSArray *childVcs = [NSArray arrayWithObjects:vc1, vc2, vc3,  nil];
    
    if ([app.pageName isEqual:@"page4" ]){
        childVcs = [NSArray arrayWithObjects:vc1_4,vc2,vc3,  nil];
    }
    if([app.pageNameFor1_0 isEqual:@"page4"]){
        childVcs = [NSArray arrayWithObjects:vc1_4,vc2,vc3,  nil];
    }
    if([app.pageName  isEqual:@"page3"]){
        childVcs = [NSArray arrayWithObjects:vc1_3,vc2,vc3,  nil];
    }
    
    
    return childVcs;
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
