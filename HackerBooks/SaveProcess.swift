//
//  SaveProcess.swift
//  HackerBooks
//
//  Created by Edu González on 4/7/16.
//  Copyright © 2016 Edu González. All rights reserved.
//

import Foundation

func getLocalURL(forRemoteURL url: NSURL, inCache: Bool) -> NSURL {

    // TODO: - Crear un throws y cuidado con los !

    // Accedemos a la carpeta Documents de nuestra app
    let fm = NSFileManager.defaultManager()
    var documentsURL : NSURL

    if inCache {

        // Quiero tener la opcion de guardar los pdf en cache, porque ocupan bastante
        documentsURL = fm.URLsForDirectory(.CachesDirectory, inDomains: .UserDomainMask).last!
    } else {

        documentsURL = fm.URLsForDirectory(.DocumentDirectory, inDomains: .UserDomainMask).last!
    }


    // Guardamos la url de nuestro fichero
    let fileURL = documentsURL.URLByAppendingPathComponent(url.lastPathComponent!)

    if fm.fileExistsAtPath(fileURL.path!) {

        return fileURL

    } else {

        NSData(contentsOfURL: url)?.writeToURL(fileURL, atomically: true)

        print("Descargando el documento: \(fileURL.lastPathComponent)\n desde la url: \(url) \n en: \(fileURL)")
        return fileURL
    }

}