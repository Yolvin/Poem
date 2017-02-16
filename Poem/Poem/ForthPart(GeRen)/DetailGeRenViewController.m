//
//  DetailGeRenViewController.m
//  Poem
//
//  Created by Kevin on 17/2/16.
//  Copyright © 2017年 wyzc. All rights reserved.
//

#import "DetailGeRenViewController.h"
#import "YiZhanViewController.h"

@interface DetailGeRenViewController ()<UIScrollViewDelegate>


@property (weak, nonatomic) IBOutlet UIView *baView;
@property (weak, nonatomic) IBOutlet UIView *topView;
@property(nonatomic,strong)UIScrollView * scrollView;
@property(nonatomic,strong)NSMutableArray * titleButtonsArr;

@property (nonatomic, strong) UIView *titleBottomView;

@property (nonatomic, strong) UIButton *selectedTitleButton;

@end

@implementation DetailGeRenViewController

- (NSMutableArray *)titleButtonsArr{
    if (!_titleButtonsArr) {
        _titleButtonsArr = [NSMutableArray array];
    }
    return _titleButtonsArr;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setUpButton];
    [self setUpScrollView];
    // Do any additional setup after loading the view from its nib.
}
- (void)setUpScrollView{
    
    _scrollView = [[UIScrollView alloc] init];
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    _scrollView.showsHorizontalScrollIndicator = NO;
    _scrollView.pagingEnabled = YES;
    _scrollView.delegate = self;
    
    _scrollView.contentSize = CGSizeMake(self.baView.width*3, 0);
    [self.baView addSubview:_scrollView];
    
    
    
    [_scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(_baView.mas_top);
        make.left.mas_equalTo(_baView.mas_left);
        make.width.mas_equalTo(_baView.mas_width);
        make.height.mas_equalTo(_baView.mas_height);
        
    }];
    
    
    YiZhanViewController * view = [[YiZhanViewController alloc]init];
    view.view.frame = CGRectMake(0, 0, _baView.width, _baView.height);
    view.view.centerX = _baView.centerX;
    [self addChildViewController:view];
    [_scrollView addSubview:view.view];
//
//    QingChaView * qingView = [[QingChaView alloc]initWithFrame:CGRectMake(_baView.width, 0, _baView.width, _baView.height)];
//    
//    [_scrollView addSubview:qingView];
//    
//    MiZhiYinView * miZhiYinView = [[[NSBundle mainBundle] loadNibNamed:@"MiZhiYinView" owner:self options:nil]lastObject];
//    //????
//    miZhiYinView.frame = CGRectMake(_baView.width*2, 0, 0, _baView.height);
//    [_scrollView addSubview:miZhiYinView];
    
    
    
    
}
- (void)setUpButton{
    
    NSArray * arr = @[@"TA关注的",@"TA创建的",@"TA发布的"];
    for (int i = 0; i < arr.count; i ++) {
        
        UIButton * button = [UIButton buttonWithType:UIButtonTypeCustom];
        
        [button setTitle:arr[i] forState:UIControlStateNormal];
        
        [button setFont:[UIFont systemFontOfSize:15]];
        
        [button setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        [button setTitleColor:[UIColor blackColor] forState:UIControlStateSelected];
        
        CGFloat buttonW = self.view.width/arr.count;
        CGFloat buttonH = self.topView.height;
        button.frame = CGRectMake(buttonW*i, 0, buttonW, buttonH);
        button.tag = 210+i;
        
        [button addTarget:self action:@selector(titleClick:) forControlEvents:UIControlEventTouchUpInside];
        [self.topView addSubview:button];
        [self.titleButtonsArr addObject:button];
        
        
    }
    
    UIView *titleBottomView = [[UIView alloc] init];
    titleBottomView.backgroundColor = [UIColor colorWithRed:220/255.0 green:181/255.0 blue:98/255.0 alpha:1.0];
    titleBottomView.height = 3;
    titleBottomView.y = _topView.height - titleBottomView.height;
    [self.topView addSubview:titleBottomView];
    _titleBottomView = titleBottomView;
    
    
    UIButton *firstTitleButton = self.titleButtonsArr.firstObject;
    [firstTitleButton.titleLabel sizeToFit];
    
    [self titleClick:firstTitleButton];
    
}

//
- (void)titleClick:(UIButton *)titleButton{
    // 控制按钮状态
    self.selectedTitleButton.selected = NO;
    titleButton.selected = YES;
    self.selectedTitleButton = titleButton;//
    
    
    //添加红色线view动画
    [UIView animateWithDuration:0.05 animations:^{
        self.titleBottomView.width = titleButton.titleLabel.width+35;
        self.titleBottomView.centerX = self.selectedTitleButton.centerX;
    }];
    
    NSInteger index = titleButton.tag-210;
    
    _scrollView.contentOffset = CGPointMake(_scrollView.width*index, 0);
    
    
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    
    
    int index = scrollView.contentOffset.x/_scrollView.width;
    [self titleClick:_titleButtonsArr[index]];
    
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
