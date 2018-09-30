//
//  LoginViewController.swift
//  Smack
//
//  Created by Nikhil Muskur on 30/09/18.
//  Copyright © 2018 Nikhil Muskur. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {

	@IBOutlet weak var usernameTextField: UITextField!
	@IBOutlet weak var passwordTextField: UITextField!
	
	override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

	@IBAction func doLogin(_ sender: Any) {
	}
	
	@IBAction func doSignUp(_ sender: Any) {
		performSegue(withIdentifier: TO_CREATE_ACCOUNT, sender: nil)
	}
	
	@IBAction func dismissButtonPressed(_ sender: Any) {
		dismiss(animated: true, completion: nil)
	}
	
}
