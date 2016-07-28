#import <UIKit/UIKit.h>
#import <sqlite3.h>
#import <CoreLocation/CoreLocation.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>
{
    sqlite3 *db;
    CLLocationManager *lm;
}
-(sqlite3 *) getDB;

@property (strong , nonatomic)NSString *account;//登入帳號
@property (strong , nonatomic)NSString *pageName;//目前頁面

@property (strong , nonatomic)NSString *pageBack;//返回頁面
@property (strong , nonatomic)NSString *pageNameFor1_0;//目前頁面
@property (strong , nonatomic)NSString *selectId;
@property (strong , nonatomic)NSString *selectName;//
@property (strong , nonatomic)NSString *selectDialog;
@property (strong , nonatomic)NSString *selectImg;//
@property (strong , nonatomic)NSString *selectLat;
@property (strong , nonatomic)NSString *selectLon;
@property (strong , nonatomic)NSString *selectAddress;
@property (strong , nonatomic)NSString *selectPhone;
@property (strong , nonatomic)NSString *selectPerPrice;
@property (strong , nonatomic)NSString *selectQty;
@property (strong , nonatomic)NSString *selectCountPrice;
@property (strong , nonatomic)NSString *selectArea;
@property (strong , nonatomic)NSString *selectCity;
@property (strong , nonatomic)NSString *selectTown;
@property (strong , nonatomic)NSString *selectBuyNote;




@property (strong , nonatomic)NSString *myLat;
@property (strong , nonatomic)NSString *myLon;

@property NSString *comeToPage1Time;

@property (strong , nonatomic)NSMutableArray *arrayId1;
@property (strong , nonatomic)NSMutableArray *arrayId2;
@property (strong , nonatomic)NSMutableArray *arrayId3;
@property (strong , nonatomic)NSMutableArray *arrayId4;
@property (strong , nonatomic)NSMutableArray *arrayIdSearch;

@property (strong , nonatomic)NSMutableArray *arrayImg1;
@property (strong , nonatomic)NSMutableArray *arrayImg2;
@property (strong , nonatomic)NSMutableArray *arrayImg3;
@property (strong , nonatomic)NSMutableArray *arrayImg4;
@property (strong , nonatomic)NSMutableArray *arrayImgSearch;

@property (strong , nonatomic)NSMutableArray *arrayName1;
@property (strong , nonatomic)NSMutableArray *arrayName2;
@property (strong , nonatomic)NSMutableArray *arrayName3;
@property (strong , nonatomic)NSMutableArray *arrayName4;
@property (strong , nonatomic)NSMutableArray *arrayNameSearch;

@property (strong , nonatomic)NSMutableArray *arrayDialog1;
@property (strong , nonatomic)NSMutableArray *arrayDialog2;
@property (strong , nonatomic)NSMutableArray *arrayDialog3;
@property (strong , nonatomic)NSMutableArray *arrayDialog4;
@property (strong , nonatomic)NSMutableArray *arrayDialogSearch;
@property (strong , nonatomic)NSMutableArray *arrayCitySearch;
@property (strong , nonatomic)NSMutableArray *arrayTownSearch;


@property (strong , nonatomic)NSMutableArray *arrayArea;
@property (strong , nonatomic)NSMutableArray *arrayCity;
@property (strong , nonatomic)NSMutableArray *arrayCityNorth;
@property (strong , nonatomic)NSMutableArray *arrayCitySouth;
@property (strong , nonatomic)NSMutableArray *arrayCityWest;
@property (strong , nonatomic)NSMutableArray *arrayCityEast;
@property (strong , nonatomic)NSMutableArray *arrayCityIsland;
@property (strong , nonatomic)NSMutableArray *arrayTown;


@property (strong , nonatomic)NSMutableArray *myFav;

@property (strong, nonatomic) UIWindow *window;







@end

