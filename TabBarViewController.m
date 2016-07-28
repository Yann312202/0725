#import "TabBarViewController.h"
#import "AppDelegate.h"//1
@interface TabBarViewController ()

@end

@implementation TabBarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    

    

    AppDelegate *delegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    AppDelegate *app =  [[UIApplication sharedApplication] delegate];
        app.pageName=@"page1";
        app.pageBack=@"pageStart";
    app.pageNameFor1_0=@"page1";
    sqlite3 *db = [delegate getDB];
    if (db != nil) {
        sqlite3_stmt *statement;
        NSMutableArray *arrayId = [[NSMutableArray alloc]init];
        NSMutableArray *arrayName = [[NSMutableArray alloc]init];
        NSMutableArray *arrayIntroduction = [[NSMutableArray alloc]init];
        NSMutableArray *arrayImg = [[NSMutableArray alloc]init];
        const char *sql;
        //1------------------
        sql = "SELECT * FROM page1";
        sqlite3_prepare(db, sql, -1, &statement, NULL);
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
        app.arrayId1=arrayId;
        app.arrayName1=arrayName;
        app.arrayDialog1=arrayIntroduction;
        app.arrayImg1=arrayImg;

        
        //2------------------
        sql = "SELECT * FROM page2";
        sqlite3_prepare(db, sql, -1, &statement, NULL);

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
        app.arrayId2=arrayId;
        app.arrayName2=arrayName;
        app.arrayDialog2=arrayIntroduction;
        app.arrayImg2=arrayImg;
        
        


        
        //3------------------
        sql = "SELECT * FROM page3";
        sqlite3_prepare(db, sql, -1, &statement, NULL);
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

        //4------------------
        sql = "SELECT * FROM page4";
        sqlite3_prepare(db, sql, -1, &statement, NULL);
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
        app.arrayId4=arrayId;
        app.arrayName4=arrayName;
        app.arrayDialog4=arrayIntroduction;
        app.arrayImg4=arrayImg;
        
    
        
        //town-------------------
        sql = "SELECT * FROM pageArea";
        sqlite3_prepare(db, sql, -1, &statement, NULL);
        NSMutableArray *arrayTown = [[NSMutableArray alloc]init];
        arrayTown = [[NSMutableArray alloc]init];
        [arrayTown addObject:@"所有"];
        while (sqlite3_step(statement) == SQLITE_ROW) {
            char *town = (char *)sqlite3_column_text(statement, 2);
            [arrayTown addObject:[NSString stringWithCString:town encoding:NSUTF8StringEncoding]];
        }
        app.arrayTown=arrayTown;
        
        //---Area
        sql = "SELECT DISTINCT area FROM PageArea";
        sqlite3_prepare(db, sql, -1, &statement, NULL);
        NSMutableArray *arrayArea = [[NSMutableArray alloc]init];
        arrayArea = [[NSMutableArray alloc]init];
        [arrayArea addObject:@"所有"];
        while (sqlite3_step(statement) == SQLITE_ROW) {
            char *area = (char *)sqlite3_column_text(statement, 0);
            [arrayArea addObject:[NSString stringWithCString:area encoding:NSUTF8StringEncoding]];
        }
        app.arrayArea=arrayArea;
        
        //---City
        sql = "SELECT DISTINCT city FROM PageArea";
        sqlite3_prepare(db, sql, -1, &statement, NULL);
        NSMutableArray *arrayCity = [[NSMutableArray alloc]init];
        arrayCity = [[NSMutableArray alloc]init];
        [arrayCity addObject:@"所有"];
        while (sqlite3_step(statement) == SQLITE_ROW) {
            char *city = (char *)sqlite3_column_text(statement, 0);
            [arrayCity addObject:[NSString stringWithCString:city encoding:NSUTF8StringEncoding]];
        }
        app.arrayCity=arrayCity;
        
        sqlite3_finalize(statement);
        
    }
    
    //設定delegate預設值
    




    



    

    
    
    
}



-(void)viewWillAppear:(BOOL)animated{//隱藏導航列
    self.navigationController.navigationBarHidden=YES;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
@end
