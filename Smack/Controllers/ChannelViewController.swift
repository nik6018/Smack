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
	@IBOutlet weak var userImageView: UIImageView!
	override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
		revealViewController().rearViewRevealWidth = view.frame.width - 70
		NotificationCenter.default.addObserver(self, selector: #selector(checkUserDataState(_:)), name: NOTIF_USER_DATA_DID_CHANGE, object: nil)
    }
	
	@objc func checkUserDataState(_ notification: Notification) {
		
		if AuthService.instance.isLoggedIn {
			loginButton.setTitle(UserDataService.instance.name, for: .normal)
			let imageName = UIImage(named: UserDataService.instance.avatarName)
			userImageView.image = imageName
			userImageView.backgroundColor = UserDataService.instance.getUIColorForString(components: UserDataService.instance.avatarColor)
		} else {
			loginButton.setTitle("Login", for: .normal)
			userImageView.image = #imageLiteral(resourceName: "menuProfileIcon")
			userImageView.backgroundColor = UIColor.clear
		}
		
	}
	
	@IBAction func loginButtonPressed(_ sender: Any) {
		
		if AuthService.instance.isLoggedIn {
			let profileVC = ProfileViewController()
			profileVC.modalPresentationStyle = .custom
			present(profileVC, animated: true, completion: nil)
		} else {
			performSegue(withIdentifier: TO_LOGIN, sender: nil)
		}
	}
	
	@IBAction func prepareForUnWnindSegue(segue: UIStoryboardSegue) {  }
}
