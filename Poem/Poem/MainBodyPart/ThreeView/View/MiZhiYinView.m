//
//  MiZhiYinView.m
//  Poem
//
//  Created by wyzc on 16/12/19.
//  Copyright © 2016年 wyzc. All rights reserved.
//

#import "MiZhiYinView.h"
#import "QingChaView.h"
#import "LiaoTiaoView.h"
#import "XiaoSheView.h"

@interface MiZhiYinView()<UIScrollViewDelegate>

@property(nonatomic,strong)UIScrollView * scrollView;
@property (weak, nonatomic) IBOutlet UISegmentedControl *segment;

@end

@implementation MiZhiYinView
- (void)awakeFromNib
{
    [super awakeFromNib];
    [self setUpScrollView];
    
}
- (instancetype)initWithFrame:(CGRect)frame{
    
    self = [super initWithFrame:frame];
    if (self) {
    }
    return self;
}

- (void)setUpScrollView{
    
    [_segment addTarget:self action:@selector(itemClick)forControlEvents:UIControlEventValueChanged];
    
    _scrollView = [[UIScrollView alloc] init];
    
    _scrollView.showsHorizontalScrollIndicator = NO;
    _scrollView.pagingEnabled = YES;
    _scrollView.delegate = self;
    
    _scrollView.contentSize = CGSizeMake(self.width*2, 0);
    [self addSubview:_scrollView];
    
    
    
    [_scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.segment.mas_bottom).offset(10);
        make.left.mas_equalTo(self.mas_left);
        make.width.mas_equalTo(self.mas_width);
        make.height.mas_equalTo(self.mas_height);
        
    }];
//
    LiaoTiaoView * view = [[LiaoTiaoView alloc]initWithFrame:CGRectMake(0, 0, self.width, self.height-80)];
//    view.centerX = self.centerX;
    [_scrollView addSubview:view];

    
     XiaoSheView * qingView = [[XiaoSheView alloc]initWithFrame:CGRectMake(self.width, 0, self.width, self.height-80)];
    [_scrollView addSubview:qingView];
    
}

- (void)itemClick{
    
    _scrollView.contentOffset = CGPointMake(self.width*_segment.selectedSegmentIndex, 0);
    
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    
    
    int index = scrollView.contentOffset.x/_scrollView.width;
    [_segment setSelectedSegmentIndex:index];
    
    
}
@end
