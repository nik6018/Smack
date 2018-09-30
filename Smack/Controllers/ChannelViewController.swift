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
	@IBOutlet weak var tableView: UITableView!
	
	
	override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
		revealViewController().rearViewRevealWidth = view.frame.width - 70
		NotificationCenter.default.addObserver(self, selector: #selector(checkUserDataState(_:)), name: NOTIF_USER_DATA_DID_CHANGE, object: nil)
		tableView.delegate = self
		tableView.dataSource = self
    }
	
	override func viewDidAppear(_ animated: Bool) {
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
	
	@IBAction func addChannelButtonPressed(_ sender: Any) {
		
		let addChannelVC = AddChannelViewController()
		addChannelVC.modalPresentationStyle = .custom
		present(addChannelVC, animated: true, completion: nil)
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

extension ChannelViewController: UITableViewDataSource, UITableViewDelegate {
	
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return MessageService.instance.channels.count
	}
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = tableView.dequeueReusableCell(withIdentifier: "ChannelCell", for: indexPath) as! ChannelTableViewCell
		let channel = MessageService.instance.channels[indexPath.row]
		cell.configureCell(withChannel: channel)
		return cell
	}
	
}
