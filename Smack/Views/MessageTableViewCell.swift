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
		
		let isoDate = message.timeStamp
		let end = isoDate.index(isoDate.endIndex, offsetBy: -5)
		let formmatedISODate = String(isoDate[isoDate.startIndex..<end])
		print(formmatedISODate)
		
		let isoFormater = ISO8601DateFormatter()
		let chatDate = isoFormater.date(from: formmatedISODate.appending("Z"))
		
		let formatter = DateFormatter()
		formatter.dateFormat = "MMM d, h:mm a"
		
		if let cleanDate = chatDate {
			let finalDate = formatter.string(from: cleanDate)
			timeStampLabel.text = finalDate
		} else {
			timeStampLabel.text = "9:41 AM"
		}
	}
	
}
