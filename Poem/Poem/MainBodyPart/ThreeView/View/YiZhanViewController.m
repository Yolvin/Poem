//
//  YiZhanViewController.m
//  Poem
//
//  Created by wyzc on 16/12/26.
//  Copyright © 2016年 wyzc. All rights reserved.
//

#import "YiZhanViewController.h"
#import "NewTeaTableViewCell.h"
#import "FuJianView.h"
#import "CommentViewController.h"
#import "GroupCommentViewController.h"

@interface YiZhanViewController ()<UITableViewDelegate,UITableViewDataSource>

@property(nonatomic,strong)UITableView * tableView;

@property (nonatomic, weak) AFHTTPSessionManager *manager;

@property(nonatomic,strong)FuJianView * FUview;

@property(nonatomic,strong)NSMutableArray * dataArr;
@property(nonatomic,strong)NSMutableArray * dataArr2;

@end

@implementation YiZhanViewController

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
    // Do any additional setup after loading the view.
}
- (void)requestData{
    
    WEAKSELF;
    
    self.manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/plain"];
    
    [self.manager GET:NEWTEAURL(1, 1,20) parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        weakSelf.dataArr = [NewTeaModel mj_objectArrayWithKeyValuesArray:responseObject[@"data"]];
        
        [weakSelf.tableView reloadData];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        NSLog(@"%@",error);
    }];
    
    
    [self.manager GET:HOTCOMMNETURL(3) parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        weakSelf.dataArr2 = [NewTeaModel mj_objectArrayWithKeyValuesArray:responseObject[@"data"]];
        
        [weakSelf.tableView reloadData];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        NSLog(@"%@",error);
    }];
    
    
    
    
}

- (void)setUpTableVIew{
    
    
    
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(10, 0, self.view.width-25, self.view.height-130)];
    _tableView.centerX = self.view.centerX;
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tableView.showsVerticalScrollIndicator = NO;
    
    
    //添加footerView
    UILabel * bottomLable = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, _tableView.width, 20)];
    NSDictionary * dic  = @{NSFontAttributeName:[UIFont systemFontOfSize:13]};
    
    bottomLable.textAlignment = NSTextAlignmentCenter;
    bottomLable.textColor = [UIColor darkGrayColor];
    NSAttributedString * str = [[NSAttributedString alloc] initWithString:@"今日新茶已饮完" attributes:dic];
    bottomLable.attributedText = str;
    
    _tableView.tableFooterView = bottomLable;
    
    _tableView.sectionFooterHeight = 20;
    
    //设置header 设置整体的header会随cell滑动
    _tableView.sectionHeaderHeight = 20;
    self.FUview = [[[NSBundle mainBundle] loadNibNamed:@"FuJianView" owner:self options:nil]objectAtIndex:0];
    self.FUview.frame =CGRectMake(0, 0, _tableView.width, 250);
//        [self.FUview.meiImageView removeFromSuperview];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    NSDate * date = [NSDate dateWithTimeIntervalSinceNow:0];
    
    self.FUview.timeLable.text = [dateFormatter stringFromDate:date];
    _tableView.tableHeaderView = self.FUview;
    [self.view addSubview:_tableView];
    
    
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        return 110;
    }
    NSString*conText = [self.dataArr[indexPath.row] data_description];
    NSDictionary * dic = [NSDictionary setTextLineSpaceWithString:conText withFont:14 withLineSpace:15  withTextlengthSpace:@0.8 paragraphSpacing:0];
    
    CGRect rect = [[self.dataArr[indexPath.row] data_description] boundingRectWithSize:CGSizeMake(230, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingTruncatesLastVisibleLine|NSStringDrawingUsesFontLeading attributes:dic context:nil];
    
    return rect.size.height+135;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == 0) {
        return _dataArr2.count;
        
    }else{
        NSLog(@"%lu",(unsigned long)_dataArr.count);
        return _dataArr.count;
    }
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section == 0) {
        //今日热议
        NewTeaTableViewCell * cell = [NewTeaTableViewCell tempTableViewCellWith:tableView indexPath:1];
        cell.model = _dataArr2[indexPath.row];
        if (indexPath.row != 0) {
            [cell.HotThemeButton removeFromSuperview];
        }
        return cell;
        
    }else{
        //今日新茶
        NewTeaTableViewCell * cell = [NewTeaTableViewCell tempTableViewCellWith:tableView indexPath:0];
        cell.model = _dataArr[indexPath.row];
        
        return cell;
    }
    
    
    
    return 0;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    
    if (indexPath.section == 0) {
        //不能写在外面
        GroupCommentViewController * groupVC = [[GroupCommentViewController alloc]init];
        groupVC.groupID = [_dataArr2[indexPath.row] groupId];
        
        //强制在主线程执行
        dispatch_async(dispatch_get_main_queue(), ^{
            //使用present会有跳转延迟
            [self presentViewController:groupVC animated:YES completion:^{
                
            }];
            
        });
        
    }else{
        CommentViewController * commentVC = [[CommentViewController alloc]init];
        commentVC.topicID = [_dataArr[indexPath.row] topicId];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            //使用present会有跳转延迟
            [self presentViewController:commentVC animated:YES completion:^{
                
            }];
            
        });
    }
    
   
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
