#import <UIKit/UIKit.h>
#import "AppDelegate.h"
#import <AVFoundation/AVSpeechSynthesis.h>
#import <AVFoundation/AVFoundation.h>
@interface PageSearchViewController : UIViewController<UITableViewDataSource,UITableViewDelegate,UITextViewDelegate, AVSpeechSynthesizerDelegate>
{
    
    NSMutableArray *searchResult;
    NSMutableArray *searchResultImg;
    UISearchController *mySearchController;
    AVAudioPlayer *audioPlayer;
}


//@property (nonatomic,weak)id <CakeDelegate>delelgate;牛

@property NSString *page4Select;
@property (strong, nonatomic) UIViewController *pageNext;


//Table

@property (strong, nonatomic) IBOutlet UITableView *tableMsg;

//Button
@property (strong, nonatomic) IBOutlet UIBarButtonItem *barbutton;



@end
