//
//  XiaoSheViewController.m
//  Poem
//
//  Created by wyzc on 17/1/5.
//  Copyright © 2017年 wyzc. All rights reserved.
//

#import "XiaoSheViewController.h"
#import "NewTeaTableViewCell.h"
#import "FuJianView.h"

@interface XiaoSheViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, weak) AFHTTPSessionManager *manager;

@property(nonatomic,strong)FuJianView * FUview;

@property(nonatomic,strong)NSMutableArray * dataArr;


@end

@implementation XiaoSheViewController
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
- (void)requestData{
    
    WEAKSELF;
    
    self.manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/plain"];
    
    [self.manager GET:XIAOSHEDETAILURL(self.groupID) parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        weakSelf.dataArr = [NewTeaModel mj_objectArrayWithKeyValuesArray:responseObject[@"data"]];
        
        [weakSelf.tableView reloadData];
        
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
    
    NSString*conText = [self.dataArr[indexPath.row] data_description];
    NSDictionary * dic = [NSDictionary setTextLineSpaceWithString:conText withFont:14 withLineSpace:8  withTextlengthSpace:@0.3 paragraphSpacing:0];
    
    CGRect rect = [[self.dataArr[indexPath.row] data_description] boundingRectWithSize:CGSizeMake(230, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingTruncatesLastVisibleLine|NSStringDrawingUsesFontLeading attributes:dic context:nil];
    
    return rect.size.height+170;
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
