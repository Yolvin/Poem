//
//  QingChaViewController.m
//  Poem
//
//  Created by wyzc on 16/12/30.
//  Copyright © 2016年 wyzc. All rights reserved.
//

#import "QingChaViewController.h"
#import "CommentTableViewCell.h"

@interface QingChaViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, weak) AFHTTPSessionManager *manager;
@property(nonatomic,strong)NSMutableArray * dataArr2;
@property(nonatomic,assign)int index;
@end

@implementation QingChaViewController
- (AFHTTPSessionManager *)manager{
    if (!_manager) {
        _manager = [AFHTTPSessionManager manager];
    }
    return _manager;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUpTableVIew];
    [self requestData];
    
    _index = arc4random()%4;
//    NSLog(@"%@",self.nickName);
    
    // Do any additional setup after loading the view from its nib.
}
- (void)requestData{
    
    WEAKSELF;
    
    self.manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/plain", nil];
    [self.manager GET:COMMENTREPLYURL(self.topicID, 3) parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
//                NSLog(@"%@",task.currentRequest.URL);
        
        weakSelf.dataArr2 = [NewTeaModel mj_objectArrayWithKeyValuesArray:responseObject[@"data"]];
        dispatch_async(dispatch_get_main_queue(), ^{
            [weakSelf.tableView reloadData];
        });
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        NSLog(@"%@",error);
    }];
    
    
}

- (void)setUpTableVIew{
    
    
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tableView.showsVerticalScrollIndicator = NO;
    
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
       return 600;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
//    return 5;
    return _dataArr2.count+1;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 0) {
        CommentTableViewCell * cell = [CommentTableViewCell tempTableViewCellWith:tableView indexPath:2];
        NSArray * arr = @[@"qingChaPic01",@"qingChaPic05",@"qingChaPic03",@"qingChaPic04"];
        
        [cell.ThirdPicImageView setImage:[UIImage imageNamed:arr[_index]]];
        
        cell.ThirdThemeLable.text = self.theme;
        cell.ThirdNameLable.text = [NSString stringWithFormat:@"----%@",self.nickName];
        cell.ThirdCountLable.text = [NSString stringWithFormat:@"1/%ld",_dataArr2.count+1];
        return cell;
    }
    CommentTableViewCell * cell = [CommentTableViewCell tempTableViewCellWith:tableView indexPath:1];
    cell.model = _dataArr2[indexPath.row-1];
    cell.secondCountLable.text = [NSString stringWithFormat:@"%ld/%ld",indexPath.row+1,_dataArr2.count+1];
    return cell;
}
- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath{
    CATransform3D transform = CATransform3DIdentity;
    transform = CATransform3DRotate(transform, 0, 0, 0, 1);//渐变
    transform = CATransform3DTranslate(transform, 0, -100, 0);//左边水平移动
    transform = CATransform3DScale(transform, 0, 0, 0);//由小变大
    cell.layer.transform = transform;
    cell.layer.opacity = 0.0;
    [UIView animateWithDuration:0.6 animations:^{
        cell.layer.transform = CATransform3DIdentity;
        cell.layer.opacity = 1;
    }];
}
- (IBAction)backClick:(UIButton *)sender {
   [self dismissViewControllerAnimated:YES completion:^{
       
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
