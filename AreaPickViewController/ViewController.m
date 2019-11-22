//
//  ViewController.m
//  AreaPickViewController
//
//  Created by 阮巧华 on 2017/4/16.
//  Copyright © 2017年 阮巧华. All rights reserved.
//

#import "ViewController.h"
#import "AreaPickerViewController.h"
#import "ZXCityPickViewController.h"

@interface ViewController ()

@property (weak, nonatomic) IBOutlet UILabel *textLabel;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (IBAction)buttonPressed:(UIButton *)sender {

    AreaPickerViewController *areaPicker = [AreaPickerViewController showAreaPicker:13 city:0 area:0];
    [areaPicker sureButtonPressedCallBack:^(AreaPickerViewController *areaPicker, AreaPickerModel *model) {
        _textLabel.text = [NSString stringWithFormat:@"%@ %@ %@",model.province,model.city,model.area];
        [areaPicker dismiss];
    }];
    
}

- (IBAction)button2Pressed:(UIButton *)sender {

    ZXCityPickViewController *areaPicker = [[ZXCityPickViewController alloc] init];
    [self showDetailViewController:areaPicker sender:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
