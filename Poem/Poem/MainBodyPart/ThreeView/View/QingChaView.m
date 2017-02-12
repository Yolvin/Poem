//
//  QingChaView.m
//  Poem
//
//  Created by wyzc on 16/12/16.
//  Copyright © 2016年 wyzc. All rights reserved.
//

#import "QingChaView.h"
#import "NewTeaTableViewCell.h"
#import "FuJianView.h"
#import "QingChaViewController.h"

@interface QingChaView()<UITableViewDelegate,UITableViewDataSource>

@property(nonatomic,strong)UITableView * tableView;

@property (nonatomic, weak) AFHTTPSessionManager *manager;

@property(nonatomic,strong)FuJianView * FUview;

@property(nonatomic,strong)NSMutableArray * dataArr;

@end

@implementation QingChaView

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
    
    [self.manager GET:NEWTEAURL(0, 1,20) parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        weakSelf.dataArr = [NewTeaModel mj_objectArrayWithKeyValuesArray:responseObject[@"data"]];
        
        [weakSelf.tableView reloadData];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        NSLog(@"%@",error);
    }];
    
    
}

- (void)setUpTableVIew{
    
    
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(10, 0, self.width-25, self.height)];
//    _tableView.centerX = self.centerX;

    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tableView.showsVerticalScrollIndicator = NO;
    
    
    
    //设置header 设置整体的header会随cell滑动
    _tableView.sectionHeaderHeight = 20;
//    self.FUview = [[[NSBundle mainBundle] loadNibNamed:@"FuJianView" owner:self options:nil]lastObject];
    self.FUview = [[[NSBundle mainBundle] loadNibNamed:@"FuJianView" owner:self options:nil]objectAtIndex:0];
    self.FUview.frame =CGRectMake(0, 0, _tableView.width, 50);
//    [self.FUview.meiImageView removeFromSuperview];
    
    
    
    self.FUview.timeLable.text = @"今日新茶";
    
    _tableView.tableHeaderView = self.FUview;
    
    [self addSubview:_tableView];
    
    
    
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NSString*conText = [self.dataArr[indexPath.row] data_description];
    NSDictionary * dic = [NSDictionary setTextLineSpaceWithString:conText withFont:14 withLineSpace:8  withTextlengthSpace:@0.3 paragraphSpacing:0];
    
    CGRect rect = [[self.dataArr[indexPath.row] data_description] boundingRectWithSize:CGSizeMake(230, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingTruncatesLastVisibleLine|NSStringDrawingUsesFontLeading attributes:dic context:nil];
    
    return rect.size.height+135;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return _dataArr.count;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
        NewTeaTableViewCell * cell = [NewTeaTableViewCell tempTableViewCellWith:tableView indexPath:0];
        cell.model = _dataArr[indexPath.row];
    
        [cell.themeButton removeFromSuperview];
    
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
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    QingChaViewController * qingChaVC = [[QingChaViewController alloc]init];
    qingChaVC.topicID = [_dataArr[indexPath.row] topicId];
    qingChaVC.theme = [_dataArr[indexPath.row] Title];
    qingChaVC.nickName = [_dataArr[indexPath.row] createdNickname];
    dispatch_async(dispatch_get_main_queue(), ^{
        //使用present会有跳转延迟
        UIResponder *responder = self;
        while ((responder = [responder nextResponder]))
            if ([responder isKindOfClass: [UIViewController class]]){
                [(UIViewController *)responder presentViewController:qingChaVC animated:YES completion:^{
                    
                }];
            }
        
    });
}
@end
