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
    let title : String
    let author : String
    let tags : [String]
    let imageURL : NSURL
    let pdf : NSURL

    // MARK: - Computed Properties
    // TODO: - esto esta lleno de !
//    var image : UIImage {
//        get {
//            guard let data = NSData(contentsOfURL: self.imageURL) else {
//                return UIImage(named: "Firewatch.jpg")!
//            }
//
//            return UIImage(data: data)!
//        }
//    }
    // MARK: - Inits
    init(title: String,
        author: String,
        tags: [String],
        imageURL: NSURL,
        pdf: NSURL) {

        self.title = title
        self.author = author
        self.tags = tags
        self.imageURL = imageURL
        self.pdf = pdf
    }
}