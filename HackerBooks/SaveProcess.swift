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

        print("Descargando el documento: \(fileURL.lastPathComponent)\n desde la url: \(url) \n en: \(fileURL)")
        NSData(contentsOfURL: url)?.writeToURL(fileURL, atomically: true)

        return fileURL
    }
}

func switchFavorite(thisBook book: Book, toState state: Bool) {

    let defaults = NSUserDefaults.standardUserDefaults()

    // TODO: - decidir que version dejar
    // V1 guardando en un bool
    defaults.setBool(state, forKey: book.title)
    print("\(book.title) es favorito: \(defaults.boolForKey(book.title))")


    // V2 guardando en un diccionario
    if (defaults.dictionaryForKey(FAVS_KEY) == nil) {
        // si no existe el diccionario lo creamos
        let favsDict = [String : Bool]()
        defaults.setObject(favsDict, forKey: FAVS_KEY)
    }
    // Lo extraemos
    var favsDict = defaults.dictionaryForKey(FAVS_KEY)
    // Guardamos el nuevo favoritos
    favsDict![book.title] = state
    // Guardamos de nuevo el diccionario
    defaults.setObject(favsDict, forKey: FAVS_KEY)

    defaults.synchronize()
}

// Devolvemos un array con los titulos de los libros que son favoritos
func getFavorites() -> [String] {

    let defaults = NSUserDefaults.standardUserDefaults()
    if (defaults.dictionaryForKey(FAVS_KEY) != nil)  {

        let favsDict = defaults.dictionaryForKey(FAVS_KEY) as! [String : Bool]

        var favsArray = [String]()

        for (title, fav) in favsDict {

            if fav {
                favsArray.append(title)
            }
        }

        return favsArray

    } else {

        return []
    }
}