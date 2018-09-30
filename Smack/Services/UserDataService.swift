//
//  UserDataService.swift
//  Smack
//
//  Created by Nikhil Muskur on 30/09/18.
//  Copyright © 2018 Nikhil Muskur. All rights reserved.
//

import Foundation

class UserDataService {
	
	static let instance = UserDataService()
	
	private(set) var id: String = ""
	private(set) var name: String = ""
	private(set) var avatarName: String = ""
	private(set) var avatarColor: String = ""
	
	
	func addUser(id: String, name: String, avatarName: String, avatarColor: String) {
		self.id = id
		self.name = name
		self.avatarName = avatarName
		self.avatarColor = avatarColor
	}
	
}
