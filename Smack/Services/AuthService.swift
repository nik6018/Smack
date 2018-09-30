//
//  AuthService.swift
//  Smack
//
//  Created by Nikhil Muskur on 30/09/18.
//  Copyright © 2018 Nikhil Muskur. All rights reserved.
//

import Foundation
import Alamofire


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
		
		let headers = [
			"Content-Type": "application/json"
		]
		
		let postBody: [String: Any] = [
			"email": emailLowerCased,
			"password": password
		]
		
		Alamofire.request(
			URL_ACCOUNT_REGISTER,
			method: .post,
			parameters: postBody,
			encoding: JSONEncoding.default,
			headers: headers).responseString { (responseString) in
				
				if responseString.result.error == nil {
					completion(true)
				} else {
					completion(false)
					debugPrint(responseString.result.error as Any)
				}
		}
		
	}
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
}
