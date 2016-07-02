//
//  Library.swift
//  HackerBooks
//
//  Created by Edu González on 2/7/16.
//  Copyright © 2016 Edu González. All rights reserved.
//

import Foundation
import UIKit

class Library {

    // MARK: - Utility Types
    typealias BooksArray = [Book]
    typealias TagsArray = [String]
    typealias TagsDictionary = [String : BooksArray]

    // MARK: - Stored Properties
    var books : BooksArray
    var tags = TagsArray()
    var tagsDict = TagsDictionary()

    // MARK: - Computed Properties
    var booksCount : Int {
        get {
            let count = books.count
            return count
        }
    }
    var tagsCount : Int {
        get {
            let count = tags.count
            return count
        }
    }

    // MARK: - Inits
    init(books: BooksArray) {

        self.books = books

        // Extraemos todas las tags de los libros
        for book in books {
            for tag in book.tags {
                // Comprobamos si la tag esta ya en el array
                if !self.tags.contains(tag) {
                    self.tags.append(tag)
                }
            }
        }

        // Guardamos cada libro en el array de tags que corresponda
        for tag in tags {

            var booksWithTag = BooksArray()
            self.tagsDict[tag] = booksWithTag

            for book in books {
                if book.tags.contains(tag) {
                    booksWithTag.append(book)
                }
            }

            self.tagsDict[tag] = booksWithTag
        }

    }

    // MARK: - Methods

    // Cantidad de elementos por tag
    func booksCount(forTag tag: String) -> Int {

        guard let count = tagsDict[tag]?.count else {
            return 0
        }
        return count
    }

    // Array de un tag en concreto
    func books(forTag tag: String) -> BooksArray {

        let elements = tagsDict[tag]
        // TODO: - corregir este !
        return elements!
    }

    // Elemento para el index de un tag
    func books(atIndex index: Int, forTag tag: String) -> Book {
        let elements = tagsDict[tag]
        // TODO: - corregir este !
        let element = elements![index]

        return element
    }

}

