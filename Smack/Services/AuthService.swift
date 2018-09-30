//
//  AuthService.swift
//  Smack
//
//  Created by Nikhil Muskur on 30/09/18.
//  Copyright © 2018 Nikhil Muskur. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON


class  AuthService {
	static let instance = AuthService()
	
	let defaults = UserDefaults.standard
	
	var isLoggedIn: Bool {
		get {
			return defaults.bool(forKey: LOGGED_IN_KEY)
		}
		set {
			defaults.set(newValue, forKey: LOGGED_IN_KEY)
		}
	}
	
	var authToken: String {
		get {
			return defaults.value(forKey: TOKEN_KEY) as! String
		}
		set {
			defaults.set(newValue, forKey: TOKEN_KEY)
		}
	}
	
	var userEmail: String {
		get {
			return defaults.value(forKey: USER_EMAIL) as! String
		}
		set {
			defaults.set(newValue, forKey: USER_EMAIL)
		}
	}
	
	func registerUser(withEmail email: String,
					  withPassword password: String,
					  completion: @escaping CompletionHandler) {
		
		let emailLowerCased = email.lowercased()
		
		let postBody: [String: Any] = [
			"email": emailLowerCased,
			"password": password
		]
		
		Alamofire.request(
			URL_ACCOUNT_REGISTER,
			method: .post,
			parameters: postBody,
			encoding: JSONEncoding.default,
			headers: HEADERS).responseString { (responseString) in
				
				if responseString.result.error == nil {
					completion(true)
				} else {
					completion(false)
					debugPrint(responseString.result.error as Any)
				}
		}
	}
	
	func loginUser(
		withEmail email: String,
		withPassword password: String,
		completion: @escaping CompletionHandler) {
		
		let emailLowerCased = email.lowercased()
		
		let postBody: [String: Any] = [
			"email": emailLowerCased,
			"password": password
		]
		
		Alamofire.request(
			URL_LOGIN,
			method: .post,
			parameters: postBody,
			encoding: JSONEncoding.default,
			headers: HEADERS).responseJSON { (response) in
				
				if response.result.error == nil {
					guard let jsonData = response.data else { return }
					
					do {
						let json = try JSON(data: jsonData)
						self.userEmail = json["user"].stringValue
						self.authToken = json["token"].stringValue
						self.isLoggedIn = true
						print("The Email is : \(self.userEmail)")
						print("The Token is : \(self.authToken)")
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
	
	func createUser(name: String, email: String, avatarName: String, avatarColor: String, completion: @escaping CompletionHandler) {
		
		let emailLowerCased = email.lowercased()
		
		let postBody: [String: Any] = [
			"name": name,
			"email": emailLowerCased,
			"avatarName": avatarName,
			"avatarColor": avatarColor
		]
		
		Alamofire.request(
			USER_ADD,
			method: .post,
			parameters: postBody,
			encoding: JSONEncoding.default,
			headers: AUTH_HEADERS).responseJSON { (response) in
				
				if response.result.error == nil {
					guard let jsonData = response.data else { return }
					
					do {
						let json = try JSON(data: jsonData)
						let responseId = json["_id"].stringValue
						let responseName = json["name"].stringValue
						let responseAvatarName = json["avatarName"].stringValue
						let responseAvatarColor = json["avatarColor"].stringValue
						let responseEmail = json["email"].stringValue
						
						UserDataService.instance.addUser(id: responseId, name: responseName, avatarName: responseAvatarName, avatarColor: responseAvatarColor)
					} catch {
						print("Error parsing JSON: \(error)")
					}
					
					completion(true)
				} else {
					completion(false)
					debugPrint(response.result.error as Any)
				}
		}
		
		
	}
	
	
	func findUserByEmail(completion: @escaping CompletionHandler) {
		
		let emailLowerCased = userEmail.lowercased()
		
		Alamofire.request(
			"\(FIND_USER_EMAIL)\(emailLowerCased)",
			method: .get,
			parameters: nil,
			encoding: JSONEncoding.default,
			headers: AUTH_HEADERS).responseJSON { (response) in
				if response.result.error == nil {
					guard let jsonData = response.data else { return }
					
					do {
						let json = try JSON(data: jsonData)
						print(json.array)
						let responseId = json["_id"].stringValue
						let responseName = json["name"].stringValue
						let responseAvatarName = json["avatarName"].stringValue
						let responseAvatarColor = json["avatarColor"].stringValue
						let responseEmail = json["email"].stringValue
						
						UserDataService.instance.addUser(id: responseId, name: responseName, avatarName: responseAvatarName, avatarColor: responseAvatarColor)
					} catch {
						print("Error parsing JSON: \(error)")
					}
					
					completion(true)
				} else {
					completion(false)
					debugPrint(response.result.error as Any)
				}
		}
		
	}
	
	
	
	
	
	
	
	
	
	
	
	
	
}
