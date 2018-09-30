//
//  ViewController.swift
//  Smack
//
//  Created by Nikhil Muskur on 29/09/18.
//  Copyright © 2018 Nikhil Muskur. All rights reserved.
//

import UIKit

class ChatViewController: UIViewController {

	@IBOutlet weak var menuButton: UIButton!
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		// Do any additional setup after loading the view, typically from a nib.
		menuButton.addTarget(
			self.revealViewController(),
			action: #selector(SWRevealViewController.revealToggle(_:)),
			for: .touchUpInside)
		
		view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
		view.addGestureRecognizer(self.revealViewController().tapGestureRecognizer())
	}
}

