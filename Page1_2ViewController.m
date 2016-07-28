#import "Page1_2ViewController.h"
#import "Page1ViewController.h"
#import "AppDelegate.h"//1
#import <MapKit/MapKit.h>
#import <CoreLocation/CoreLocation.h>

@interface Page1_2ViewController (){
    CLGeocoder * geocoder;
}
@property (strong, nonatomic) NSString *receiveData;

@end

@implementation Page1_2ViewController

- (void)startLocating
{
    if([CLLocationManager locationServicesEnabled])
    {
        _locationManager = [[CLLocationManager alloc] init];
        //设置定位的精度
        [_locationManager setDesiredAccuracy:kCLLocationAccuracyBest];
        _locationManager.distanceFilter = 100.0f;
        _locationManager.delegate = self;
        if ([[[UIDevice currentDevice] systemVersion] floatValue] > 8.0)
        {
            [_locationManager requestAlwaysAuthorization];
            [_locationManager requestWhenInUseAuthorization];
        }
        //开始实时定位
        [_locationManager startUpdatingLocation];
    }
}

-(void)locationManager:(CLLocationManager *)manager didChangeAuthorizationStatus:(CLAuthorizationStatus)status
{
    
    AppDelegate *app =  [[UIApplication sharedApplication] delegate];
    app.myLat=[NSString stringWithFormat:@"%f",manager.location.coordinate.latitude];
    app.myLon=[NSString stringWithFormat:@"%f",manager.location.coordinate.longitude];

    [_locationManager stopUpdatingLocation];
    
    NSString *myLocal = [NSString stringWithFormat:@"https://www.google.com.tw/maps/dir/'%@,%@'/'%@,%@'/",app.myLat,app.myLon,app.selectLat,app.selectLon];
    NSURL *url = [NSURL URLWithString:myLocal];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [self.webView loadRequest:request];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self startLocating];
    
    
//    AppDelegate *app =  [[UIApplication sharedApplication] delegate];
//    
    
    
//    NSString *doubleString;
//    doubleString=app.page1SelectLat;
//    double valueLat = [doubleString doubleValue];
//    
//    NSString *doubleString2;
//    doubleString2=app.page1SelectLon;
//    double valueLon = [doubleString2 doubleValue];
//
//    self.title=_receiveData;
////    MKPointAnnotation *ann = [MKPointAnnotation new];
////    ann.coordinate = CLLocationCoordinate2DMake(valueLat, valueLon);
////    ann.title = app.page1SelectName;
////    ann.subtitle = app.page1SelectDialog;
//
//    [self.mymap addAnnotation:ann];
   


    
    
    

}


-(void)mapView:(MKMapView *)mapView didUpdateUserLocation:(MKUserLocation *)userLocation{
    CLLocationCoordinate2D location = [userLocation coordinate];
    MKCoordinateRegion region = MKCoordinateRegionMakeWithDistance(location, 1000, 1000);
    [self.mymap setRegion:region animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];

}




@end













//
/////////
//// 取得現在所在位置
////    MKMapItem *currentLocation = [MKMapItem mapItemForCurrentLocation];
//
//// 取得台北101所在位置
//// 根據台北101座標設定一個大頭針標示
//MKPlacemark *markTaipei101 = [[MKPlacemark alloc] initWithCoordinate:CLLocationCoordinate2DMake(25.0335, 121.5651) addressDictionary:nil];
//MKMapItem *taipei101 = [[MKMapItem alloc] initWithPlacemark:markTaipei101];
//// 設定大頭針上的標籤資訊
//taipei101.name = @"台北101";
//taipei101.phoneNumber = @"0977123456";
//
//// 取得師大分部所在位置
//// 根據師大分部座標設定一個大頭針標示
//MKPlacemark *markSchool = [[MKPlacemark alloc] initWithCoordinate:CLLocationCoordinate2DMake(25.0084083, 121.535736) addressDictionary:nil];
//MKMapItem *school = [[MKMapItem alloc] initWithPlacemark:markSchool];
//// 設定大頭針上的標籤資訊
//school.name = @"師大分部";
//school.phoneNumber = @"0933123456";
//
//// 決定現在所在位置是起點還是終點
//// 這樣的設定是：師大分部為起點，台北101為終點
//NSArray *array = [[NSArray alloc] initWithObjects:school, taipei101, nil];
//
//// 設定導航模式是行車還是走路
//NSDictionary *param = [NSDictionary dictionaryWithObject:MKLaunchOptionsDirectionsModeDriving forKey:MKLaunchOptionsDirectionsModeKey];
//
//// 開啓內建的地圖
//[MKMapItem openMapsWithItems:array launchOptions:param];
