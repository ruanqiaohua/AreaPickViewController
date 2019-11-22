//
//  JXPickerTableViewController.h
//  AreaPickViewController
//
//  Created by 阮巧华 on 2019/11/22.
//  Copyright © 2019 阮巧华. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface JXPickerTableViewController : UITableViewController

@property (nonatomic, strong) UIColor *selectedBackgroundColor;
@property (nonatomic, strong, nullable) NSArray<NSString *> *list;
@property (nonatomic, copy) void (^(didSelectRowCallback))(NSInteger);

@end

NS_ASSUME_NONNULL_END
