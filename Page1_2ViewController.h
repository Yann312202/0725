//
//  Page1_2ViewController.h
//  proj0628
//
//  Created by YannLin on 2016/6/29.
//  Copyright © 2016年 ZeroJ. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import <CoreLocation/CoreLocation.h>

@interface Page1_2ViewController : UIViewController<CLLocationManagerDelegate>
{
    MKMapView *mapview;
    CLLocationManager *_locationManager;
    
}
@property (strong, nonatomic) IBOutlet MKMapView *mymap;
@property (strong, nonatomic) IBOutlet UIWebView *webView;



@end
