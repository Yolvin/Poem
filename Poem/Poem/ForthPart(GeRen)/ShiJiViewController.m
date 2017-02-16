//
//  ShiJiViewController.m
//  Poem
//
//  Created by Kevin on 17/2/16.
//  Copyright © 2017年 wyzc. All rights reserved.
//

#import "ShiJiViewController.h"
#import "CollectionViewCell.h"

@interface ShiJiViewController ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>
@property (weak, nonatomic) IBOutlet UILabel *themeLable;


@end
static NSString * const cellReuse = @"collecbb";

@implementation ShiJiViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    UICollectionViewFlowLayout * flowLayout = [[UICollectionViewFlowLayout alloc]init];
    
    //设置item的尺寸
    flowLayout.itemSize = CGSizeMake(100, 300);
    //最小行间距
    flowLayout.minimumLineSpacing = 40;
    //item的间距
    flowLayout.minimumInteritemSpacing = 10;
    //距离上左下右的距离
    flowLayout.sectionInset = UIEdgeInsetsMake(30, 20, 30, 20);
    //    //滚动方向
    flowLayout.scrollDirection = UICollectionViewScrollDirectionVertical;
    //    //头尾的尺寸
    flowLayout.headerReferenceSize = CGSizeMake(100, 100);
    flowLayout.footerReferenceSize = CGSizeMake(100, 100);
    //头尾悬浮方向 和滚动方向要匹配
    flowLayout.sectionHeadersPinToVisibleBounds = YES;
    flowLayout.sectionFootersPinToVisibleBounds = NO;
    
    
    
    UICollectionView * collectionView = [[UICollectionView alloc]initWithFrame:[UIScreen mainScreen].bounds collectionViewLayout:flowLayout];
    
    collectionView.delegate = self;
    collectionView.dataSource = self;
//    [collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:cellReuse];
    
    [collectionView registerNib:[[[NSBundle mainBundle] loadNibNamed:@"CollectionViewCell" owner:self options:nil] firstObject] forCellWithReuseIdentifier:cellReuse];
    [self.view addSubview:collectionView];
//    self.collectionView.layoutMargins
    // Do any additional setup after loading the view from its nib.
}
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}
//每个section中item的个数
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return 50;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
   //    [collectionView registerNib:[[[NSBundle mainBundle] loadNibNamed:@"CollectionViewCell" owner:self options:nil] firstObject] forCellWithReuseIdentifier:cellReuse];
//    
    CollectionViewCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellReuse forIndexPath:indexPath];
    cell.backgroundColor = [UIColor greenColor];
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
