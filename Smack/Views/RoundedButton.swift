//
//  RoundedButton.swift
//  Smack
//
//  Created by Nikhil Muskur on 30/09/18.
//  Copyright © 2018 Nikhil Muskur. All rights reserved.
//

import UIKit

@IBDesignable
class RoundedButton: UIButton {

	@IBInspectable var cornerRadius: CGFloat = 5 {
		didSet {
			layer.cornerRadius = cornerRadius
		}
	}
	
	override func awakeFromNib() {
		super.awakeFromNib()
		
		setUpView()
	}
	
	override func prepareForInterfaceBuilder() {
		super.prepareForInterfaceBuilder()
		
		setUpView()
	}
	
	func setUpView() {
		layer.cornerRadius = 5
	}
}
