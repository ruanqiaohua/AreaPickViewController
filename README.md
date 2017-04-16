# AreaPickViewController
地区选择器

![Image](https://github.com/ruanqiaohua/AreaPickViewController/blob/master/image.png)

```Objective-C
- (IBAction)buttonPressed:(UIButton *)sender {

    AreaPickerViewController *areaPicker = [AreaPickerViewController showAreaPicker:13 city:0 area:0];
    [areaPicker sureButtonPressedCallBack:^(AreaPickerViewController *areaPicker, AreaPickerModel *model) {
        _textLabel.text = [NSString stringWithFormat:@"%@ %@ %@",model.province,model.city,model.area];
        [areaPicker dismiss];
    }];
}
```


