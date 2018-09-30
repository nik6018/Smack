//
//  Constants.swift
//  Smack
//
//  Created by Nikhil Muskur on 30/09/18.
//  Copyright © 2018 Nikhil Muskur. All rights reserved.
//

import Foundation

typealias CompletionHandler = (_ success: Bool) -> ()

// URL
let BASE_URL = "https://nikhil6019chatty.herokuapp.com/v1/"
let URL_ACCOUNT_REGISTER = "\(BASE_URL)account/register"
let URL_LOGIN = "\(BASE_URL)account/login"
let USER_ADD = "\(BASE_URL)user/add"
let FIND_USER_EMAIL = "\(BASE_URL)user/byEmail/"

//Headers

let HEADERS = [
	"Content-Type": "application/json"
]

let AUTH_HEADERS = [
	"Authorization": "Bearer \(AuthService.instance.authToken)",
	"Content-Type": "application/json"
]

//Notification

let NOTIF_USER_DATA_DID_CHANGE = Notification.Name("notifUserDataChanged")

//Segues
let TO_LOGIN = "toLogin"
let TO_CREATE_ACCOUNT = "toCreateAccount"
let UNWIND = "unwindToChannel"
let TO_AVATAR_PICKER = "toAvatarPicker"

// User Defaults
let TOKEN_KEY = "token"
let LOGGED_IN_KEY = "loggedIn"
let USER_EMAIL = "userEmail"
