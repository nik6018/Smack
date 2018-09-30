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
	@IBOutlet weak var spinner: UIActivityIndicatorView!
	
	var avatarName = "profileDefault"
	var avatarColor = "[0.5,0.5,0.5,1]"
	var bgColor: UIColor?
	
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
		spinner.isHidden = true
		let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTap))
		view.addGestureRecognizer(tapGesture)
    }
	
	override func viewDidAppear(_ animated: Bool) {
		spinner.isHidden = true
		spinner.stopAnimating()
		
		if !UserDataService.instance.avatarName.isEmpty {
			avatarImageView.image = UIImage(named: UserDataService.instance.avatarName)
			avatarName = UserDataService.instance.avatarName
			if avatarName.contains("light") {
				avatarImageView.backgroundColor = .lightGray
			}
		}
	}
	
	
	@IBAction func createAccount(_ sender: Any) {
		
		guard let email = emailTextField.text, email != "" else { return }
		guard let pass = passwordTextField.text, pass != "" else { return }
		guard let name = usernameTextField.text, name != "" else { return }
		
		spinner.isHidden = false
		spinner.startAnimating()
		
		let service = AuthService.instance
		let userService = UserDataService.instance
		
		service.registerUser(
			withEmail: email,
			withPassword: pass) { (userCreated) in
				
				if userCreated {
					service.loginUser(
						withEmail: email,
						withPassword: pass,
						completion: { (success) in
							
							service.createUser(name: name, email: email, avatarName: self.avatarName, avatarColor: self.avatarColor, completion: { (success) in
								
								if success {
									print("The User: \(userService.name) and id: \(userService.id)")
									self.spinner.isHidden = true
									self.spinner.stopAnimating()
									self.performSegue(withIdentifier: UNWIND, sender: nil)
									NotificationCenter.default.post(name: NOTIF_USER_DATA_DID_CHANGE, object: nil)
								}
								
							})
							
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
		performSegue(withIdentifier: TO_AVATAR_PICKER, sender: nil)
	}
	
	@IBAction func changeAvatarColor(_ sender: Any) {
		let r = CGFloat(arc4random_uniform(255)) / 255
		let b = CGFloat(arc4random_uniform(255)) / 255
		let g = CGFloat(arc4random_uniform(255)) / 255
		
		bgColor = UIColor(red: r, green: g, blue: b, alpha: 1)
		avatarColor = "[\(r), \(b), \(g), 1]"
		avatarImageView.backgroundColor = bgColor
	}
	
	@objc func handleTap() {
		view.endEditing(true)
	}
}
