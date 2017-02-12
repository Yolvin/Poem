//
//  CommentViewController.h
//  Poem
//
//  Created by wyzc on 16/12/26.
//  Copyright © 2016年 wyzc. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CommentViewController : UIViewController
@property(nonatomic,strong)NSString * topicID;
@property (weak, nonatomic) IBOutlet UILabel *themeLable;
@end
