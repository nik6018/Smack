//
//  AddChannelViewController.swift
//  Smack
//
//  Created by Nikhil Muskur on 01/10/18.
//  Copyright © 2018 Nikhil Muskur. All rights reserved.
//

import UIKit

class AddChannelViewController: UIViewController {

	
	@IBOutlet weak var bckGroundView: UIView!
	@IBOutlet weak var channelName: UITextField!
	@IBOutlet weak var channelDescription: UITextField!
	
	
	@IBAction func dismissPopUp(_ sender: Any) {
		dismiss(animated: true, completion: nil)
	}
	@IBAction func createChannel(_ sender: Any) {
	}
	
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
		let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTap))
		bckGroundView.addGestureRecognizer(tapGesture)
		
    }
	
	@objc func handleTap() {
		dismiss(animated: true, completion: nil)
	}

}
