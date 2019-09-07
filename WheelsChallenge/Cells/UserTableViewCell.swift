//
//  UserTableViewCell.swift
//  WheelsChallenge
//
//  Created by Wergley, Brad on 9/6/19.
//  Copyright © 2019 Brad Wergley. All rights reserved.
//

import UIKit

class UserTableViewCell: UITableViewCell {
    
    @objc public var user: User? {
        didSet {
            self.update(with: user)
        }
    }
    
    @IBOutlet weak var profileImageView: UIImageView?
    @IBOutlet weak var displayNameLabel: UILabel?
    @IBOutlet weak var reputationLabel: UILabel?
    @IBOutlet weak var goldBadgeCountView: BadgeCountView?
    @IBOutlet weak var silverBadgeCountView: BadgeCountView?
    @IBOutlet weak var bronzeBadgeCountView: BadgeCountView?
    
    @objc static func cellId() -> String? {
        return "UserTableViewCellId"
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    private func update(with user: User?) {
        if let user = user
        {
            self.displayNameLabel?.text = user.displayName
            self.reputationLabel?.text = "\(user.reputation)"
            self.goldBadgeCountView?.setBadgeCount(user.goldBadgeCount, with: UIColor.goldBadge())
            self.silverBadgeCountView?.setBadgeCount(user.silverBadgeCount, with: UIColor.silverBadge())
            self.bronzeBadgeCountView?.setBadgeCount(user.bronzeBadgeCount, with: UIColor.bronzeBadge())
            
            if let imageUrlString = user.profileImageUrlString,
                let imageUrl = URL(string: imageUrlString) {
                
                let downloader = AFImageDownloader.defaultInstance()
                let request = NSURLRequest(url: imageUrl)
                downloader.downloadImage(for: request as URLRequest, success: { (request, response, image) in
                    DispatchQueue.main.async { [weak self] in
                        if self?.user?.profileImageUrlString == imageUrlString {
                            self?.profileImageView?.image = image
                        }
                    }
                }) { (request, response, error) in
                    
                }
            }
        }
    }
}
