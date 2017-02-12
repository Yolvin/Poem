//
//  FirstViewController.m
//  Poem
//
//  Created by wyzc on 16/12/13.
//  Copyright © 2016年 wyzc. All rights reserved.
//

#import "FirstViewController.h"
#import "TeaBarViewController.h"

@interface FirstViewController ()<UIScrollViewDelegate>
@property(nonatomic,strong)UIScrollView * scrollView;
@end

@implementation FirstViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    _scrollView = [[UIScrollView alloc]initWithFrame:[UIScreen mainScreen].bounds];
    
    _scrollView.contentSize = CGSizeMake(self.view.width*4, self.view.height);
    
    _scrollView.pagingEnabled = YES;
    
    _scrollView.delegate = self;
    
    _scrollView.showsHorizontalScrollIndicator = NO;
    
    for (int i = 0; i < 4; i ++) {
        UIImageView * imageView = [[UIImageView alloc]initWithFrame:CGRectMake(self.view.width*i, 0, self.view.width, self.view.height)];
        
        [imageView setImage:[UIImage imageNamed:[NSString stringWithFormat:@"yindaoye_ip4_%d",i+1]]];
        
        if (i == 3) {
            [self addButtonAtImageview:imageView];
        }
        
        [_scrollView addSubview:imageView];
    }
    
    [self.view addSubview:_scrollView];
    
    
    // Do any additional setup after loading the view.
}
- (void)addButtonAtImageview:(UIImageView *)imageView{
    
    imageView.userInteractionEnabled = YES;
    
    UIButton * button = [UIButton buttonWithType:UIButtonTypeCustom];
    
    [button setImage:[UIImage imageNamed:@"guide_skip"] forState:UIControlStateNormal];
    
    [button addTarget:self action:@selector(changeRootViewController:) forControlEvents:UIControlEventTouchUpInside];
    
    [imageView addSubview:button];
    
    [button mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(imageView.mas_centerX).offset(5);
        make.bottom.mas_equalTo(imageView.mas_bottom).offset(-90);
        make.size.mas_equalTo(CGSizeMake(140, 40));
        
    }];

   
}

- (void)changeRootViewController:(id)sender{
    
    UIWindow * keywindow = [UIApplication sharedApplication].keyWindow;
    
    keywindow.rootViewController  = [[TeaBarViewController alloc]init];
    
    NSString * nowVersion = [[[NSBundle mainBundle] infoDictionary] objectForKey:(NSString *)kCFBundleVersionKey];
    
    NSUserDefaults * defaul = [NSUserDefaults standardUserDefaults];
    [defaul setValue:nowVersion forKey:@"APP_VERSION"];
    
    [defaul synchronize];
    
    
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
