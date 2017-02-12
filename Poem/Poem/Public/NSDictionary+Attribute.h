//
//  NSDictionary+Attribute.h
//  Poem
//
//  Created by wyzc on 16/12/15.
//  Copyright © 2016年 wyzc. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDictionary (Attribute)

+ (instancetype)setTextLineSpaceWithString:(NSString*)str withFont:(CGFloat)font withLineSpace:(CGFloat)lineSpace withTextlengthSpace:(NSNumber *)textlengthSpace paragraphSpacing:(CGFloat)paragraphSpacing;

@end
