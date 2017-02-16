//
//  GeRenViewController.m
//  Poem
//
//  Created by wyzc on 17/1/12.
//  Copyright © 2017年 wyzc. All rights reserved.
//

#import "GeRenViewController.h"
#import "DetailGeRenViewController.h"
#import "ShiJiViewController.h"

@interface GeRenViewController ()

@property (nonatomic, weak) AFHTTPSessionManager *manager;

@property(nonatomic,strong)NSMutableDictionary * Dict;
//头像
@property (weak, nonatomic) IBOutlet UIImageView *Porait;
//用户名
@property (weak, nonatomic) IBOutlet UILabel *userName;

//粉丝数
@property (weak, nonatomic) IBOutlet UILabel *fansNum;

//关注数
@property (weak, nonatomic) IBOutlet UILabel *focusNum;

@end

@implementation GeRenViewController

- (AFHTTPSessionManager *)manager{
    if (!_manager) {
        _manager = [AFHTTPSessionManager manager];
    }
    return _manager;
}

- (void)viewDidLoad {
    [super viewDidLoad];

    self.title=@"uuuu";
    
    [self requestData];
    NSLog(@"%@",_userID);
    // Do any additional setup after loading the view from its nib.
}

- (void)requestData{
    
    WEAKSELF;
    
    self.manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/plain"];
    
    [self.manager GET:GERENURL(self.userID) parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"%@",task.currentRequest.URL);
        weakSelf.Dict = responseObject[@"data"];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            
            [weakSelf.Porait setHeader:weakSelf.Dict[@"portrait"]];
            weakSelf.userName.text = weakSelf.Dict[@"nickname"];
            weakSelf.fansNum.text = [NSString stringWithFormat:@"粉丝 : %@",weakSelf.Dict[@"fans"]];
            weakSelf.focusNum.text = [NSString stringWithFormat:@"关注 : %@",weakSelf.Dict[@"follow"]];
            
            
        });
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        NSLog(@"%@",error);
    }];

}

//返回按钮
- (IBAction)backClick:(id)sender {
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
}
- (IBAction)TopicClick:(id)sender {
    
    DetailGeRenViewController * detailVC = [[DetailGeRenViewController alloc]init];
//    ShiJiViewController * shijiView = [[ShiJiViewController alloc]init];
    
    [self presentViewController:detailVC animated:YES completion:^{
        
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
