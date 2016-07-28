#import "Page1_3ViewController.h"

@interface Page1_3ViewController ()

@end

@implementation Page1_3ViewController


- (IBAction)btnSave:(id)sender {
    NSMutableArray *array = [[NSMutableArray alloc]initWithObjects:@"",nil];
    array=self.dataMsg;
    [array addObject: [NSString stringWithFormat:@"%@☆-%@",_label_star.text,_textLeave.text]];
    self.dataMsg = array;
    [self.tableMsg reloadData];
    

    
    NSMutableArray *array1;
    array1 = [NSMutableArray new];
    int value = [_label_star.text intValue];
    [array1 addObject:[NSNumber numberWithInt:value]];
}

- (void)viewDidLoad {
    

    self.dataMsg = [NSMutableArray arrayWithObjects:nil];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if(tableView ==self.tableMsg){
        return [self.dataMsg count];
    }else{
        return 0;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *simpleTableIdentifier = @"SimpleTableItem";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    if (cell == nil) {
        
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:NSLocaleIdentifier];
    }
    if(tableView == self.tableMsg) {
        
        
        cell.textLabel.text = @"會員1";
        cell.detailTextLabel.text=[_dataMsg objectAtIndex:indexPath.row] ;
        //        cell.imageView.image= [self.imageArray objectAtIndex:indexPath.row];
        
        
        
        cell.imageView.image=[UIImage imageNamed:@"ic_account_circle_3x.png"];
        
        
    }
    return cell;
}
//ic_star_border_3x
//ic_star_3x
- (IBAction)click_star1:(id)sender {
    [_btn_Star1 setBackgroundImage:[UIImage imageNamed:@"ic_star_3x.png"] forState:UIControlStateNormal];
    [_btn_Star2 setBackgroundImage:[UIImage imageNamed:@"ic_star_border_3x.png"] forState:UIControlStateNormal];
    [_btn_Star3 setBackgroundImage:[UIImage imageNamed:@"ic_star_border_3x.png"] forState:UIControlStateNormal];
    [_btn_Star4 setBackgroundImage:[UIImage imageNamed:@"ic_star_border_3x.png"] forState:UIControlStateNormal];
    [_btn_Star5 setBackgroundImage:[UIImage imageNamed:@"ic_star_border_3x.png"] forState:UIControlStateNormal];
    _label_star.text=@"1";
}
- (IBAction)click_star2:(id)sender {
    [_btn_Star1 setBackgroundImage:[UIImage imageNamed:@"ic_star_3x.png"] forState:UIControlStateNormal];
    [_btn_Star2 setBackgroundImage:[UIImage imageNamed:@"ic_star_3x.png"] forState:UIControlStateNormal];
    [_btn_Star3 setBackgroundImage:[UIImage imageNamed:@"ic_star_border_3x.png"] forState:UIControlStateNormal];
    [_btn_Star4 setBackgroundImage:[UIImage imageNamed:@"ic_star_border_3x.png"] forState:UIControlStateNormal];
    [_btn_Star5 setBackgroundImage:[UIImage imageNamed:@"ic_star_border_3x.png"] forState:UIControlStateNormal];
    _label_star.text=@"2";
}
- (IBAction)click_star3:(id)sender {
    [_btn_Star1 setBackgroundImage:[UIImage imageNamed:@"ic_star_3x.png"] forState:UIControlStateNormal];
    [_btn_Star2 setBackgroundImage:[UIImage imageNamed:@"ic_star_3x.png"] forState:UIControlStateNormal];
    [_btn_Star3 setBackgroundImage:[UIImage imageNamed:@"ic_star_3x.png"] forState:UIControlStateNormal];
    [_btn_Star4 setBackgroundImage:[UIImage imageNamed:@"ic_star_border_3x.png"] forState:UIControlStateNormal];
    [_btn_Star5 setBackgroundImage:[UIImage imageNamed:@"ic_star_border_3x.png"] forState:UIControlStateNormal];
    _label_star.text=@"3";
}
- (IBAction)click_star4:(id)sender {
    [_btn_Star1 setBackgroundImage:[UIImage imageNamed:@"ic_star_3x.png"] forState:UIControlStateNormal];
    [_btn_Star2 setBackgroundImage:[UIImage imageNamed:@"ic_star_3x.png"] forState:UIControlStateNormal];
    [_btn_Star3 setBackgroundImage:[UIImage imageNamed:@"ic_star_3x.png"] forState:UIControlStateNormal];
    [_btn_Star4 setBackgroundImage:[UIImage imageNamed:@"ic_star_3x.png"] forState:UIControlStateNormal];
    [_btn_Star5 setBackgroundImage:[UIImage imageNamed:@"ic_star_border_3x.png"] forState:UIControlStateNormal];
    
    _label_star.text=@"4";
}
- (IBAction)click_star5:(id)sender {
    [_btn_Star1 setBackgroundImage:[UIImage imageNamed:@"ic_star_3x.png"] forState:UIControlStateNormal];
    [_btn_Star2 setBackgroundImage:[UIImage imageNamed:@"ic_star_3x.png"] forState:UIControlStateNormal];
    [_btn_Star3 setBackgroundImage:[UIImage imageNamed:@"ic_star_3x.png"] forState:UIControlStateNormal];
    [_btn_Star4 setBackgroundImage:[UIImage imageNamed:@"ic_star_3x.png"] forState:UIControlStateNormal];
    [_btn_Star5 setBackgroundImage:[UIImage imageNamed:@"ic_star_3x.png"] forState:UIControlStateNormal];
    
    _label_star.text=@"5";
}
//☆



//按了cell的動作
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    [_textLeave resignFirstResponder];
}


@end
