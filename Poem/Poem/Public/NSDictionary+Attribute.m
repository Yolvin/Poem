//
//  NSDictionary+Attribute.m
//  Poem
//
//  Created by wyzc on 16/12/15.
//  Copyright © 2016年 wyzc. All rights reserved.
//

#import "NSDictionary+Attribute.h"

@implementation NSDictionary (Attribute)
//lineSpace 行间距  paragraphSpacing 段间距 textLengthSpace 字间距
+ (instancetype)setTextLineSpaceWithString:(NSString*)str withFont:(CGFloat)font withLineSpace:(CGFloat)lineSpace withTextlengthSpace:(NSNumber *)textlengthSpace paragraphSpacing:(CGFloat)paragraphSpacing{
    
    
    
    NSMutableParagraphStyle *paraStyle = [[NSMutableParagraphStyle alloc] init];
    
    paraStyle.lineBreakMode = NSLineBreakByCharWrapping;
    
    paraStyle.alignment = NSTextAlignmentLeft;
    
    paraStyle.lineSpacing = lineSpace; //设置行间距
    
    paraStyle.hyphenationFactor = 1.0;
    
    paraStyle.firstLineHeadIndent = 0.0;
    
    paraStyle.paragraphSpacingBefore = 0.0;
    
    paraStyle.headIndent = 0;
    
    paraStyle.tailIndent = 0;
    
    
    NSDictionary *dic = @{NSFontAttributeName:[UIFont systemFontOfSize:font],
                          
                          NSParagraphStyleAttributeName:paraStyle,
                          
                          NSKernAttributeName:textlengthSpace
                          
                          };
    return dic;
   
    
}

@end
