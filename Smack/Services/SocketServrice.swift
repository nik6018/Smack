//
//  SocketServrice.swift
//  Smack
//
//  Created by Nikhil Muskur on 01/10/18.
//  Copyright © 2018 Nikhil Muskur. All rights reserved.
//

import UIKit
import SocketIO

class SocketServrice: NSObject {

	static let instance = SocketServrice()
	
	override init() {
		super.init()
	}
	
	let manager = SocketManager(socketURL: URL(string: BASE_URL)!, config: [.log(true), .compress])
	
	func establishConnection() {
		manager.defaultSocket.connect()
	}
	
	func closeConnection() {
		manager.defaultSocket.disconnect()
	}
	
	func addChannel(channelName: String, channelDesc: String, completion: @escaping CompletionHandler) {
		manager.defaultSocket.emit("newChannel", channelName, channelDesc)
		completion(true)
	}
	
	func getChannels(completion: @escaping CompletionHandler) {
		manager.defaultSocket.on("channelCreated") { (dataArray, ack) in
			guard let name = dataArray[0] as? String else {return}
			guard let desc = dataArray[1] as? String else {return}
			guard let id = dataArray[2] as? String else {return}
			
			let channel = Channel(name: name, description: desc, id: id)
			MessageService.instance.channels.append(channel)
			completion(true)
			
		}
	}
	
	func addMessage(messageBody :String,userID: String,channelId: String,completion: @escaping 	CompletionHandler) {
		
		let user = UserDataService.instance
		manager.defaultSocket.emit("newMessage", messageBody, userID, channelId, user.name, user.avatarName, user.avatarColor)
		completion(true)
	}
	
	func getMessage(completion: @escaping (_ newMessage: Message) -> Void) {
		manager.defaultSocket.on("messageCreated") { (dataArray, ack) in
			print("In \(#function)")
			guard let responseMessage = dataArray[0] as? String else { return }
			guard let responseChannelId = dataArray[2] as? String else { return }
			guard let responseUserName = dataArray[3] as? String else { return }
			guard let responseUserAvatar = dataArray[4] as? String else { return }
			guard let responseUserAvatarColor = dataArray[5] as? String else { return }
			guard let responseId = dataArray[6] as? String else { return }
			guard let responseTimeStamp = dataArray[7] as? String else { return }
			
			let message = Message(message: responseMessage, id: responseId, userName: responseUserName, userAvatarName: responseUserAvatar, userAvatarColor: responseUserAvatarColor, channelId: responseChannelId, timeStamp: responseTimeStamp)
			
			completion(message)
			
		}
	}
	
	func userIsTyping(withName username: String, channelID: String) {
		manager.defaultSocket.emit("startType", username, channelID)
	}
	
	func getTypingUser(completion: @escaping (_ typeingUsers: [String: String]) -> Void) {
		
		manager.defaultSocket.on("userTypingUpdate") { (dataArray, ack) in
			guard let typingUsers = dataArray[0] as? [String: String] else { return }
			completion(typingUsers)
		}
		
	}
}





