//
//  BookModel.swift
//  HackerBooks
//
//  Created by Edu González on 2/7/16.
//  Copyright © 2016 Edu González. All rights reserved.
//

import Foundation
import UIKit

//let BOOK_ICON_KEY = "bookIcon.png"

class Book {

    // MARK: - Stored Properties
    let title : String
    let author : String
    let tags : [String]
    let imageURL : NSURL
    let pdfURL : NSURL

    // MARK: - Computed Properties
    // TODO: - cuidado, corregir, esto esta lleno de !
    var image : UIImage {
        get {
            let url = getLocalURL(forRemoteURL: imageURL, inCache: false)

            guard let data = NSData(contentsOfURL: url) else {
                // Si no conseguimos una portada ponemos una por defecto
                return UIImage(named: BOOK_ICON_KEY)!
            }

            return UIImage(data: data)!

        }
    }
    var pdf : NSURL {
        get {
            let url = getLocalURL(forRemoteURL: pdfURL, inCache: true)

            return url
        }
    }
    var favorite : Bool {
        set(bool) {

            // Guardar en NSUserDefaults
            switchFavorite(thisBook: self, toState: bool)
        }
        get {

            // Mirar en NSUserDefaults
            let defaults = NSUserDefaults.standardUserDefaults()
            return defaults.boolForKey(self.title)
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