//
//  JSONProcess.swift
//  HackerBooks
//
//  Created by Edu González on 2/7/16.
//  Copyright © 2016 Edu González. All rights reserved.
//

import Foundation
import UIKit

// MARK: - Loading JSON

func loadAndSerialize(fromURL url: NSURL) throws -> JSONArray {

    if let data = NSData(contentsOfURL: url),
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
    guard let title = json[JSON_TITLE] as? String else {

        throw HackerBooksError.wrongJSONFormat
    }
    guard let author = json[JSON_AUTHOR] as? String else {

        throw HackerBooksError.wrongJSONFormat
    }
    guard let components = json[JSON_TAGS] as? String,
        tags : [String] = components.componentsSeparatedByString(", ") else {

            throw HackerBooksError.wrongJSONFormat
    }
    guard let iURL = json[JSON_IMAGE_URL] as? String,
        imageURL = NSURL(string: iURL) else {

            throw HackerBooksError.wrongURLFormatForJSONResource
    }
    guard let pURL = json[JSON_PDF_URL] as? String,
        pdfURL = NSURL(string: pURL) else {

            throw HackerBooksError.wrongURLFormatForJSONResource
    }

    return Book(title: title,
                author: author,
                tags: tags,
                imageURL: imageURL,
                pdfURL: pdfURL)
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




