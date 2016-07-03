//
//  AppDelegate.swift
//  HackerBooks
//
//  Created by Edu González on 2/7/16.
//  Copyright © 2016 Edu González. All rights reserved.
//

import UIKit

let JSON_URL_KEY = "https://t.co/K9ziV0z3SJ"
let JSON_FILE_NAME_KEY = "books_readable.json"

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {

        do {
            // TODO: - Revisar ! en optionals
            var json = JSONArray()

            // Accedemos a la carpeta Documents de nuestra app
            let fm = NSFileManager.defaultManager()
            let documentsURL = fm.URLsForDirectory(.DocumentDirectory, inDomains: .UserDomainMask).last

            // Guardamos la url de nuestro fichero
            let fileURL = documentsURL!.URLByAppendingPathComponent(JSON_FILE_NAME_KEY)

            // Comprobar si tenemos un JSON en local
            if fm.fileExistsAtPath(fileURL.path!) {

                json = try loadAndSerialize(fromURL: fileURL)
                print("usando el json local en: \(fileURL)")

            } else {

                // Descargamos con la url
                let url = NSURL(string: JSON_URL_KEY)
                NSData(contentsOfURL: url!)?.writeToURL(fileURL, atomically: true)

                // Otra forma de guardar los datos
                //                let data = NSData(contentsOfURL: url!)
                //                fm.createFileAtPath(fileURL.path!,
                //                                    contents: data,
                //                                    attributes: nil)

                // Lo serializamos
                json = try loadAndSerialize(fromURL: fileURL)
                print("descargando el json de internet desde: \(JSON_URL_KEY)")
            }

            let books = booksArray(fromJSONArray: json)
            let model = Library(withBooks: books)

            // Crear LibraryViewController
            let lVC = LibraryTableViewController(withModel: model)

            // Metemos el View en un nav
            let lNav = UINavigationController(rootViewController: lVC)

            // Crear BookViewController
            let bVC = BookViewController(withModel: books[0])

            // Lo metemos en un nav
            let bNav = UINavigationController(rootViewController: bVC)

            // Creamos un splitViewController y metemos los dos Controllers anteriores
            let splitVC = UISplitViewController()
            splitVC.viewControllers = [lNav, bNav]


            // Asignar como root
            window?.rootViewController = splitVC

            // Hacer visible la window
            window?.makeKeyAndVisible()

        } catch {
            // TODO: - revisar este error, esta duplicado en loadAndSerialize???
            print("Error tratando de cargar y serializar el archivo JSON")
        }

        return true
    }

    func applicationWillResignActive(application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }
    
    func applicationWillTerminate(application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }
    
    
}

