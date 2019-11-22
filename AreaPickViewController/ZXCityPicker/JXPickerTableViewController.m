//
//  JXPickerTableViewController.m
//  AreaPickViewController
//
//  Created by 阮巧华 on 2019/11/22.
//  Copyright © 2019 阮巧华. All rights reserved.
//

#import "JXPickerTableViewController.h"

@interface JXPickerTableViewCell : UITableViewCell
@property (nonatomic, strong) UILabel *messageLabel;
@end

@implementation JXPickerTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        _messageLabel = [[UILabel alloc] init];
        _messageLabel.textColor = [UIColor colorWithRed:51.0f/255.0f green:51.0f/255.0f blue:51.0f/255.0f alpha:1.0f];
        _messageLabel.font = [UIFont systemFontOfSize:14];
        [self.contentView addSubview:_messageLabel];
        [_messageLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.bottom.mas_equalTo(0);
            make.left.mas_equalTo(25);
            make.right.mas_equalTo(-25);
        }];
        self.selectedBackgroundView = [[UIView alloc] initWithFrame:self.contentView.bounds];
        self.selectedBackgroundView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    }
    return self;
}
@end

@interface JXPickerTableViewController ()

@end

@implementation JXPickerTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.rowHeight = 47;
    self.tableView.showsVerticalScrollIndicator = NO;
    [self.tableView registerClass:[JXPickerTableViewCell class] forCellReuseIdentifier:reuseIdentifier];
}

- (void)setList:(NSArray<NSString *> *)list {
    _list = list;
    [self.tableView reloadData];
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _list.count;
}

NSString * const reuseIdentifier = @"reuseIdentifier";

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    JXPickerTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseIdentifier forIndexPath:indexPath];
    cell.selectedBackgroundView.backgroundColor = _selectedBackgroundColor;
    cell.backgroundColor = self.view.backgroundColor;
    cell.messageLabel.text = _list[indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (self.didSelectRowCallback) {
        self.didSelectRowCallback(indexPath.row);
    }
}

@end
