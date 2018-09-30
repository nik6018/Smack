//
//  ChannelViewController.swift
//  Smack
//
//  Created by Nikhil Muskur on 30/09/18.
//  Copyright © 2018 Nikhil Muskur. All rights reserved.
//

import UIKit

class ChannelViewController: UIViewController {

	@IBOutlet weak var loginButton: UIButton!
	override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
		revealViewController().rearViewRevealWidth = view.frame.width - 70
    }
	
	@IBAction func loginButtonPressed(_ sender: Any) {
		performSegue(withIdentifier: TO_LOGIN, sender: nil)
	}
	
	@IBAction func prepareForUnWnindSegue(segue: UIStoryboardSegue) {  }
}
