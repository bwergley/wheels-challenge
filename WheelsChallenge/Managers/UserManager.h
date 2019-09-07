//
//  UserManager.h
//  WheelsChallenge
//
//  Created by Wergley, Brad on 9/6/19.
//  Copyright © 2019 Brad Wergley. All rights reserved.
//

#import <Foundation/Foundation.h>

@class User;
@interface UserManager : NSObject

+ (nullable UserManager *) sharedInstance;

- (void) beginGetUserListWithCompletion:(void (^_Nullable)(NSArray<User *> *_Nullable))completionBlock;

@end
