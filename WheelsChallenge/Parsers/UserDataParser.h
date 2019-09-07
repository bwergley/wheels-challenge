//
//  UserDataParser.h
//  WheelsChallenge
//
//  Created by Wergley, Brad on 9/6/19.
//  Copyright © 2019 Brad Wergley. All rights reserved.
//

#import <Foundation/Foundation.h>

@class User;
@interface UserDataParser : NSObject

- (nullable NSArray <User *> *)parseUserListWithResponseObject:(id _Nullable)responseObject;

- (nullable User *)parseUserWithDictionary:(nullable NSDictionary *)dictionary;


@end
