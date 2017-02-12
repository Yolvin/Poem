//
//  FuJianView.h
//  Poem
//
//  Created by wyzc on 16/12/15.
//  Copyright © 2016年 wyzc. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FuJianView : UIView
@property (weak, nonatomic) IBOutlet UIImageView *meiImageView;
@property (weak, nonatomic) IBOutlet UILabel *timeLable;

@property (weak, nonatomic) IBOutlet UIButton *AllCommentButton;
@property (weak, nonatomic) IBOutlet UIButton *HotCommentButton;

@property(nonatomic,strong)NewTeaModel * model;


//+ (instancetype)getFujianViewWith:
@end
