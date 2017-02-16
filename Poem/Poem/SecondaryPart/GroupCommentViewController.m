//
//  GroupCommentViewController.m
//  Poem
//
//  Created by wyzc on 16/12/29.
//  Copyright © 2016年 wyzc. All rights reserved.
//

#import "GroupCommentViewController.h"
#import "XiaoSheViewController.h"
#import "GeRenViewController.h"
#import "GroupMemBersViewController.h"

@interface GroupCommentViewController ()
//用户头像
@property (weak, nonatomic) IBOutlet UIImageView *userImageView;
//用户名
@property (weak, nonatomic) IBOutlet UILabel *nameLable;
//群聊主题
@property (weak, nonatomic) IBOutlet UILabel *themeLable;
//群聊简介
@property (weak, nonatomic) IBOutlet UILabel *commentLable;
//话题数量
@property (weak, nonatomic) IBOutlet UILabel *topicNumLable;
//创建时间
@property (weak, nonatomic) IBOutlet UILabel *createTimeLable;
//群聊成员人数
@property (weak, nonatomic) IBOutlet UILabel *memberNumLable;

@property(nonatomic,strong)NewTeaModel * model;


@property (nonatomic, weak) AFHTTPSessionManager *manager;
@property(nonatomic,strong)NSMutableArray * dataArr;

@end

@implementation GroupCommentViewController
- (AFHTTPSessionManager *)manager{
    if (!_manager) {
        _manager = [AFHTTPSessionManager manager];
    }
    return _manager;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self requestData];
    // Do any additional setup after loading the view from its nib.
}
- (void)requestData{
    
    WEAKSELF;
    
    self.manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/plain", nil];
    [self.manager GET:TOPICCONTENTURL(self.groupID) parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        //        NSLog(@"%@",task.currentRequest.URL);
        
        weakSelf.model = [NewTeaModel mj_objectWithKeyValues:responseObject[@"data"]];
        NSLog(@"%@",responseObject[@"data"]);
        dispatch_async(dispatch_get_main_queue(), ^{
            
            
        });
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        NSLog(@"%@",error);
    }];
    
    
}
- (void)setModel:(NewTeaModel *)model{
    _model = model;
    [self.userImageView setHeader:model.createdPortrait];
    self.nameLable.text = model.createdNickname;
    self.themeLable.text = model.name;
    
    NSString*conText = model.data_description;
    
    NSDictionary * dic  = [NSDictionary setTextLineSpaceWithString:conText withFont:14 withLineSpace:15  withTextlengthSpace:@0.8 paragraphSpacing:0];
    
    NSString * strrr = [NSString stringWithFormat:@"%@",model.data_description];
    
    NSAttributedString * str = [[NSAttributedString alloc] initWithString:strrr attributes:dic];
    
    
    self.commentLable.attributedText = str;
    
    self.topicNumLable.text = [NSString stringWithFormat:@"话题: %@",model.topicCount];
    NSString * creatTime = [NSString timeWithTimeIntervalString:model.createdTime];
    self.createTimeLable.text = [NSString stringWithFormat:@"创建时间: %@",creatTime];
    self.memberNumLable.text = [NSString stringWithFormat:@"群聊成员: %@",model.memberCount];
}
- (IBAction)backClick:(UIButton *)sender {
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
}
//进入小舍
- (IBAction)enterXiaoShe:(id)sender {
    XiaoSheViewController * groupVC = [[XiaoSheViewController alloc]init];
    groupVC.groupID = self.groupID;
    
    [self presentViewController:groupVC animated:YES completion:^{
        
    }];
    
    
        
        

}
//点击进入个人页
- (IBAction)enterGenRen:(id)sender {
    GeRenViewController * gerenVC = [[GeRenViewController alloc]init];
    gerenVC.userID = _model.createdUserId;
    
    [self presentViewController:gerenVC animated:YES completion:^{
        
    }];
    
}

//点击进入群组成员页

- (IBAction)enterGroupMember:(id)sender {
    GroupMemBersViewController * groupMemVC = [[GroupMemBersViewController alloc]init];
    groupMemVC.groupId = self.groupID;
    
    [self presentViewController:groupMemVC animated:YES completion:^{
        
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
