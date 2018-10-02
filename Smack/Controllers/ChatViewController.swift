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
	@IBOutlet weak var channelNameLabel: UILabel!
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		// Do any additional setup after loading the view, typically from a nib.
		menuButton.addTarget(
			self.revealViewController(),
			action: #selector(SWRevealViewController.revealToggle(_:)),
			for: .touchUpInside)
		
		view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
		view.addGestureRecognizer(self.revealViewController().tapGestureRecognizer())
		
		NotificationCenter.default.addObserver(self, selector: #selector(checkUserDataState(_:)), name: NOTIF_USER_DATA_DID_CHANGE, object: nil)
		NotificationCenter.default.addObserver(self, selector: #selector(checkForSelectedChannel(_:)), name: NOTIF_CHANNEL_SELECTED, object: nil)
		
		
		if AuthService.instance.isLoggedIn {
			AuthService.instance.findUserByEmail(completion: { (loginSuccess) in
				if loginSuccess {
					NotificationCenter.default.post(name: NOTIF_USER_DATA_DID_CHANGE, object: nil)
				} else {
					print("Unable to find User by EMail")
				}
			})
		}
	}
	
	@objc func checkUserDataState(_ notification: Notification) {
		if AuthService.instance.isLoggedIn {
			getTheChannels()
		} else {
			channelNameLabel.text = "Please Login"
		}
	}

	@objc func checkForSelectedChannel(_ notification: Notification) {
		loadChanelChatData()
	}
	
	func getTheChannels() {
		MessageService.instance.findAllChannels { (success) in
			if success {
				if MessageService.instance.channels.count > 0 {
					MessageService.instance.selectedChannel = MessageService.instance.channels[0]
					self.loadChanelChatData()
				} else {
					self.channelNameLabel.text = "#No Channels Yet"
				}
			} else {
				print("was not able to get any channels")
			}
		}
	}
	
	func loadChanelChatData() {
		let channelID = MessageService.instance.selectedChannel?.name ?? ""
		channelNameLabel.text = "#\(channelID)"
		getAllMessages()
	}
	
	func getAllMessages() {
		guard let channelID = MessageService.instance.selectedChannel else { return }
		
		MessageService.instance.getAllMessages(withId: channelID.id) { (success) in
			//
		}
		
	}
}

