//
//  Errors.swift
//  HackerBooks
//
//  Created by Edu González on 2/7/16.
//  Copyright © 2016 Edu González. All rights reserved.
//

import Foundation

// MARK: - JSON Errors
enum HackerBooksError : ErrorType {

    case jsonParsingError
    case wrongJSONFormat
    case wrongURLFormatForJSONResource
    case errorDecodingJSON
    
    //    case resourcePointedByUrlNotReachable
    //    case jsonParsingError
    //    case nilJSONObject
}