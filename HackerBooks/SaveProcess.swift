//
//  SaveProcess.swift
//  HackerBooks
//
//  Created by Edu González on 4/7/16.
//  Copyright © 2016 Edu González. All rights reserved.
//

import Foundation

func getLocalURL(forRemoteURL url: NSURL, inCache: Bool) -> NSURL {

    // TODO: - gestionar los !

    // Accedemos a la carpeta Documents de nuestra app
    let fm = NSFileManager.defaultManager()
    var documentsURL : NSURL

    if inCache {

        // Quiero tener la opcion de guardar los pdf en cache, porque ocupan bastante
        // Asi el sistema puede borrarlos si necesita espacio
        documentsURL = fm.URLsForDirectory(.CachesDirectory, inDomains: .UserDomainMask).last!

    } else {

        documentsURL = fm.URLsForDirectory(.DocumentDirectory, inDomains: .UserDomainMask).last!
    }

    // Guardamos la url de nuestro fichero
    let fileURL = documentsURL.URLByAppendingPathComponent(url.lastPathComponent!)

    if fm.fileExistsAtPath(fileURL.path!) {

        return fileURL

    } else {

        // Si no existe la ruta descargamos el documento y lo guardamos
        print("Descargando el documento: \(fileURL.lastPathComponent)\n desde la url: \(url) \n en: \(fileURL)")

        guard let data = NSData(contentsOfURL: url) else {
            print("Fallo en la descarga de la url: \(url)")

            // Devuelvo la ruta donde queriamos guardar el archivo
            // TODO: - que otra cosa mejor puedo hacer ???
            return fileURL
        }
        data.writeToURL(fileURL, atomically: true)

        return fileURL
    }
}

func switchFavorite(thisBook book: Book, toState state: Bool) {

    let defaults = NSUserDefaults.standardUserDefaults()

    // Si no existe el diccionario lo creamos
    guard var favsDict = defaults.dictionaryForKey(FAVS_KEY) else {
        let favsDict = [String : Bool]()
        return defaults.setObject(favsDict, forKey: FAVS_KEY)
    }

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
// Informamos de si un libro es favorito
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