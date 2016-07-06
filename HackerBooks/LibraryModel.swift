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
    var favs = BooksArray()

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
    init(withBooks books: BooksArray) {

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
        // Ordenamos las tags por orden alfabetico
        self.tags.sortInPlace()
        // Añadimos la tag "fav" al principio
        tags.insert("favoritos", atIndex: 0)

        // Guardamos cada libro en el array de tags que corresponda
        for tag in tags {

            var booksWithTag = BooksArray()
            self.tagsDict[tag] = booksWithTag

            for book in books {
                if book.tags.contains(tag) {
                    booksWithTag.append(book)
                }
            }
            // Ordenamos comparando propiedad title cada array
            // y guardamos en el diccionario
            booksWithTag.sortInPlace({ $0.title < $1.title })
            self.tagsDict[tag] = booksWithTag
        }

        processFavs()

        // Creamos una key favs en el diccionario
        // y añadimos el array de favoritos
//        tagsDict["favoritos"] = favs

        addNotification()

    }

    // MARK: - Methods

    // Cantidad de elementos por tag
    func booksCount(forSection tagIndex: Int) -> Int {

        let tag = tags[tagIndex]

        guard let count = tagsDict[tag]?.count else {
            return 0
        }
        return count
    }
    // Elemento para el index de un tag
    func book(forIndexPath indexPath: NSIndexPath) -> Book {

        let tag = tags[indexPath.section]

        let elements = tagsDict[tag]
        // TODO: - corregir este !
        let element = elements![indexPath.row]

        return element
    }
    // Nombre de una tag para un index
    func tagName(forSection section: Int) -> String {

        return tags[section]
    }

    @objc func processFavs() {
        // Recopilamos favoritos
        let favsArray = getFavorites()

        var booksArray = BooksArray()

        for book in books {
            if favsArray.contains(book.title) {

                booksArray.append(book)
//                self.favs.append(book)
                print("Estos son los favoritos: \(book.title)")
            }
        }

        tagsDict["favoritos"] = booksArray
    }

    func addNotification() {
        // Nos damos de alta en notificaciones pasar saber cuando pulsan el boton de fav
        let nc = NSNotificationCenter.defaultCenter()
        nc.addObserver(self,
                       selector: #selector(processFavs),
                       name: "favButtonPushNotification",
                       object: nil)
    }
    
}

