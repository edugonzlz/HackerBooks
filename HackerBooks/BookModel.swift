//
//  BookModel.swift
//  HackerBooks
//
//  Created by Edu González on 2/7/16.
//  Copyright © 2016 Edu González. All rights reserved.
//

import Foundation
import UIKit

let BOOK_ICON_KEY = "bookIcon.png"

class Book {

    // MARK: - Stored Properties
    let title : String
    let author : String
    let tags : [String]
    let imageURL : NSURL
    let pdfURL : NSURL

    // MARK: - Computed Properties
    // TODO: - cuidado, corregir, esto esta lleno de !
    // TODO: - Me gustaria entregar la imagen aqui, pero me falla el for de los tags si lo hago
        var image : UIImage {
            get {
                guard let data = NSData(contentsOfURL: self.imageURL) else {
                    // Si no conseguimos una portada ponemos una por defecto
                    return UIImage(named: BOOK_ICON_KEY)!
                }

                return UIImage(data: data)!
            }
        }


    // MARK: - Inits
    init(title: String,
         author: String,
         tags: [String],
         imageURL: NSURL,
         pdfURL: NSURL) {

        self.title = title
        self.author = author
        self.tags = tags
        self.imageURL = imageURL
        self.pdfURL = pdfURL
    }
}