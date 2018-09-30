//
//  CircleImageView.swift
//  Smack
//
//  Created by Nikhil Muskur on 30/09/18.
//  Copyright © 2018 Nikhil Muskur. All rights reserved.
//

import UIKit

@IBDesignable
class CircleImageView: UIImageView {

	override func awakeFromNib() {
		super.awakeFromNib()
		setUpView()
	}
	
	func setUpView() {
		layer.cornerRadius = frame.width / 2
		clipsToBounds = true
	}
	
	override func prepareForInterfaceBuilder() {
		super.prepareForInterfaceBuilder()
		
		setUpView()
	}
	
	
}
