//
//  CommentViewController.m
//  Poem
//
//  Created by wyzc on 16/12/26.
//  Copyright © 2016年 wyzc. All rights reserved.
//

#import "CommentViewController.h"
#import "FuJianView.h"
#import "CommentTableViewCell.h"
#import "NewTeaModel.h"

@interface CommentViewController ()<UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UITextField *textField;
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (nonatomic, weak) AFHTTPSessionManager *manager;
@property(nonatomic,strong)NewTeaModel * model;

@property(nonatomic,strong)FuJianView * FUview;

@property(nonatomic,strong)NSMutableDictionary * dataDic;
@property(nonatomic,strong)NSMutableArray * dataArr2;
@property(nonatomic,assign)int sort;
@end

@implementation CommentViewController

- (AFHTTPSessionManager *)manager{
    if (!_manager) {
        _manager = [AFHTTPSessionManager manager];
    }
    return _manager;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    _sort = 2;
    [self setTextField];
    [self setUpTableVIew];
    [self requestMainData];
    [self requestData];
    _model = [[NewTeaModel alloc]init];
    // Do any additional setup after loading the view from its nib.
}
- (void)requestMainData{
    WEAKSELF;
    AFHTTPSessionManager* manger = [AFHTTPSessionManager manager];
    manger.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/plain", nil];
    [manger GET:COMMENTTHEMEURL(self.topicID) parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        weakSelf.dataDic = responseObject[@"data"];
        //        NSLog(@"%@",task.currentRequest.URL);
        weakSelf.model = [NewTeaModel mj_objectWithKeyValues:weakSelf.dataDic];
        dispatch_async(dispatch_get_main_queue(), ^{
            weakSelf.FUview.model = weakSelf.model;
            
            //设置FUview的frame
            NSString*conText = [weakSelf.model data_description];
            NSDictionary * dic = [NSDictionary setTextLineSpaceWithString:conText withFont:14 withLineSpace:15  withTextlengthSpace:@0.8 paragraphSpacing:0];
            
            CGRect rect = [[weakSelf.model data_description] boundingRectWithSize:CGSizeMake(230, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingTruncatesLastVisibleLine|NSStringDrawingUsesFontLeading attributes:dic context:nil];
            
            
            weakSelf.FUview.frame =CGRectMake(0, 0, weakSelf.tableView.width, rect.size.height+150);
        });
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        NSLog(@"%@",error);
    }];

}
- (void)requestData{
    
    WEAKSELF;
    
    self.manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/plain", nil];
    [self.manager GET:COMMENTREPLYURL(self.topicID, self.sort) parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
//        NSLog(@"%@",task.currentRequest.URL);

        weakSelf.dataArr2 = [NewTeaModel mj_objectArrayWithKeyValuesArray:responseObject[@"data"]];
        dispatch_async(dispatch_get_main_queue(), ^{
            [weakSelf.tableView reloadData];
        });
//        [weakSelf.tableView reloadData];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        NSLog(@"%@",error);
    }];
    
    
}

- (void)setUpTableVIew{
    
    
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tableView.showsVerticalScrollIndicator = NO;
    
    
    
    //设置header 设置整体的header会随cell滑动
    self.FUview = [[[NSBundle mainBundle] loadNibNamed:@"FuJianView" owner:self options:nil]objectAtIndex:1];
    
    

    self.FUview.AllCommentButton.selected = YES;
    
    [self.FUview.AllCommentButton addTarget:self action:@selector(allCommentClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.FUview.HotCommentButton addTarget:self action:@selector(hotCommentClick:) forControlEvents:UIControlEventTouchUpInside];
    
    _tableView.tableHeaderView = self.FUview;
    
    
    
    
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSString*conText = [self.dataArr2[indexPath.row] content];
    NSDictionary * dic = [NSDictionary setTextLineSpaceWithString:conText withFont:14 withLineSpace:15  withTextlengthSpace:@0.8 paragraphSpacing:0];
    
    CGRect rect = [[self.dataArr2[indexPath.row] content] boundingRectWithSize:CGSizeMake(230, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingTruncatesLastVisibleLine|NSStringDrawingUsesFontLeading attributes:dic context:nil];
    if ([self.dataArr2[indexPath.row] img] != NULL) {
        return rect.size.height+140+260;
    }
    return rect.size.height+140;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return _dataArr2.count;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
        CommentTableViewCell * cell = [CommentTableViewCell tempTableViewCellWith:tableView indexPath:0];
        cell.model = _dataArr2[indexPath.row];
    
        self.themeLable.text = self.model.Title;
    
        return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
}

/*
 *全部评论与热门评论按钮的任务
 */
- (void)allCommentClick:(UIButton *)button{
    _sort=2;
    [self requestData];
}
- (void)hotCommentClick:(UIButton *)button{
    _sort = 1;
    [self requestData];
}
/*
 *设置TextField左右view
 */
- (void)setTextField{
    UIButton * leftButton = [UIButton buttonWithType:UIButtonTypeCustom];
    leftButton.frame = CGRectMake(30, 15, 30, 30);
    [leftButton setImage:[UIImage imageNamed:@"getPic.png"] forState:UIControlStateNormal];
    [leftButton addTarget:self action:@selector(aaa) forControlEvents:UIControlEventTouchUpInside];
    self.textField.leftView = leftButton;
    self.textField.leftViewMode = UITextFieldViewModeAlways;
    
    self.textField.layer.borderColor = [UIColor lightGrayColor].CGColor;
    self.textField.layer.borderWidth= 1.0f;
    self.textField.layer.cornerRadius = 8.0;
    self.textField.borderStyle = UITextBorderStyleRoundedRect;
    self.textField.delegate = self;
    
    UIButton * rightButton = [UIButton buttonWithType:UIButtonTypeCustom];
    rightButton.frame = CGRectMake(0, 0, 50, 30);
    [rightButton setTitle:@"发布" forState:UIControlStateNormal];
    [rightButton setTitleColor:[UIColor brownColor] forState:UIControlStateNormal];
    [rightButton addTarget:self action:@selector(aaa) forControlEvents:UIControlEventTouchUpInside];
    self.textField.rightView = rightButton;
    self.textField.rightViewMode = UITextFieldViewModeAlways;
}
/*
 *返回
 */
- (IBAction)backClick:(UIButton *)sender {
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
}
/*
 *textfield方法
 */
- (void)aaa{
    NSLog(@"sdfsfdsf");
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
}
@end
