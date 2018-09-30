//
//  ProfileViewController.swift
//  Smack
//
//  Created by Nikhil Muskur on 30/09/18.
//  Copyright © 2018 Nikhil Muskur. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController {

	
	@IBOutlet weak var profileImageView: UIImageView!
	@IBOutlet weak var profileName: UILabel!
	@IBOutlet weak var profileEmail: UILabel!
	@IBOutlet weak var bgView: UIView!
	
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
		setUpView()
		let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTap))
		bgView.addGestureRecognizer(tapGesture)
    }
	
	@IBAction func dismiss(_ sender: Any) {
		dismiss(animated: true, completion: nil)
	}
	
	@IBAction func logoutUser(_ sender: Any) {
		UserDataService.instance.logoutUser()
		NotificationCenter.default.post(name: NOTIF_USER_DATA_DID_CHANGE, object: nil)
		dismiss(animated: true, completion: nil)
	}
	
	@objc func handleTap() {
		dismiss(animated: true, completion: nil)
	}
	
	func setUpView() {
		profileName.text = UserDataService.instance.name
		profileEmail.text = AuthService.instance.userEmail
		profileImageView.image = UIImage(named: UserDataService.instance.avatarName)
		profileImageView.backgroundColor = UserDataService.instance.getUIColorForString(components: UserDataService.instance.avatarColor)
	}
}
