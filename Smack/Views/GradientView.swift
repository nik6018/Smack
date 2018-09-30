//
//  GradientView.swift
//  Smack
//
//  Created by Nikhil Muskur on 30/09/18.
//  Copyright © 2018 Nikhil Muskur. All rights reserved.
//

import UIKit

@IBDesignable
class GradientView: UIView {

	@IBInspectable var startColor: UIColor = #colorLiteral(red: 0.2901960784, green: 0.3019607843, blue: 0.8470588235, alpha: 1) {
		didSet {
			setNeedsLayout()
		}
	}
	
	@IBInspectable var endColor: UIColor = #colorLiteral(red: 0.1725490196, green: 0.831372549, blue: 0.8470588235, alpha: 1) {
		didSet {
			setNeedsLayout()
		}
	}
	
	override func layoutSubviews() {
		let gradient = CAGradientLayer()
		gradient.colors = [startColor.cgColor, endColor.cgColor]
		gradient.startPoint = CGPoint(x: 0, y: 0)
		gradient.endPoint = CGPoint(x: 1, y: 1)
		gradient.frame = bounds
		layer.insertSublayer(gradient, at: 0)
	}
	
	
	
}
