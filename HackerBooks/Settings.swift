//
//  Settings.swift
//  HackerBooks
//
//  Created by Edu González on 8/7/16.
//  Copyright © 2016 Edu González. All rights reserved.
//

import Foundation
import UIKit

let APP_NAME = "Hacker Books"
let BOOK_ICON_KEY = "bookIcon.png"
let FAVS_KEY = "favorites"

// JSON
let JSON_URL_KEY = "https://t.co/K9ziV0z3SJ"

let JSON_TITLE = "title"
let JSON_AUTHOR = "authors"
let JSON_TAGS = "tags"
let JSON_IMAGE_URL = "image_url"
let JSON_PDF_URL = "pdf_url"

// Notifications
let FAVS_ARRAY_UPDATED_NOTIF = "FavsArrayUpdated"
let FAV_BUTTON_PUSHED_NOTIF = "favButtonPushNotification"
let BOOK_DID_CHANGE_NOTIF = "SelectedBookDidChange"
let BOOK_KEY = "BookKey"

// LibraryTableViewController
let TABLE_ORDER_DEFAULT = 0 // 0 = Tags ó 1 = Title
let TABLE_ORDER_TAGS = 0
let TABLE_ORDER_TITLE = 1
let TABLE_ORDER_TAGS_NAME = "Tags"
let TABLE_ORDER_TITLE_NAME = "Title"

// Typealias
typealias JSONObject = AnyObject
typealias JSONDictionary = [String: JSONObject]
typealias JSONArray = [JSONDictionary]
typealias BooksArray = [Book]
typealias TagsArray = [String]
typealias TagsDictionary = [String : BooksArray]

//#define IS_IPHONE  UI_USER_INTERFACE_IDIOM()==UIUserInterfaceIdiomPhone
let IS_IPHONE = UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiom.Phone
