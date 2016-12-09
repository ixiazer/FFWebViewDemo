//
//  NSString+FF.m
//  Categary
//
//  Created by xiazer on 15/5/11.
//  Copyright (c) 2015年 xiazer. All rights reserved.
//

#import "NSString+FF.h"

@implementation NSString (FF)
+ (NSString *) jsonStringWithString:(NSString *) string {
    return [NSString stringWithFormat:@"\"%@\"",
            [[[string stringByReplacingOccurrencesOfString:@"\n" withString:@"\\n"] stringByReplacingOccurrencesOfString:@"\"" withString:@"\\\""] stringByReplacingOccurrencesOfString:@"\t" withString:@"\\t"]
            ];
}

+ (NSString *)jsonStringWithNumber:(NSNumber *)num {
    return [NSString stringWithFormat:@"%ld",(long)[num integerValue]];
}

+ (NSString *) jsonStringWithArray:(NSArray *)array {
    NSMutableString *reString = [NSMutableString string];
    [reString appendString:@"["];
    NSMutableArray *values = [NSMutableArray array];
    for (id valueObj in array) {
        NSString *value = [NSString jsonStringWithObject:valueObj];
        if (value) {
            [values addObject:[NSString stringWithFormat:@"%@",value]];
        }
    }
    [reString appendFormat:@"%@",[values componentsJoinedByString:@","]];
    [reString appendString:@"]"];
    return reString;
}

+ (NSString *)jsonStringWithDictionary:(NSDictionary *)dictionary {
    NSArray *keys = [dictionary allKeys];
    NSMutableString *reString = [NSMutableString string];
    [reString appendString:@"{"];
    NSMutableArray *keyValues = [NSMutableArray array];
    for (int i=0; i<[keys count]; i++) {
        NSString *name = [keys objectAtIndex:i];
        id valueObj = [dictionary objectForKey:name];
        NSString *value = [NSString jsonStringWithObject:valueObj];
        if (value) {
            [keyValues addObject:[NSString stringWithFormat:@"\"%@\":%@",name,value]];
        }
    }
    [reString appendFormat:@"%@",[keyValues componentsJoinedByString:@","]];
    [reString appendString:@"}"];
    return reString;
}

+ (NSString *) jsonStringWithObject:(id) object {
    NSString *value = nil;
    if (!object) {
        return value;
    }
    if ([object isKindOfClass:[NSString class]]) {
        value = [NSString jsonStringWithString:object];
    }else if([object isKindOfClass:[NSDictionary class]]){
        value = [NSString jsonStringWithDictionary:object];
    }else if([object isKindOfClass:[NSArray class]]){
        value = [NSString jsonStringWithArray:object];
    }else if ([object isKindOfClass:[NSNumber class]]) {
        if (object == [NSNumber numberWithBool:YES]) {
            return @"true";
        } else if (object == [NSNumber numberWithBool:NO]) {
            return @"fault";
        } else {
            return [NSString stringWithFormat:@"%ld",(long)[object integerValue]];
        }
    }
    
    return value;
}

@end
