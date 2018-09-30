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

//Headers

let HEADERS = [
	"Content-Type": "application/json"
]



//Segues
let TO_LOGIN = "toLogin"
let TO_CREATE_ACCOUNT = "toCreateAccount"
let UNWIND = "unwindToChannel"

// User Defaults
let TOKEN_KEY = "token"
let LOGGED_IN_KEY = "loggedIn"
let USER_EMAIL = "userEmail"
