//
//  NewTeaTableViewCell.h
//  Poem
//
//  Created by wyzc on 16/12/15.
//  Copyright © 2016年 wyzc. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NewTeaTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIButton *themeButton;
@property (weak, nonatomic) IBOutlet UIButton *HotThemeButton;


@property(nonatomic,strong)NewTeaModel * model;

+ (instancetype)tempTableViewCellWith:(UITableView *)tableView indexPath:(NSInteger)indexPath;

@end
