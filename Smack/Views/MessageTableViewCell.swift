//
//  MessageTableViewCell.swift
//  Smack
//
//  Created by Nikhil Muskur on 02/10/18.
//  Copyright © 2018 Nikhil Muskur. All rights reserved.
//

import UIKit

class MessageTableViewCell: UITableViewCell {

	
	@IBOutlet weak var profileImageView: UIImageView!
	@IBOutlet weak var usernameLabel: UILabel!
	@IBOutlet weak var timeStampLabel: UILabel!
	@IBOutlet weak var messageBodyLabel: UILabel!
	
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
	
	func configureCell(withMessage message: Message) {
		profileImageView.image = UIImage(named: message.userAvatarName)
		profileImageView.backgroundColor = UserDataService.instance.getUIColorForString(components: message.userAvatarColor)
		usernameLabel.text = message.userName
		messageBodyLabel.text = message.message
		timeStampLabel.text = "9:41 AM"
	}
	
}
