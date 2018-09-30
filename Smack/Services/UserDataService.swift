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
	
	func setAvatarName(name: String) {
		avatarName = name
	}
	
	func getUIColorForString(components: String) -> UIColor {
		
		let scanner = Scanner(string: components)
		let skippedChars = CharacterSet(charactersIn: "[], ")
		let comma = CharacterSet(charactersIn: ",")
		
		var r,b,g : NSString?
		
		scanner.charactersToBeSkipped = skippedChars
		
		scanner.scanUpToCharacters(from: comma, into: &r)
		scanner.scanUpToCharacters(from: comma, into: &b)
		scanner.scanUpToCharacters(from: comma, into: &g)
		
		let defaultColor = UIColor.lightGray
		
		guard let rU = r else { return defaultColor }
		guard let gU = g else { return defaultColor }
		guard let bU = b else { return defaultColor }
		
		return UIColor(red: CGFloat(rU.doubleValue), green: CGFloat(gU.doubleValue), blue: CGFloat(bU.doubleValue), alpha: 1)
	}
}
