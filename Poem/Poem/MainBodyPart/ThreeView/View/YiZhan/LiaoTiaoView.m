//
//  LiaoTiaoView.m
//  Poem
//
//  Created by wyzc on 16/12/21.
//  Copyright © 2016年 wyzc. All rights reserved.
//

#import "LiaoTiaoView.h"
#import "NewTeaTableViewCell.h"
#import "FuJianView.h"
#import "GroupCommentViewController.h"

@interface LiaoTiaoView()<UITableViewDelegate,UITableViewDataSource>


@property(nonatomic,strong)UITableView * tableView;

@property (nonatomic, weak) AFHTTPSessionManager *manager;

@property(nonatomic,strong)FuJianView * FUview;

@property(nonatomic,strong)NSMutableArray * dataArr;

@end


@implementation LiaoTiaoView

- (AFHTTPSessionManager *)manager{
    if (!_manager) {
        _manager = [AFHTTPSessionManager manager];
    }
    return _manager;
}

- (instancetype)initWithFrame:(CGRect)frame{
    
    self = [super initWithFrame:frame];
    if (self) {
        [self setUpTableVIew];
        [self requestData];
    }
    return self;
}


- (void)requestData{
    
    WEAKSELF;
    
    self.manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/plain"];
    
    [self.manager GET:HOTCOMMNETURL(5) parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        weakSelf.dataArr = [NewTeaModel mj_objectArrayWithKeyValuesArray:responseObject[@"data"]];
        
        [weakSelf.tableView reloadData];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        NSLog(@"%@",error);
    }];
    
    
}

- (void)setUpTableVIew{
    
    
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, self.width-25, self.height-100)];
    _tableView.centerX = self.centerX;
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tableView.showsVerticalScrollIndicator = NO;
    
    
    
    
    //设置header 设置整体的header会随cell滑动
    _tableView.sectionHeaderHeight = 20;
//    self.FUview = [[[NSBundle mainBundle] loadNibNamed:@"FuJianView" owner:self options:nil]lastObject];
    self.FUview = [[[NSBundle mainBundle] loadNibNamed:@"FuJianView" owner:self options:nil]objectAtIndex:0];
    self.FUview.frame =CGRectMake(0, 0, _tableView.width, 50);
    [self.FUview.meiImageView removeFromSuperview];
    
    self.FUview.timeLable.text = @"热门聊天";
    
    _tableView.tableHeaderView = self.FUview;
    
    [self addSubview:_tableView];
    
    
    
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 110;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
   
    return _dataArr.count;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NewTeaTableViewCell * cell = [NewTeaTableViewCell tempTableViewCellWith:tableView indexPath:1];

        cell.model = _dataArr[indexPath.row];
    
    cell.model = _dataArr[indexPath.row];
        [cell.HotThemeButton removeFromSuperview];
    
        return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
   
    GroupCommentViewController * groupVC = [[GroupCommentViewController alloc]init];
    groupVC.groupID = [_dataArr[indexPath.row] groupId];
    //    NSLog(@"%@",[_dataArr2[indexPath.row] groupId]);
    
    
    dispatch_async(dispatch_get_main_queue(), ^{
        //使用present会有跳转延迟
        UIResponder *responder = self;
        while ((responder = [responder nextResponder]))
            if ([responder isKindOfClass: [UIViewController class]]){
                [(UIViewController *)responder presentViewController:groupVC animated:YES completion:^{
                    
                }];
            }
        
    });
    

    
    
    
    
}

@end
