//
//  BadgeCountView.m
//  WheelsChallenge
//
//  Created by Wergley, Brad on 9/6/19.
//  Copyright © 2019 Brad Wergley. All rights reserved.
//

#import "BadgeCountView.h"

@interface BadgeCountView()

@property (nonatomic, strong) UIView *badgeView;
@property (nonatomic, strong) UILabel *countLabel;

@end

@implementation BadgeCountView

- (void) awakeFromNib
{
    [super awakeFromNib];
    
    CGFloat badgeRadius = 8.0;
    self.badgeView = [[UIView alloc] initWithFrame:CGRectZero];
    [self addSubview:self.badgeView];
    [self.badgeView setBackgroundColor:[UIColor blueColor]];
    [self.badgeView.layer setCornerRadius:badgeRadius];
    self.badgeView.translatesAutoresizingMaskIntoConstraints = NO;
    [self.badgeView.leftAnchor constraintEqualToAnchor:self.leftAnchor].active = YES;
    [self.badgeView.topAnchor constraintEqualToAnchor:self.topAnchor].active = YES;
    [self.badgeView.bottomAnchor constraintEqualToAnchor:self.bottomAnchor].active = YES;
    [self.badgeView.widthAnchor constraintEqualToConstant:badgeRadius*2].active = YES;
    [self.badgeView.heightAnchor constraintEqualToConstant:badgeRadius*2].active = YES;
    
    self.countLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    [self addSubview:self.countLabel];
    self.countLabel.translatesAutoresizingMaskIntoConstraints = NO;
    [self.countLabel.leftAnchor constraintEqualToAnchor:self.badgeView.rightAnchor constant:3].active = YES;
    [self.countLabel.topAnchor constraintEqualToAnchor:self.topAnchor].active = YES;
    [self.countLabel.bottomAnchor constraintEqualToAnchor:self.bottomAnchor].active = YES;
    [self.countLabel.rightAnchor constraintEqualToAnchor:self.rightAnchor].active = YES;
}

- (void) setBadgeCount:(NSInteger)count withColor:(UIColor *)color
{
    self.countLabel.text = [NSString stringWithFormat:@"%i", (int)count];
    self.badgeView.backgroundColor = color;
}

@end
