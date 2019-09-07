//
//  ParsingHelper.m
//  WheelsChallenge
//
//  Created by Wergley, Brad on 9/6/19.
//  Copyright © 2019 Brad Wergley. All rights reserved.
//

#import "ParsingHelper.h"

@implementation ParsingHelper

+ (NSInteger) convertInteger:(id)object defaultInteger:(NSInteger)defaultInteger {
    if ([object isKindOfClass:[NSNumber class]]) {
        return [object integerValue];
    }
    else {
        return defaultInteger;
    }
}

+ (NSString *) convertString:(id)object defaultString:(NSString *)defaultString {
    if ([object isKindOfClass:[NSString class]]) {
        return object;
    }
    else {
        return defaultString;
    }
}

@end
