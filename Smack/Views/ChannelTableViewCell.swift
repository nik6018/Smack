//
//  ChannelTableViewCell.swift
//  Smack
//
//  Created by Nikhil Muskur on 30/09/18.
//  Copyright © 2018 Nikhil Muskur. All rights reserved.
//

import UIKit

class ChannelTableViewCell: UITableViewCell {

	
	@IBOutlet weak var channelTitle: UILabel!
	
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
		if selected {
			layer.backgroundColor = UIColor(white: 1, alpha: 0.2).cgColor
		} else {
			layer.backgroundColor = UIColor.clear.cgColor
		}
    }
	
	func configureCell(withChannel channel: Channel) {
		channelTitle.text = "#\(channel.name)"
	}

}
