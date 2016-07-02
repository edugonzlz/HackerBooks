//
//  JSONProcess.swift
//  HackerBooks
//
//  Created by Edu González on 2/7/16.
//  Copyright © 2016 Edu González. All rights reserved.
//

import Foundation
import UIKit


// MARK: - Aliases
typealias JSONObject = AnyObject
typealias JSONDictionary = [String: JSONObject]
typealias JSONArray = [JSONDictionary]
typealias BooksArray = [Book]

// MARK: - Loading JSON
// Nos pasan el nombre de un archivo y su bundle
// Devolvemos un array de diccionarios, en este caso de libros
func loadAndSerialize(fromLocalJSONFile name: String,
                                bundle: NSBundle = NSBundle.mainBundle())
    throws -> JSONArray {

        if let url = bundle.URLForResource(name),
            data = NSData(contentsOfURL: url),
            maybeArray = try? NSJSONSerialization.JSONObjectWithData(data,
                                                                     options: NSJSONReadingOptions.MutableContainers) as? JSONArray,
            array = maybeArray {

            return array

        } else {

            throw HackerBooksError.jsonParsingError
        }
}

func decode(bookInJSON json: JSONDictionary) throws -> Book {

    // validamos el book/diccionario/json
    guard let title = json["title"] as? String else {

        throw HackerBooksError.wrongJSONFormat
    }
    guard let author = json["authors"] as? String else {

        throw HackerBooksError.wrongJSONFormat
    }
    guard let components = json["tags"] as? String,
    tags : [String] = components.componentsSeparatedByString(", ") else {

            throw HackerBooksError.wrongJSONFormat
    }
    guard let iURL = json["image_url"] as? String,
        imageURL = NSURL(string: iURL) else {

            throw HackerBooksError.wrongURLFormatForJSONResource
    }
    guard let pURL = json["pdf_url"] as? String,
    pdfURL = NSURL(string: pURL) else {

            throw HackerBooksError.wrongURLFormatForJSONResource
    }

    return Book(title: title,
                author: author,
                tags: tags,
                image: imageURL,
                pdf: pdfURL)
}

// nos dan el jsonArray, un array de diccionarios/Book
// Devolvemos un array de objetos Book
func booksArray(fromJSONArray array: JSONArray) -> BooksArray {

    var books = BooksArray()
    for dict in array {
        do {
            let book = try decode(bookInJSON: dict)

            // sumamos el libro en el array de libros
            books.append(book)

        } catch {

            HackerBooksError.errorDecodingJSON
        }
    }

    return books
}




