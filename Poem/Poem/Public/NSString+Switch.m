//
//  NSString+Switch.m
//  Poem
//
//  Created by wyzc on 16/12/22.
//  Copyright © 2016年 wyzc. All rights reserved.
//

#import "NSString+Switch.h"
#import "NSDate+Time.h"

@implementation NSString (Switch)

+ (NSString *)timeWithTimeIntervalString:(NSString *)timeString
{
    // 格式化时间
    NSDateFormatter* formatter = [[NSDateFormatter alloc] init];
    formatter.timeZone = [NSTimeZone timeZoneWithName:@"shanghai"];
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    [formatter setTimeStyle:NSDateFormatterShortStyle];
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm"];
    
    // 毫秒值转化为秒
    NSDate* date = [NSDate dateWithTimeIntervalSince1970:[timeString doubleValue]/ 1000.0];
    NSString* dateString = [formatter stringFromDate:date];
    return dateString;
}

+ (NSString *)timeWithTimeIntervalStringFromNow:(NSString *)String{
    
    NSString * str = [NSString timeWithTimeIntervalString:String];
    
    NSDateFormatter *fmt = [[NSDateFormatter alloc] init];
    fmt.dateFormat = @"yyyy-MM-dd HH:mm:ss";
    
    // NSString -> NSDate
    NSDate * createdAtDate = [fmt dateFromString:str];
    
    // 比较【发帖时间】和【手机当前时间】的差值
    NSDateComponents *cmps = [createdAtDate intervalToNow];
    
    if (createdAtDate.isThisYear) {
        if (createdAtDate.isToday) { // 今天
            if (cmps.hour >= 1) { // 时间差距 >= 1小时
                return [NSString stringWithFormat:@"%zd小时前", cmps.hour];
            } else if (cmps.minute >= 1) { // 1分钟 =< 时间差距 <= 59分钟
                return [NSString stringWithFormat:@"%zd分钟前", cmps.minute];
            } else {
                return @"刚刚";
            }
        } else if (createdAtDate.isYesterday) { // 昨天
            fmt.dateFormat = @"昨天 HH:mm:ss";
            return [fmt stringFromDate:createdAtDate];
        } else { // 今年的其他时间
            fmt.dateFormat = @"MM-dd HH:mm:ss";
            return [fmt stringFromDate:createdAtDate];
        }
    } else { // 非今年
        return str;
    }

}
@end
