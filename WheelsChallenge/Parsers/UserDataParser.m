//
//  UserDataParser.m
//  WheelsChallenge
//
//  Created by Wergley, Brad on 9/6/19.
//  Copyright © 2019 Brad Wergley. All rights reserved.
//

#import "UserDataParser.h"

#import "ParsingHelper.h"
#import "WheelsChallenge-Swift.h"

@implementation UserDataParser

- (NSArray <User *> *)parseUserListWithResponseObject:(id)responseObject
{
    NSMutableArray *users = [NSMutableArray new];
    
    if ([responseObject isKindOfClass:[NSDictionary class]])
    {
        NSArray *usersArray = (NSArray *)((NSDictionary *)responseObject)[@"items"];
        if ([usersArray isKindOfClass:[NSArray class]])
        {
            for (NSDictionary *userDict in usersArray)
            {
                if ([userDict isKindOfClass:[NSDictionary class]])
                {
                    User *user = [self parseUserWithDictionary:userDict];
                    if ([user isKindOfClass:[User class]])
                    {
                        [users addObject:user];
                    }
                }
            }
        }
    }
    
    return users;
}

- (User *)parseUserWithDictionary:(NSDictionary *)dictionary
{
    User *user = [User new];
    
    user.displayName = [ParsingHelper convertString:dictionary[@"display_name"] defaultString:@""];
    user.profileImageUrlString = [ParsingHelper convertString:dictionary[@"profile_image"] defaultString:@""];
    user.reputation = [ParsingHelper convertInteger:dictionary[@"reputation"] defaultInteger:0];
    
    NSDictionary *badgeCountDict = dictionary[@"badge_counts"];
    if ([badgeCountDict isKindOfClass:[NSDictionary class]])
    {
        user.goldBadgeCount = [ParsingHelper convertInteger:badgeCountDict[@"gold"] defaultInteger:0];
        user.silverBadgeCount = [ParsingHelper convertInteger:badgeCountDict[@"silver"] defaultInteger:0];
        user.bronzeBadgeCount = [ParsingHelper convertInteger:badgeCountDict[@"bronze"] defaultInteger:0];
    }
    
    return user;
}

@end
