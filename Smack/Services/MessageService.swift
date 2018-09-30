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
	
	func findAllChannels(completion: @escaping CompletionHandler) {
		
		Alamofire.request(
			GET_ALL_CHANNELS,
			method: .get,
			parameters: nil,
			encoding: JSONEncoding.default,
			headers: AUTH_HEADERS).responseJSON { (response) in
				
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
						}
					} catch {
						print("Error parsing JSON: \(error.localizedDescription)")
					}
					
					completion(true)
				} else {
					completion(false)
					debugPrint(response.result.error as Any)
				}
		}
	}
}
