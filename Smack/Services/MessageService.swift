//
//  MessageService.swift
//  Smack
//
//  Created by Nikhil Muskur on 30/09/18.
//  Copyright © 2018 Nikhil Muskur. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

class MessageService {
	
	static let instance = MessageService()
	
	var channels = [Channel]()
	var selectedChannel: Channel?
	var unreadChannels = [String]()
	var messeges = [Message]()
	
	func findAllChannels(completion: @escaping CompletionHandler) {
		
		Alamofire.request(
			GET_ALL_CHANNELS,
			method: .get,
			parameters: nil,
			encoding: JSONEncoding.default,
			headers: AUTH_HEADERS).responseString { (response) in
				
				if response.result.error == nil {
					guard let jsonData = response.data else { return }
					
					do {
						let json = try JSON(data: jsonData).array
						
						for item in json! {
							let responseChannelName = item["name"].stringValue
							let responseChannelDesc = item["description"].stringValue
							let responseChannelId = item["_id"].stringValue
							let channel = Channel(name: responseChannelName, description: responseChannelDesc, id: responseChannelId)
							self.channels.append(channel)
							
							NotificationCenter.default.post(name: NOTIF_CHANNELS_LOADED, object: nil)
						}
					} catch {
						debugPrint(jsonData)
						print("Error parsing JSON: \(error)")
					}
					
					completion(true)
				} else {
					completion(false)
					debugPrint(response.result.error as Any)
				}
		}
	}
	
	
	func getAllMessages(withId channelID: String, completion: @escaping CompletionHandler) {
		
		Alamofire.request("\(GET_ALL_MESSAGES)/\(channelID)", method: .get, parameters: nil, encoding: JSONEncoding.default, headers: AUTH_HEADERS).responseJSON { (response) in
			
			self.clearMessages()
			
			if response.result.error == nil {
				guard let jsonData = response.data else { return }
				
				do {
					if let json = try JSON(data: jsonData).array {
						for message in json {
							let responseMessage = message["messageBody"].stringValue
							let responseID = message["_id"].stringValue
							let responseChannelID = message["channelId"].stringValue 
							let responseUserName = message["userName"].stringValue
							let responseUserAvatar = message["userAvatar"].stringValue
							let responseUserAvatarColor = message["userAvatarColor"].stringValue
							let responseTimeStamp = message["timeStamp"].stringValue
							
							let message = Message(message: responseMessage, id: responseID, userName: responseUserName, userAvatarName: responseUserAvatar, userAvatarColor: responseUserAvatarColor, channelId: responseChannelID, timeStamp: responseTimeStamp)

							
							self.messeges.append(message)
							completion(true)
						}
					}
				} catch {
					debugPrint(jsonData)
					print("Error parsing JSON: \(error)")
				}
				
				
			} else {
				completion(false)
				debugPrint(response.result.error as Any)
			}
			
		}
	}
	
	func clearMessages() {
		messeges.removeAll()
	}
	
	func clearChannels() {
		channels.removeAll()
	}
}
