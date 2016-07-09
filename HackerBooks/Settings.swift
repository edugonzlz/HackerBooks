//
//  Settings.swift
//  HackerBooks
//
//  Created by Edu González on 8/7/16.
//  Copyright © 2016 Edu González. All rights reserved.
//

import Foundation

let BOOK_ICON_KEY = "bookIcon.png"
let FAVS_KEY = "favorites"
let FAVS_ARRAY_UPDATED_NOTIF = "Favs Array Updated"
let FAV_BUTTON_PUSHED_NOTIF = "favButtonPushNotification"
let BOOK_DID_CHANGE_NOTIF = "Selected book did change"
let BOOK_KEY = "Book Key"


typealias JSONObject = AnyObject
typealias JSONDictionary = [String: JSONObject]
typealias JSONArray = [JSONDictionary]
typealias BooksArray = [Book]