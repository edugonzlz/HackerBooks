//
//  AppDelegate.swift
//  HackerBooks
//
//  Created by Edu González on 2/7/16.
//  Copyright © 2016 Edu González. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func rootViewControllerForPhone(withModel model: Library) -> UIViewController {

        // Crear LibraryViewController
        let lVC = LibraryTableViewController(withModel: model)

        // Meter el View en un nav
        let lNav = UINavigationController(rootViewController: lVC)

        // Asignar delegados
        lVC.delegate = lVC

        return lNav
    }
    func rootViewControllerForPad(withModel model: Library) -> UIViewController {

        // Crear LibraryViewController
        let lVC = LibraryTableViewController(withModel: model)

        // Meter el View en un nav
        let lNav = UINavigationController(rootViewController: lVC)

        // Crear BookViewController
        let initModel = model.tagsDict[model.tags[1]]!.first
        let bVC = BookViewController(withModel: initModel!)

        let bNav = UINavigationController(rootViewController: bVC)

        // Creamos un splitViewController y metemos los dos Controllers anteriores
        let splitVC = UISplitViewController()
        splitVC.viewControllers = [lNav, bNav]

        // Asignamos delegados
        lVC.delegate = bVC

        return splitVC
    }

    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {

        do {


            let url = getLocalURL(forRemoteURL: NSURL(string: JSON_URL_KEY)!, inCache: false)
            let json = try loadAndSerialize(fromURL: url)

            let books = booksArray(fromJSONArray: json)
            let model = Library(withBooks: books)


            // Comprobamos si estamos en iphone o tableta
            var rootVC = UIViewController()

            if (!(IS_IPHONE)) {
                // Tableta
                rootVC = self.rootViewControllerForPad(withModel: model)
            } else {
                // Si no es tableta
                rootVC = self.rootViewControllerForPhone(withModel: model)
            }

            // Asignar como root
            window?.rootViewController = rootVC

            // Hacer visible la window
            window?.makeKeyAndVisible()

        } catch {

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

