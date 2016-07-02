//
//  Foundation.swift
//  HackerBooks
//
//  Created by Edu González on 2/7/16.
//  Copyright © 2016 Edu González. All rights reserved.
//

import Foundation

extension NSBundle {

    // TODO: extender el metodo para que lanze un error
    // Nos pasan un archivo con extension y devolvemos una URL
    func URLForResource(name: String?) -> NSURL? {

        let components = name?.componentsSeparatedByString(".")
        let fileTitle = components?.first
        let fileExtension = components?.last

        return URLForResource(fileTitle, withExtension: fileExtension)
    }
}