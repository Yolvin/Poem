//
//  CommentTableViewCell.m
//  Poem
//
//  Created by wyzc on 16/12/22.
//  Copyright © 2016年 wyzc. All rights reserved.
//

#import "CommentTableViewCell.h"
#import "GeRenViewController.h"

@interface CommentTableViewCell ()
@property (weak, nonatomic) IBOutlet UIImageView *poraitImageView;
@property (weak, nonatomic) IBOutlet UILabel *nameLable;
@property (weak, nonatomic) IBOutlet UILabel *TimeLable;
@property (weak, nonatomic) IBOutlet UILabel *ContentLable;
@property (weak, nonatomic) IBOutlet UIImageView *ContentImageView;
@property (weak, nonatomic) IBOutlet UIButton *approveButton;
@property (weak, nonatomic) IBOutlet UIButton *CommentButton;
//第二个
//
@property (weak, nonatomic) IBOutlet UILabel *secondContentLable;
@property (weak, nonatomic) IBOutlet UIButton *secondApproveButton;
@property (weak, nonatomic) IBOutlet UIButton *secondCommentButton;

//
@property (weak, nonatomic) IBOutlet UIView *ThirdBackView;



@end

@implementation CommentTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.selectionStyle = UITableViewCellSelectionStyleNone;

    _secondBackView.layer.cornerRadius = 8;
    _secondBackView.layer.masksToBounds = YES;
    // A thin border.
    _secondBackView.layer.borderColor = [UIColor lightGrayColor].CGColor;
    _secondBackView.layer.borderWidth = 1;
    
    _ThirdBackView.layer.cornerRadius = 8;
    _ThirdBackView.layer.masksToBounds = YES;
    // A thin border.
    _ThirdBackView.layer.borderColor = [UIColor lightGrayColor].CGColor;
    _ThirdBackView.layer.borderWidth = 1;

    
    UITapGestureRecognizer * pan = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(imaClick:)];
    [_poraitImageView addGestureRecognizer:pan];
    
    
}
- (void)imaClick:(NSString *)str{
    
    GeRenViewController * gerenVC = [[GeRenViewController alloc]init];
    gerenVC.userID = _model.createdUserId;
//    UINavigationController * nav = [[UINavigationController alloc]initWithRootViewController:gerenVC];
//    dispatch_async(dispatch_get_main_queue(), ^{
        //使用present会有跳转延迟
    
        UIResponder *responder = self.superview;
        while ((responder = [responder nextResponder]))
            if ([responder isKindOfClass: [UIViewController class]]){
                UIViewController * vC = (UIViewController *)responder;
                //注意判断
                if (vC.presentedViewController == nil){
                [(UIViewController *)responder presentViewController:gerenVC animated:YES completion:^{
                    
                }];
                }
            }
        
//    });
//    NSLog(@"%@",_model.createdNickname);
}
- (void)setModel:(NewTeaModel *)model{
    _model = model;
    //第一个cell
    [self.poraitImageView setHeader:model.createdPortrait];
    self.nameLable.text = model.createdNickname;
    self.TimeLable.text = [NSString timeWithTimeIntervalStringFromNow:model.createdTime];
    
    NSString*conText = model.content;
    
    NSDictionary * dic  = [NSDictionary setTextLineSpaceWithString:conText withFont:14 withLineSpace:15  withTextlengthSpace:@0.8 paragraphSpacing:0];
    
    NSString * strrr = [NSString stringWithFormat:@"%@",model.content];
    
    NSAttributedString * str = [[NSAttributedString alloc] initWithString:strrr attributes:dic];
    
    self.ContentLable.attributedText = str;
    
    [self.approveButton setTitle:[NSString stringWithFormat:@"%@",model.praise] forState:UIControlStateNormal];
    [self.CommentButton setTitle:[NSString stringWithFormat:@"%@",model.comment] forState:UIControlStateNormal];
    [self.ContentImageView sd_setImageWithURL:[NSURL URLWithString:model.img]];
    
    //第二个cell
    self.secondContentLable.attributedText = str;
    [self.secondApproveButton setTitle:[NSString stringWithFormat:@"%@",model.praise] forState:UIControlStateNormal];
    [self.secondCommentButton setTitle:[NSString stringWithFormat:@"%@",model.comment] forState:UIControlStateNormal];
    
    
}

+ (instancetype)tempTableViewCellWith:(UITableView *)tableView indexPath:(NSInteger)indexPath {
    NSString *identifier = @"";//对应xib中设置的identifier
//    NSInteger index = 0; //xib中第几个Cell
    switch (indexPath) {
        case 0:
            identifier = @"CommentTableViewCellFirst";
            
            break;
            
        case 1:
            identifier = @"CommentTableViewCellSecond";
            
            break;
            
        case 2:
            identifier = @"CommentTableViewCellThird";
            
            break;
            
        default:
            break;
    }
    CommentTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"CommentTableViewCell" owner:self options:nil] objectAtIndex:indexPath];
    }
    return cell;
    
}

- (void)setValue:(id)value forUndefinedKey:(NSString *)key{
    
}
- (IBAction)approveClick:(UIButton *)sender {
    sender.selected = !sender.selected;
    int a = [_model.praise intValue];
    [self.approveButton setTitle:[NSString stringWithFormat:@"%d",a+1] forState:UIControlStateSelected];

}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
