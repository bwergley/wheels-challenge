//
//  UserManager.m
//  WheelsChallenge
//
//  Created by Wergley, Brad on 9/6/19.
//  Copyright © 2019 Brad Wergley. All rights reserved.
//

#import "UserManager.h"

#import <AFNetworking.h>
#import "UserDataParser.h"
#import "WheelsChallenge-Swift.h"

@implementation UserManager

NSString *userListEndpointUrlString = @"https://api.stackexchange.com/2.2/users?site=stackoverflow&page=1";

+ (UserManager *) sharedInstance {
    static dispatch_once_t once;
    static id sharedInstance;
    dispatch_once(&once, ^{
        sharedInstance = [self new];
    });
    return sharedInstance;
}

- (void) beginGetUserListWithCompletion:(void (^)(NSArray<User *> *))completionBlock {
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    [manager GET:userListEndpointUrlString parameters:nil progress:nil success:^(NSURLSessionTask *task, id responseObject) {
        NSLog(@"JSON: %@", responseObject);
        
        UserDataParser *parser = [UserDataParser new];
        NSArray *users = [parser parseUserListWithResponseObject:responseObject];
        completionBlock(users);
        
    } failure:^(NSURLSessionTask *operation, NSError *error) {
        NSLog(@"Error: %@", error);
        
        completionBlock(nil);
    }];
}

@end
