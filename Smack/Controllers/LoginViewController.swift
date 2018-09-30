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
	@IBOutlet weak var spinner: UIActivityIndicatorView!
	
	override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
		spinner.isHidden = true
    }

	@IBAction func doLogin(_ sender: Any) {
		
		guard let username = usernameTextField.text, username != "" else { return }
		guard let password = passwordTextField.text, password != "" else { return }
		
		spinner.isHidden = false
		spinner.startAnimating()
		
		AuthService.instance.loginUser(withEmail: username, withPassword: password) { (success) in
			
			if success {
				
				AuthService.instance.findUserByEmail(completion: { (loginSuccess) in
					if loginSuccess {
						self.spinner.isHidden = true
						self.spinner.stopAnimating()
						NotificationCenter.default.post(name: NOTIF_USER_DATA_DID_CHANGE, object: nil)
						self.dismiss(animated: true, completion: nil)
					} else {
						self.spinner.isHidden = true
						self.spinner.stopAnimating()
						print("Unable to find User by EMail")
					}
				})
				
			} else {
				print("Not able to login")
				self.spinner.isHidden = true
				self.spinner.stopAnimating()
			}
		}
	}
	
	@IBAction func doSignUp(_ sender: Any) {
		performSegue(withIdentifier: TO_CREATE_ACCOUNT, sender: nil)
	}
	
	@IBAction func dismissButtonPressed(_ sender: Any) {
		dismiss(animated: true, completion: nil)
	}
	
}
