//
//  ZXCityPickViewController.h
//  AreaPickViewController
//
//  Created by 阮巧华 on 2019/11/22.
//  Copyright © 2019 阮巧华. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ZXCityPickViewController : UIViewController

@property (nonatomic, copy) void (^(selectedCallback))(NSString *province, NSString *city, NSString *area);

@end

NS_ASSUME_NONNULL_END
