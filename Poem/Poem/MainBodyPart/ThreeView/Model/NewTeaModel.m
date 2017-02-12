//
//  NewTeaModel.m
//  Poem
//
//  Created by wyzc on 16/12/15.
//  Copyright © 2016年 wyzc. All rights reserved.
//

#import "NewTeaModel.h"

@implementation NewTeaModel
+ (void)load{
    
    [NewTeaModel mj_setupReplacedKeyFromPropertyName:^NSDictionary *{
        return @{@"data_description":@"description",
                 @"Title":@"title"};
        
    }];
    
}

- (void)setValue:(id)value forUndefinedKey:(NSString *)key{
    
    
}
@end
