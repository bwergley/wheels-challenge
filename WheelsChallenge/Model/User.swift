//
//  User.swift
//  WheelsChallenge
//
//  Created by Wergley, Brad on 9/6/19.
//  Copyright © 2019 Brad Wergley. All rights reserved.
//

import UIKit

@objc class User: NSObject {

    @objc public var displayName: String?
    @objc public var profileImageUrlString: String?
    @objc public var reputation: NSInteger = 0
    @objc public var goldBadgeCount: NSInteger = 0
    @objc public var silverBadgeCount: NSInteger = 0
    @objc public var bronzeBadgeCount: NSInteger = 0
    
    override init() {
        super.init()
    }

}
