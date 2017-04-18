//
//  AreaPickerViewController.m
//  AreaPickerViewController
//
//  Created by 阮巧华 on 2017/4/16.
//  Copyright © 2017年 阮巧华. All rights reserved.
//

#import "AreaPickerViewController.h"

@interface AreaPickerViewController ()<UIPickerViewDataSource,UIPickerViewDelegate>

@property (strong, nonatomic) UIToolbar *toolbar;
@property (strong, nonatomic) UIPickerView *pickerView;
@property (strong, nonatomic) NSArray <NSDictionary *> *provinceList;
@property (strong, nonatomic) NSArray <NSDictionary *> *cityList;
@property (strong, nonatomic) NSArray <NSDictionary *> *areaList;
@property (copy, nonatomic) CallBack callBack;

@end

@implementation AreaPickerViewController

#pragma mark - Public

+ (instancetype)areaPicker {
    
    AreaPickerViewController *areaPicker = [[AreaPickerViewController alloc] init];
    areaPicker.view.backgroundColor = [UIColor clearColor];
    areaPicker.modalPresentationStyle = UIModalPresentationOverCurrentContext;
    
    [areaPicker pickerView];
    [areaPicker toolbar];
    // loadData
    [areaPicker provinceList];
    [areaPicker reloadCityList];
    [areaPicker reloadAreaList];
    return areaPicker;
}

+ (instancetype)showAreaPicker {
    
    AreaPickerViewController *areaPicker = [[AreaPickerViewController alloc] init];
    areaPicker.view.backgroundColor = [UIColor clearColor];
    areaPicker.modalPresentationStyle = UIModalPresentationOverCurrentContext;
    
    [areaPicker pickerView];
    [areaPicker toolbar];
    // loadData
    [areaPicker provinceList];
    [areaPicker reloadCityList];
    [areaPicker reloadAreaList];
    // show
    [areaPicker show];
    return areaPicker;
}

+ (instancetype)showAreaPicker:(NSInteger)province city:(NSInteger)city area:(NSInteger)area {
    
    AreaPickerViewController *areaPicker = [[AreaPickerViewController alloc] init];
    areaPicker.view.backgroundColor = [UIColor clearColor];
    areaPicker.modalPresentationStyle = UIModalPresentationOverCurrentContext;
    
    [areaPicker pickerView];
    [areaPicker toolbar];
    // loadData
    [areaPicker provinceList];
    [areaPicker.pickerView selectRow:province inComponent:0 animated:NO];
    [areaPicker reloadCityList];
    [areaPicker.pickerView selectRow:city inComponent:1 animated:NO];
    [areaPicker reloadAreaList];
    [areaPicker.pickerView selectRow:area inComponent:2 animated:NO];
    [areaPicker show];
    return areaPicker;
}

- (void)show {
    
    [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:self animated:YES completion:nil];
}

- (void)dismiss {
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)sureButtonPressedCallBack:(CallBack)callBack {
    
    if (callBack) {
        self.callBack = callBack;
    }
}

#pragma mark - Request

- (NSArray *)provinceList {
    if (!_provinceList) {
        NSString *path = [[NSBundle mainBundle] pathForResource:@"area" ofType:@"plist"];
        NSArray *array = [NSArray arrayWithContentsOfFile:path];
        _provinceList = array;
    }
    return _provinceList;
}

- (void)reloadCityList {
    
    NSInteger index = [_pickerView selectedRowInComponent:0];
    NSDictionary *dic = [_provinceList objectAtIndex:index];
    _cityList = [dic objectForKey:@"citys"];
    [self.pickerView reloadComponent:1];
}

- (void)reloadAreaList {
    
    NSInteger index = [_pickerView selectedRowInComponent:1];
    NSDictionary *dic = [_cityList objectAtIndex:index];
    _areaList = [dic objectForKey:@"areas"];
    [self.pickerView reloadComponent:2];
}

- (AreaPickerModel *)callBackAreaPickerModel {
    
    AreaPickerModel *model = [AreaPickerModel new];
    NSInteger index0 = [self.pickerView selectedRowInComponent:0];
    NSInteger index1 = [self.pickerView selectedRowInComponent:1];
    NSInteger index2 = [self.pickerView selectedRowInComponent:2];
    if (_provinceList.count) {
        NSString *province = [_provinceList[index0] objectForKey:@"Name"];
        model.province = province;
    } else {
        model.province = @"";
    }
    if (_cityList.count) {
        NSString *city = [_cityList[index1] objectForKey:@"Name"];
        model.city = city;
    } else {
        model.city = @"";
    }
    if (_areaList.count) {
        NSString *area = [_areaList[index2] objectForKey:@"Name"];
        model.area = area;
    } else {
        model.area = @"";
    }
    return model;
}

#pragma mark - UI

- (UIPickerView *)pickerView {
    if (!_pickerView) {
        CGFloat height = CGRectGetHeight(self.view.frame)/3;
        _pickerView = [[UIPickerView alloc] initWithFrame:CGRectMake(0, CGRectGetHeight(self.view.frame)-height, CGRectGetWidth(self.view.frame), height)];
        _pickerView.backgroundColor = [UIColor groupTableViewBackgroundColor];
        _pickerView.delegate = self;
        _pickerView.dataSource = self;
        [self.view addSubview:_pickerView];
    }
    return _pickerView;
}

- (UIToolbar *)toolbar {
    if (!_toolbar) {
        _toolbar = [[UIToolbar alloc] initWithFrame:CGRectMake(0, CGRectGetMinY(_pickerView.frame)-44, CGRectGetWidth(self.view.frame), 44)];
        UIBarButtonItem *leftButton = [[UIBarButtonItem alloc] initWithTitle:@"取消" style:UIBarButtonItemStylePlain target:self action:@selector(leftButtonPressed:)];
        UIBarButtonItem *flex = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:self action:nil];
        UIBarButtonItem *rightButton = [[UIBarButtonItem alloc] initWithTitle:@"确定" style:UIBarButtonItemStyleDone target:self action:@selector(rightButtonPressed:)];
        [_toolbar setItems:@[leftButton,flex,rightButton]];
        
        [self.view addSubview:_toolbar];
    }
    return _toolbar;
}

#pragma mark - UIPickerViewDataSource

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    
    return 3;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    
    switch (component) {
        case 0:
            return _provinceList.count;
        case 1:
            return _cityList.count;
        case 2:
            return _areaList.count;
        default:
            break;
    }
    return 0;
}

#pragma mark - UIPickerViewDelegate

- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view {

    UILabel* tView = (UILabel*)view;
    if (!tView)
    {
        tView = [[UILabel alloc] init];
        [tView setFont:[UIFont fontWithName:@"Helvetica" size:14]];
        [tView setTextAlignment:NSTextAlignmentCenter];
        tView.numberOfLines=3;
    }
    switch (component) {
        case 0:
            tView.text = [_provinceList[row] objectForKey:@"Name"];
            break;
        case 1:
            tView.text = [_cityList[row] objectForKey:@"Name"];
            break;
        case 2:
            tView.text = [_areaList[row] objectForKey:@"Name"];
            break;
        default:
            break;
    }
    return tView;
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    
    switch (component) {
        case 0:
        {
            [self reloadCityList];
            [pickerView selectRow:0 inComponent:1 animated:YES];
            [self reloadAreaList];
            [pickerView selectRow:0 inComponent:2 animated:YES];
        }
            break;
        case 1:
        {
            [self reloadAreaList];
            [pickerView selectRow:0 inComponent:2 animated:YES];
        }
            break;
        default:
            break;
    }
}

#pragma mark - UIButton

- (void)leftButtonPressed:(UIBarButtonItem *)sender {
    
    [self dismiss];
}

- (void)rightButtonPressed:(UIBarButtonItem *)sender {
    
    if (self.callBack) {
        self.callBack(self,[self callBackAreaPickerModel]);
    }
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
    UITouch *touch = touches.anyObject;
    if (self.view == touch.view) {
        [self dismiss];
    }
}

@end

@implementation AreaPickerModel

@end
