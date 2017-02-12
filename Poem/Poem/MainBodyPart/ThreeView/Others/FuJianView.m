//
//  FuJianView.m
//  Poem
//
//  Created by wyzc on 16/12/15.
//  Copyright © 2016年 wyzc. All rights reserved.
//

#import "FuJianView.h"

@interface FuJianView()
@property (weak, nonatomic) IBOutlet UIImageView *poraitImageView;
@property (weak, nonatomic) IBOutlet UILabel *nameLable;
@property (weak, nonatomic) IBOutlet UILabel *TimeLable;
@property (weak, nonatomic) IBOutlet UILabel *ContentLable;
@property (weak, nonatomic) IBOutlet UILabel *viewLable;

@property (weak, nonatomic) IBOutlet UILabel *commentNumLable;





@end

@implementation FuJianView

- (void)awakeFromNib
{
    [super awakeFromNib];
    
    
}
- (void)setModel:(NewTeaModel *)model{
    
    _model = model;
    [self.poraitImageView setHeader:model.createdPortrait];
    self.nameLable.text = model.createdNickname;
    
    self.TimeLable.text = [NSString timeWithTimeIntervalStringFromNow:model.createdTime];
    
    NSString*conText = model.data_description;
    
    NSDictionary * dic  = [NSDictionary setTextLineSpaceWithString:conText withFont:14 withLineSpace:15  withTextlengthSpace:@0.8 paragraphSpacing:0];
    
    NSString * strrr = [NSString stringWithFormat:@"%@",model.data_description];
    
    NSAttributedString * str = [[NSAttributedString alloc] initWithString:strrr attributes:dic];
    
    self.ContentLable.attributedText = str;
    
    self.viewLable.text = [NSString stringWithFormat:@"浏览: %@",model.view];
    self.commentNumLable.text = [NSString stringWithFormat:@"回帖: %@",model.reply];
    
    
}
- (void)setValue:(id)value forUndefinedKey:(NSString *)key{
    
}

//- (instancetype)initWithFrame:(CGRect)frame{
//    
//    self = [super initWithFrame:frame];
//    if (self) {
//
//
//    }
//    return self;
//}

//-(void)drawRect:(CGRect)rect
//{
//
//    
//}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
- (IBAction)allButtonClick:(UIButton *)sender {
    sender.selected = YES;
    self.HotCommentButton.selected = NO;
}
- (IBAction)hotButtonClick:(UIButton *)sender {
    sender.selected = YES;
    self.AllCommentButton.selected = NO;
}



@end
