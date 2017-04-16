//
//  ViewController.m
//  AreaPickViewController
//
//  Created by 阮巧华 on 2017/4/16.
//  Copyright © 2017年 阮巧华. All rights reserved.
//

#import "ViewController.h"
#import "AreaPickerViewController.h"

@interface ViewController ()

@property (weak, nonatomic) IBOutlet UILabel *textLabel;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (IBAction)buttonPressed:(UIButton *)sender {

    AreaPickerViewController *vc;
    // one
     vc = [AreaPickerViewController showAreaPicker:8 city:2 area:8];
    [vc sureButtonPressedCallBack:^(AreaPickerViewController *areaPicker, AreaPickerModel *model) {
        _textLabel.text = [NSString stringWithFormat:@"%@ %@ %@",model.province,model.city,model.area];
        [areaPicker dismiss];
    }];
    // two
    // [AreaPickerViewController showAreaPicker];
    // three
    // AreaPickerViewController *vc = [AreaPickerViewController areaPicker];
    // [vc show];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
