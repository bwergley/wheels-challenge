//
//  UserTableViewCell.swift
//  WheelsChallenge
//
//  Created by Wergley, Brad on 9/6/19.
//  Copyright © 2019 Brad Wergley. All rights reserved.
//

import UIKit

class UserTableViewCell: UITableViewCell {
    
    @IBOutlet weak var profileImageView: UIImageView?
    @IBOutlet weak var displayNameLabel: UILabel?
    @IBOutlet weak var reputationLabel: UILabel?
    @IBOutlet weak var goldBadgeCountView: BadgeCountView?
    @IBOutlet weak var silverBadgeCountView: BadgeCountView?
    @IBOutlet weak var bronzeBadgeCountView: BadgeCountView?

    override func awakeFromNib() {
        super.awakeFromNib()
    }
}
