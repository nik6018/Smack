//
//  CreateAccountViewController.swift
//  Smack
//
//  Created by Nikhil Muskur on 30/09/18.
//  Copyright © 2018 Nikhil Muskur. All rights reserved.
//

import UIKit

class CreateAccountViewController: UIViewController {

	
	@IBOutlet weak var usernameTextField: UITextField!
	@IBOutlet weak var emailTextField: UITextField!
	@IBOutlet weak var passwordTextField: UITextField!
	@IBOutlet weak var avatarImageView: UIImageView!
	@IBOutlet weak var chooseAvatarButton: UIButton!
	
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
	
	
	@IBAction func createAccount(_ sender: Any) {
		
		guard let email = emailTextField.text, email != "" else { return }
		guard let pass = passwordTextField.text, pass != "" else { return }
		
		let service = AuthService.instance
		
		service.registerUser(
			withEmail: email,
			withPassword: pass) { (userCreated) in
				
				if userCreated {
					
					service.loginUser(
						withEmail: email,
						withPassword: pass,
						completion: { (success) in
							if success {
								print("User Logged in")
							} else {
								print("Not able to login")
							}
					})
				} else {
					print("We Failed")
				}
		}
		
	}
	
	@IBAction func dismissVC(_ sender: Any) {
		performSegue(withIdentifier: UNWIND, sender: nil)
	}
	@IBAction func chooseAvatar(_ sender: Any) {
	}
	
	@IBAction func changeAvatarColor(_ sender: Any) {
	}
}
