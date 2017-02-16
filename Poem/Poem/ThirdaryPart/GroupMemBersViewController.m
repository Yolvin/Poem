//
//  GroupMemBersViewController.m
//  Poem
//
//  Created by Kevin on 17/2/15.
//  Copyright © 2017年 wyzc. All rights reserved.
//

#import "GroupMemBersViewController.h"
#import "NewTeaTableViewCell.h"
#import "GeRenViewController.h"


@interface GroupMemBersViewController ()<UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (nonatomic, weak) AFHTTPSessionManager *manager;

@property(nonatomic,strong)NSMutableArray * dataArr;

@property(nonatomic,assign)int page;

@end
static NSString * const ReuseIdenfifer = @"cell";

@implementation GroupMemBersViewController

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
    // Do any additional setup after loading the view from its nib.
}
- (void)setupRefresh
{
    [self requestData];
    WEAKSELF;
//    //下拉
//    // 设置回调（一旦进入刷新状态就会调用这个refreshingBlock）
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        
        [weakSelf requestData];
        
    }];

//    // 马上进入刷新状态
    [self.tableView.mj_header beginRefreshing];
    //上拉
    // 设置回调（一旦进入刷新状态就会调用这个refreshingBlock）
    self.tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        [weakSelf requestMoreData];
    }];
}

- (void)requestMoreData{
    _page ++;
    WEAKSELF;
    
    [self.manager.tasks makeObjectsPerformSelector:@selector(cancel)];
    
    self.manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/plain", nil];
    
    [self.manager GET:MEMBERSURL(self.groupId,_page) parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSMutableArray * muu = [NewTeaModel mj_objectArrayWithKeyValuesArray:responseObject[@"data"]];
        
        [weakSelf.dataArr addObjectsFromArray:muu];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            [weakSelf.tableView reloadData];
        //需要写才能加载出来新数据 结束刷新(恢复到普通状态，仍旧可以继续刷新)
        [weakSelf.tableView.mj_footer endRefreshing];
        });
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        NSLog(@"%@",error);
    }];

}

- (void)requestData{
    WEAKSELF;

    self.manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/plain", nil];
    [self.manager GET:MEMBERSURL(self.groupId,1) parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        //        NSLog(@"%@",task.currentRequest.URL);
        
        weakSelf.dataArr = [NewTeaModel mj_objectArrayWithKeyValuesArray:responseObject[@"data"]];
        dispatch_async(dispatch_get_main_queue(), ^{
            [weakSelf.tableView reloadData];
            [weakSelf.tableView.mj_header endRefreshing];

        });
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        NSLog(@"%@",error);
    }];

    
}

- (void)setUpTableVIew{
    
    
    _page = 1;
    
    [self setupRefresh];
    
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
//    _tableView.showsVerticalScrollIndicator = NO;
//    _tableView.translatesAutoresizingMaskIntoConstraints = NO;
    
    
    
    
    
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 70;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return _dataArr.count;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
   NewTeaTableViewCell * cell = [NewTeaTableViewCell tempTableViewCellWith:tableView indexPath:3];
    cell.model = _dataArr[indexPath.row];
//    cell.textLabel.text
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    GeRenViewController * gerenVC = [[GeRenViewController alloc]init];
    gerenVC.userID = [_dataArr[indexPath.row] userId];
    [self presentViewController:gerenVC animated:YES completion:^{
        
    }];
    
}


//返回按钮
- (IBAction)backClick:(id)sender {
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
