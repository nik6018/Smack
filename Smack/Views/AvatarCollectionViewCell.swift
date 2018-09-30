//
//  AvatarCollectionViewCell.swift
//  Smack
//
//  Created by Nikhil Muskur on 30/09/18.
//  Copyright © 2018 Nikhil Muskur. All rights reserved.
//

import UIKit

class AvatarCollectionViewCell: UICollectionViewCell {
	@IBOutlet weak var imageView: UIImageView!
	
	func setUpView() {
		layer.cornerRadius = 10
		layer.backgroundColor = UIColor.darkGray.cgColor
		clipsToBounds = true
	}
	
}
