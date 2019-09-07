//
//  ImageManager.h
//  WheelsChallenge
//
//  Created by Wergley, Brad on 9/6/19.
//  Copyright © 2019 Brad Wergley. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@class User;
@interface ImageManager : NSObject

+ (nullable ImageManager *) sharedInstance;

- (void) beginGetImageWithUrlString:(NSString *_Nullable)urlString completion:(void (^_Nullable)(UIImage *_Nullable))completionBlock;

@end
