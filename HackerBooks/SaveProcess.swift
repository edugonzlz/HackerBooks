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

        // Descargamos el documento si no existe en el directorio?
        print("Descargando el documento: \(fileURL.lastPathComponent)\n desde la url: \(url) \n en: \(fileURL)")
        NSData(contentsOfURL: url)?.writeToURL(fileURL, atomically: true)

        return fileURL
    }
}

func switchFavorite(thisBook book: Book, toState state: Bool) {

    let defaults = NSUserDefaults.standardUserDefaults()

    // V1 guardando en un boolForKey
    //    defaults.setBool(state, forKey: book.title)
    // Borrar
    //    defaults.removeObjectForKey(book.title)
    // Recuperar
    //    defaults.boolForKey(book.title)


    // V2 guardando en un diccionario
    // Si no existe el diccionario lo creamos
    guard var favsDict = defaults.dictionaryForKey(FAVS_KEY) else {
        let favsDict = [String : Bool]()
        return defaults.setObject(favsDict, forKey: FAVS_KEY)
    }

//    if (defaults.dictionaryForKey(FAVS_KEY) == nil) {
//        // si no existe el diccionario lo creamos
//        let favsDict = [String : Bool]()
//        defaults.setObject(favsDict, forKey: FAVS_KEY)
//    }
    // Lo extraemos
//    favsDict = defaults.dictionaryForKey(FAVS_KEY)!

    // si el state es true guardamos, si es false borramos el libro
    if state {

        favsDict[book.title] = state

    } else if !state {

        favsDict.removeValueForKey(book.title)
    }

    // Guardamos de nuevo el diccionario
    defaults.setObject(favsDict, forKey: FAVS_KEY)

    defaults.synchronize()

    if (defaults.dictionaryForKey(FAVS_KEY)![book.title] != nil) {
        print("\(book.title) es favorito")
    } else {
        print("\(book.title) no es favorito")
    }
}

func isFavorite(thisBook book: Book) -> Bool {

    let defaults = NSUserDefaults.standardUserDefaults()
    guard let dict = defaults.dictionaryForKey(FAVS_KEY) as? [String : Bool],
        fav = dict[book.title] else {
        return false
    }
    return fav
}

// Devolvemos un array con los titulos de los libros que son favoritos
func getFavTitles() -> [String] {

    let defaults = NSUserDefaults.standardUserDefaults()
    if (defaults.dictionaryForKey(FAVS_KEY) != nil)  {

        let favsDict = defaults.dictionaryForKey(FAVS_KEY) as! [String : Bool]

        return [String](favsDict.keys)

    } else {

        return []
    }
}