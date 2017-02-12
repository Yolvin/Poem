//
//  NSString+Switch.h
//  Poem
//
//  Created by wyzc on 16/12/22.
//  Copyright © 2016年 wyzc. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (Switch)
+ (NSString *)timeWithTimeIntervalString:(NSString *)timeString;
+ (NSString *)timeWithTimeIntervalStringFromNow:(NSString *)String;
@end
