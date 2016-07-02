//
//  BookModel.swift
//  HackerBooks
//
//  Created by Edu González on 2/7/16.
//  Copyright © 2016 Edu González. All rights reserved.
//

import Foundation
import UIKit

class Book {

    // MARK: - Stored Properties
    var title      :   String
    var author      :   String
    var tags        :   [String]
    var image       :   NSURL
    var pdf         :   NSURL

    // MARK: - Inits
    init(title: String,
        author: String,
        tags: [String],
        image: NSURL,
        pdf: NSURL) {

        self.title = title
        self.author = author
        self.tags = tags
        self.image = image
        self.pdf = pdf
    }
}