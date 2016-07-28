#import "AppDelegate.h"

@interface AppDelegate ()

@end

@implementation AppDelegate

- (void)viewDidLoad {

}


-(sqlite3 *)getDB
{
    return db;
}
- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    // 將資料庫檔案複製到具有寫入權限的目錄
    NSFileManager *fm = [[NSFileManager alloc] init];
    NSString *src = [[NSBundle mainBundle] pathForResource:@"opendata" ofType:@"sqlite"];
    NSString *dst = [NSString stringWithFormat:@"%@/Documents/opendata.sqlite", NSHomeDirectory()];
    
    // 檢查目的檔案是否存在，如果不存在則複製資料庫
    if ( ! [fm fileExistsAtPath:dst]) {
        [fm copyItemAtPath:src toPath:dst error:nil];
    }
    
    // 與資料庫連線，並將連線結果存入db變數中
    if (sqlite3_open([dst UTF8String], &db) != SQLITE_OK) {
        db = nil;
        NSLog(@"資料庫連線失敗");
    }else{
        NSLog(@"資料庫連線OK");
    }
    lm = [CLLocationManager new];
    [lm requestWhenInUseAuthorization];
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {

}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    sqlite3_close(db);
}

//-(BOOL)textFieldShouldReturn:(UITextField *)textField
//{
//    [textField setKeyboardType:UIKeyboardTypeNumbersAndPunctuation];
//    [textField reloadInputViews];
//    return YES;
//}


@end
