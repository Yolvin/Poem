//
//  NewTeaTableViewCell.m
//  Poem
//
//  Created by wyzc on 16/12/15.
//  Copyright © 2016年 wyzc. All rights reserved.
//

#import "NewTeaTableViewCell.h"
@interface NewTeaTableViewCell()

@property (weak, nonatomic) IBOutlet UILabel *contentLable;
@property (weak, nonatomic) IBOutlet UIImageView *userImageView;
@property (weak, nonatomic) IBOutlet UILabel *userLable;
@property (weak, nonatomic) IBOutlet UIButton *viewNumButton;
@property (weak, nonatomic) IBOutlet UIButton *commNumButton;
@property (weak, nonatomic) IBOutlet UILabel *titleLable;

@property (weak, nonatomic) IBOutlet UIImageView *HotImageView;
@property (weak, nonatomic) IBOutlet UILabel *HotThemeLable;
@property (weak, nonatomic) IBOutlet UILabel *HotMemberLable;
@property (weak, nonatomic) IBOutlet UILabel *HotCOmentLable;
@property (weak, nonatomic) IBOutlet UILabel *HotTimeLable;

/*小舍*/
@property (weak, nonatomic) IBOutlet UIImageView *XiaoImageView;
@property (weak, nonatomic) IBOutlet UILabel *XiaoNameLable;
@property (weak, nonatomic) IBOutlet UIImageView *XiaoPoraitImageView;
@property (weak, nonatomic) IBOutlet UILabel *XiaoNikeLable;
@property (weak, nonatomic) IBOutlet UIButton *XiaoViewButton;
@property (weak, nonatomic) IBOutlet UIButton *XiaoCommentButton;

//第四个
@property (weak, nonatomic) IBOutlet UIImageView *ForthPoraitImageView;

@property (weak, nonatomic) IBOutlet UILabel *ForthNameLable;


@end
@implementation NewTeaTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
//    [_themeButton setTitle:@"今日看点" forState:UIControlStateNormal];
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    // Initialization code
}

- (void)setModel:(NewTeaModel *)model{
    
    _model = model;
    
    self.titleLable.text = model.Title;
    
    //
    NSString*conText = model.data_description;

    NSDictionary * dic  = [NSDictionary setTextLineSpaceWithString:conText withFont:14 withLineSpace:12  withTextlengthSpace:@0.5 paragraphSpacing:0];
    
    NSString * strrr = [NSString stringWithFormat:@"%@",model.data_description];
    
    NSAttributedString * str = [[NSAttributedString alloc] initWithString:strrr attributes:dic];
    
    self.contentLable.attributedText = str;
    //
    
    
    [self.userImageView setHeader:model.createdPortrait];
    
    [self.viewNumButton setTitle:[NSString stringWithFormat:@"%@",model.view] forState:UIControlStateNormal];
    
    [self.commNumButton setTitle:[NSString stringWithFormat:@"%@",model.reply] forState:UIControlStateNormal];
    
    self.HotTimeLable.text = [NSString timeWithTimeIntervalString:model.lastReplyTime];
    
    //第二个cell赋值
    self.userLable.text = model.createdNickname;
    
    [self.HotImageView setHeader:model.img];

    self.HotThemeLable.text = model.name;
    self.HotMemberLable.text = [NSString stringWithFormat:@"%@/3000人",model.memberCount];
    
    self.HotCOmentLable.text = model.data_description;
    
    //第三个cell赋值
    
    [self.XiaoImageView sd_setImageWithURL:[NSURL URLWithString:model.img]];
    self.XiaoNameLable.text = model.name;
    [self.XiaoPoraitImageView setHeader:model.createdPortrait];
    self.XiaoNikeLable.text = model.createdNickname;
     [self.XiaoViewButton setTitle:[NSString stringWithFormat:@"%@",model.memberCount] forState:UIControlStateNormal];
    [self.XiaoCommentButton setTitle:[NSString stringWithFormat:@"%@",model.topicCount] forState:UIControlStateNormal];
  
    //第四个
    [self.ForthPoraitImageView setHeader:model.portrait];
    self.ForthNameLable.text = model.nickname;
    
}


+ (instancetype)tempTableViewCellWith:(UITableView *)tableView indexPath:(NSInteger)indexPath {
    NSString *identifier = @"";//对应xib中设置的identifier
    NSInteger index = 0; //xib中第几个Cell
    switch (indexPath) {
        case 0:
            identifier = @"NewTeaTableViewCellFirst";
            index = 0;
            break;
        case 1:
            identifier = @"TempTableViewCellSecond";
            index = 1;
            break;
            
        case 2:
            identifier = @"TempTableViewCellThird";
            index = 2;
            break;
            
        case 3:
            identifier = @"TempTableViewCellForth";
            index = 3;
            break;
            
        default:
            break;
    }
    NewTeaTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"NewTeaTableViewCell" owner:self options:nil] objectAtIndex:index];
    }
    return cell;
    
}

- (void)setValue:(id)value forUndefinedKey:(NSString *)key{
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
