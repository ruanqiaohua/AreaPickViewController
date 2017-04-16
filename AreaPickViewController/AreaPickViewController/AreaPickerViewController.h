//
//  AreaPickerViewController.h
//  AreaPickerViewController
//
//  Created by 阮巧华 on 2017/4/16.
//  Copyright © 2017年 阮巧华. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AreaPickerModel : NSObject

/** 省份 */
@property (copy, nonatomic) NSString *province;
/** 城市 */
@property (copy, nonatomic) NSString *city;
/** 区域 */
@property (copy, nonatomic) NSString *area;

@end

@interface AreaPickerViewController : UIViewController

typedef void(^CallBack)(AreaPickerViewController *areaPicker,AreaPickerModel *model);

/** 初始化 */
+ (instancetype)areaPicker;
/** 显示 */
- (void)show;
/** 隐藏 */
- (void)dismiss;
/** 直接显示 */
+ (instancetype)showAreaPicker;
/** 直接显示并指定移动位置(参考plist文件) */
+ (instancetype)showAreaPicker:(NSInteger)province city:(NSInteger)city area:(NSInteger)area;
/** 确定按钮点击回调 */
- (void)sureButtonPressedCallBack:(CallBack)callBack;
@end
