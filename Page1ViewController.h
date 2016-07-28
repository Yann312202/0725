#import <UIKit/UIKit.h>
#import "AppDelegate.h"


@interface Page1ViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>
{

    NSMutableArray *searchResult;

    UISearchController *mySearchController;
}


//@property (nonatomic,weak)id <CakeDelegate>delelgate;牛

@property NSString *page1Select;
@property (strong, nonatomic) UIViewController *pageNext;


//Table
@property (strong, nonatomic) IBOutlet UITableView *tableArea;
@property (strong, nonatomic) IBOutlet UITableView *tableCity;
@property (strong, nonatomic) IBOutlet UITableView *tableTown;
@property (strong, nonatomic) IBOutlet UITableView *tableMsg;

//Button
@property (strong, nonatomic) IBOutlet UIBarButtonItem *barbutton;
@property (strong, nonatomic) IBOutlet UIButton *buttonSelect0;
@property (strong, nonatomic) IBOutlet UIButton *buttonSelect1;
@property (strong, nonatomic) IBOutlet UIButton *buttonSelect2;

- (IBAction)buttonSelect0Click:(id)sender;
- (IBAction)buttonSelect1Click:(id)sender;
- (IBAction)buttonSelect2Click:(id)sender;

//Array

//@property(strong , nonatomic) NSMutableArray *arrayMsg;
//@property(strong , nonatomic) NSMutableArray *arrayDialog;
//@property(strong , nonatomic) NSMutableArray *arrayImg;
//@property(strong , nonatomic) NSMutableArray *arrayId;




@end
