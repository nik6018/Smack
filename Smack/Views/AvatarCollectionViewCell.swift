//
//  AvatarCollectionViewCell.swift
//  Smack
//
//  Created by Nikhil Muskur on 30/09/18.
//  Copyright © 2018 Nikhil Muskur. All rights reserved.
//

import UIKit

enum BackgroundType {
	case dark
	case light
}

class AvatarCollectionViewCell: UICollectionViewCell {
	
	@IBOutlet weak var imageView: UIImageView!
	
	override func awakeFromNib() {
		super.awakeFromNib()
		setUpView()
	}
	
	func configureCell(forIndex index: Int, withBackgroundType type: BackgroundType) {
		
		switch type {
		case .dark:
			imageView.image = UIImage(named: "dark\(index)")
			layer.backgroundColor = UIColor.lightGray.cgColor
		case .light:
			imageView.image = UIImage(named: "light\(index)")
			layer.backgroundColor = UIColor.darkGray.cgColor
		}
		
	}
	
	
	func setUpView() {
		layer.cornerRadius = 10
		layer.backgroundColor = UIColor.darkGray.cgColor
		self.clipsToBounds = true
	}
	
}
