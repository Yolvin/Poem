//
//  GeRenViewController.m
//  Poem
//
//  Created by wyzc on 17/1/12.
//  Copyright © 2017年 wyzc. All rights reserved.
//

#import "GeRenViewController.h"

@interface GeRenViewController ()

@end

@implementation GeRenViewController

- (void)viewDidLoad {
    [super viewDidLoad];
//    UINavigationController * nav = [[UINavigationController alloc]initWithRootViewController:self];
    self.title=@"uuuu";
//    [nav makeke]
    NSLog(@"%@",_userID);
    // Do any additional setup after loading the view from its nib.
}
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
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
