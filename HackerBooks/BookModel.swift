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
    var tittle      :   String
    var author      :   String
    var tags        :   [String]
    var image       :   UIImage
    var pdf         :   NSData

    // MARK: - Inits
    init(tittle: String,
        author: String,
        tags: [String],
        image: UIImage,
        pdf: NSData) {

        self.tittle = tittle
        self.author = author
        self.tags = tags
        self.image = image
        self.pdf = pdf
    }
}