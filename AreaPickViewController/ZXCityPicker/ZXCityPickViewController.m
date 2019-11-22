//
//  ZXCityPickViewController.m
//  AreaPickViewController
//
//  Created by 阮巧华 on 2019/11/22.
//  Copyright © 2019 阮巧华. All rights reserved.
//

#import "ZXCityPickViewController.h"
#import "JXPickerTableViewController.h"

@interface ZXCityPickViewController ()

@property (nonatomic, strong) UILabel *topLabel;
@property (nonatomic, strong) UIView *contentView;
@property (strong, nonatomic) NSArray <NSDictionary *> *provinceList;
@property (strong, nonatomic) NSArray <NSDictionary *> *cityList;
@property (strong, nonatomic) NSArray <NSString *> *areaList;
/** 省份 */
@property (copy, nonatomic) NSString *province;
/** 城市 */
@property (copy, nonatomic) NSString *city;
/** 区域 */
@property (copy, nonatomic) NSString *area;

@end

@implementation ZXCityPickViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    [self setTitle:@"选择地区"];
    self.view.backgroundColor = [UIColor whiteColor];

    _topLabel = [[UILabel alloc] init];
    _topLabel.backgroundColor = [UIColor whiteColor];
    _topLabel.textColor = [UIColor colorWithRed:102.0f/255.0f green:102.0f/255.0f blue:102.0f/255.0f alpha:1.0f];
    _topLabel.textAlignment = NSTextAlignmentCenter;
    _topLabel.font = [UIFont systemFontOfSize:12];
    _topLabel.text = @"请选择所在地区的商户，可收款地区持续更新中";
    [self.view addSubview:_topLabel];
    [_topLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.mas_equalTo(0);
        make.height.mas_equalTo(60);
    }];
    
    _contentView = [[UIView alloc] init];
    _contentView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:_contentView];
    [_contentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_topLabel.mas_bottom);
        make.left.bottom.right.mas_equalTo(0);
    }];

    JXPickerTableViewController *vc1 = [[JXPickerTableViewController alloc] init];
    vc1.selectedBackgroundColor = [UIColor colorWithRed:236.0f/255.0f green:236.0f/255.0f blue:236.0f/255.0f alpha:1.0f];
    vc1.view.backgroundColor = [UIColor colorWithRed:220.0f/255.0f green:220.0f/255.0f blue:220.0f/255.0f alpha:1.0f];
    [_contentView addSubview:vc1.view];
    [self addChildViewController:vc1];

    JXPickerTableViewController *vc2 = [[JXPickerTableViewController alloc] init];
    vc2.selectedBackgroundColor = [UIColor colorWithRed:252.0f/255.0f green:252.0f/255.0f blue:252.0f/255.0f alpha:1.0f];
    vc2.view.backgroundColor = [UIColor colorWithRed:236.0f/255.0f green:236.0f/255.0f blue:236.0f/255.0f alpha:1.0f];
    [_contentView addSubview:vc2.view];
    [self addChildViewController:vc2];

    JXPickerTableViewController *vc3 = [[JXPickerTableViewController alloc] init];
    vc3.selectedBackgroundColor = [UIColor whiteColor];
    vc3.view.backgroundColor = [UIColor colorWithRed:252.0f/255.0f green:252.0f/255.0f blue:252.0f/255.0f alpha:1.0f];
    [_contentView addSubview:vc3.view];
    [self addChildViewController:vc3];
    
    NSArray *views = @[vc1.view,vc2.view,vc3.view];
    [views mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.mas_equalTo(0);
    }];
    [views mas_distributeViewsAlongAxis:MASAxisTypeHorizontal withFixedSpacing:0 leadSpacing:0 tailSpacing:0];

    vc1.list = [self getList:self.provinceList];
    __weak typeof(self) weakSelf = self;
    [vc1 setDidSelectRowCallback:^(NSInteger index) {
        weakSelf.province = weakSelf.provinceList[index].allKeys.firstObject;
        vc3.list = nil;
        vc2.list = [weakSelf getList:[weakSelf cityList:index]];
        [vc2 setDidSelectRowCallback:^(NSInteger index) {
            weakSelf.city = weakSelf.cityList[index].allKeys.firstObject;
            vc3.list = [weakSelf areaList:index];
            [vc3 setDidSelectRowCallback:^(NSInteger index) {
                weakSelf.area = [weakSelf.areaList objectAtIndex:index];
                [weakSelf selectedLast];
            }];
        }];
    }];
    
}

- (void)selectedLast {
    
    if (self.selectedCallback) {
        self.selectedCallback(_province, _city, _area);
    }
}

/// 获取省份
- (NSArray *)provinceList {
    if (!_provinceList) {
        NSString *path = [[NSBundle mainBundle] pathForResource:@"area" ofType:@"plist"];
        NSArray *array = [NSArray arrayWithContentsOfFile:path];
        _provinceList = array;
    }
    return _provinceList;
}
/// 获取城市
- (NSArray<NSDictionary *> *)cityList:(NSInteger)index {
    NSDictionary *dic = [_provinceList objectAtIndex:index];
    _cityList = dic.allValues.firstObject;
    return _cityList;
}
/// 获取地区
- (NSArray<NSString *> *)areaList:(NSInteger)index  {
    NSDictionary *dic = [_cityList objectAtIndex:index];
    _areaList = dic.allValues.firstObject;
    return _areaList;
}
/// 获取文本数组
- (NSArray *)getList:(NSArray *)arr {
    NSMutableArray *list = [NSMutableArray arrayWithCapacity:arr.count];
    for (NSDictionary *dic in arr) {
        [list addObject:dic.allKeys.firstObject];
    }
    return list;
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
