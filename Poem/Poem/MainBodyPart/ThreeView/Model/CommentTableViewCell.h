//
//  CommentTableViewCell.h
//  Poem
//
//  Created by wyzc on 16/12/22.
//  Copyright © 2016年 wyzc. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CommentTableViewCell : UITableViewCell
+ (instancetype)tempTableViewCellWith:(UITableView *)tableView indexPath:(NSInteger)indexPath;
@property(nonatomic,strong)NewTeaModel * model;

@property (weak, nonatomic) IBOutlet UILabel *secondCountLable;


@property (weak, nonatomic) IBOutlet UIView *secondBackView;
//第三个
@property (weak, nonatomic) IBOutlet UILabel *ThirdThemeLable;
@property (weak, nonatomic) IBOutlet UILabel *ThirdNameLable;
@property (weak, nonatomic) IBOutlet UIImageView *ThirdPicImageView;


@property (weak, nonatomic) IBOutlet UILabel *ThirdCountLable;
@end
