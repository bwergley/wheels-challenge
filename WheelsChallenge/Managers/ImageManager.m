//
//  ImageManager.m
//  WheelsChallenge
//
//  Created by Wergley, Brad on 9/6/19.
//  Copyright © 2019 Brad Wergley. All rights reserved.
//

#import "ImageManager.h"

#import <AFNetworking/AFImageDownloader.h>

@implementation ImageManager

+ (ImageManager *) sharedInstance {
    static dispatch_once_t once;
    static id sharedInstance;
    dispatch_once(&once, ^{
        sharedInstance = [self new];
    });
    return sharedInstance;
}

- (void) beginGetImageWithUrlString:(NSString *)urlString completion:(void (^)(UIImage * _Nullable))completionBlock {
    NSURL *imageUrl = [NSURL URLWithString:urlString];
    AFImageDownloader *downloader = [AFImageDownloader defaultInstance];
    NSURLRequest *request = [NSURLRequest requestWithURL:imageUrl];
    [downloader downloadImageForURLRequest:request success:^(NSURLRequest * _Nonnull request, NSHTTPURLResponse * _Nullable response, UIImage * _Nonnull responseObject) {
        completionBlock(responseObject);
    } failure:^(NSURLRequest * _Nonnull request, NSHTTPURLResponse * _Nullable response, NSError * _Nonnull error) {
        completionBlock(nil);
    }];
}

@end
