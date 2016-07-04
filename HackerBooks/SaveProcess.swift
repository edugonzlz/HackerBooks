//
//  SaveProcess.swift
//  HackerBooks
//
//  Created by Edu González on 4/7/16.
//  Copyright © 2016 Edu González. All rights reserved.
//

import Foundation

// caso json - me pasan fileName - duvuelvo URL

// caso image - me pasan el book.title + sumo image + - devuelvo URl
// caso pdf - me pasan el book.title + sumo pdf + - devuelvo URl

func getLocalURL(forRemoteURL url: NSURL) -> NSURL {

    // Accedemos a la carpeta Documents de nuestra app
    let fm = NSFileManager.defaultManager()
    let documentsURL = fm.URLsForDirectory(.DocumentDirectory, inDomains: .UserDomainMask).last

    // Guardamos la url de nuestro fichero
    let fileURL = documentsURL!.URLByAppendingPathComponent(url.lastPathComponent!)

    if fm.fileExistsAtPath(fileURL.path!) {

        print("Obteniendo datos de la url local: \(fileURL)")
        return fileURL

    } else {

        NSData(contentsOfURL: url)?.writeToURL(fileURL, atomically: true)

        print("Descargando desde la url: \(url)")
        return fileURL
    }

}