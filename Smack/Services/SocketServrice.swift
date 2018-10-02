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
}
