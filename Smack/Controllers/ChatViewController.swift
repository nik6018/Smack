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
	@IBOutlet weak var messageTextField: UITextField!
	@IBOutlet weak var tableView: UITableView!
	@IBOutlet weak var sendButton: UIButton!
	@IBOutlet weak var typingUserLabel: UILabel!
	
	var isTyping = false
	
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		// Do any additional setup after loading the view, typically from a nib.
		view.bindToKeyboard()
		tableView.delegate = self
		tableView.dataSource = self
		tableView.estimatedRowHeight = 150
		tableView.rowHeight = UITableViewAutomaticDimension
		sendButton.isHidden = true
		
		menuButton.addTarget(
			self.revealViewController(),
			action: #selector(SWRevealViewController.revealToggle(_:)),
			for: .touchUpInside)
		
		view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
		view.addGestureRecognizer(self.revealViewController().tapGestureRecognizer())
		
		let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTap))
		view.addGestureRecognizer(tapGesture)
		
		NotificationCenter.default.addObserver(self, selector: #selector(checkUserDataState(_:)), name: NOTIF_USER_DATA_DID_CHANGE, object: nil)
		NotificationCenter.default.addObserver(self, selector: #selector(checkForSelectedChannel(_:)), name: NOTIF_CHANNEL_SELECTED, object: nil)
		
		SocketServrice.instance.getMessage { (message) in
			if message.channelId == MessageService.instance.selectedChannel?.id {
				MessageService.instance.messeges.append(message)
				self.tableView.reloadData()
				if MessageService.instance.messeges.count > 0 {
					let indexPath = IndexPath(row: MessageService.instance.messeges.count - 1, section: 0)
					self.tableView.scrollToRow(at: indexPath, at: .bottom, animated: false)
				}
			}
		}
		
		SocketServrice.instance.getTypingUser { (typingUsers) in
			guard let channelID = MessageService.instance.selectedChannel?.id else { return }
			
			if typingUsers.count > 0 {
				var names = ""
				typingUsers.forEach({ (elem) in
					if elem.value == channelID {
						if names.isEmpty {
							names = elem.key
						} else {
							names += ",\(elem.key)"
						}
					}
				})
				
				// extra check is some other channel conv is going on
				if names.isEmpty { return }
				
				if typingUsers.count > 1 {
					names += " are typing"
				} else {
					names += " is typing"
				}
				
				self.typingUserLabel.text = names
			} else {
				self.typingUserLabel.text = ""
			}
		}
		
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
	@IBAction func sendMessageButtonPressed(_ sender: Any) {
		if AuthService.instance.isLoggedIn {
			guard let channelId = MessageService.instance.selectedChannel else { return }
			guard let message = messageTextField.text, message != "" else { return }
			
			print("The CHannel ID is : \(channelId.id)")
			SocketServrice.instance.manager.defaultSocket.emit("stopType", UserDataService.instance.name, channelId.id)
			
			SocketServrice.instance.addMessage(messageBody: message, userID: UserDataService.instance.id, channelId: channelId.id) { (success) in
				if success {
					self.messageTextField.text = ""
					self.messageTextField.resignFirstResponder()
				} else {
					
				}
			}
		}
	}
	
	@IBAction func messgeBoxEditing(_ sender: Any) {
		
		guard let channelID = MessageService.instance.selectedChannel?.id else { return }
		
		if messageTextField.text == "" {
			isTyping = false
			sendButton.isHidden = true
			SocketServrice.instance.manager.defaultSocket.emit("stopType", UserDataService.instance.name, channelID)
		} else {
			if isTyping {
				SocketServrice.instance.userIsTyping(withName: UserDataService.instance.name, channelID: channelID)
				sendButton.isHidden = false
				
			}
			isTyping = true
		}
		
	}
	
	@objc func handleTap() {
		view.endEditing(true)
	}
	
	@objc func checkUserDataState(_ notification: Notification) {
		if AuthService.instance.isLoggedIn {
			getTheChannels()
		} else {
			channelNameLabel.text = "Please Login"
			tableView.reloadData()
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
			self.tableView.reloadData()
		}
		
	}
}

extension ChatViewController: UITableViewDelegate, UITableViewDataSource {
	
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return MessageService.instance.messeges.count
	}
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = tableView.dequeueReusableCell(withIdentifier: "MessageCell", for: indexPath) as! MessageTableViewCell
		let message = MessageService.instance.messeges[indexPath.row]
		cell.configureCell(withMessage: message)
		return cell
	}
}







