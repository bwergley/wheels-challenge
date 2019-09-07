//
//  ParsingHelper.h
//  WheelsChallenge
//
//  Created by Wergley, Brad on 9/6/19.
//  Copyright © 2019 Brad Wergley. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ParsingHelper : NSObject

+ (NSInteger) convertInteger:(id)object defaultInteger:(NSInteger)defaultInteger;
+ (NSString *) convertString:(id)object defaultString:(NSString *)defaultString;

@end
