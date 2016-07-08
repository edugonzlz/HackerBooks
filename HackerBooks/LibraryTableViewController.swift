//
//  LibraryTableViewController.swift
//  HackerBooks
//
//  Created by Edu González on 2/7/16.
//  Copyright © 2016 Edu González. All rights reserved.
//

import UIKit

let BOOK_DID_CHANGE_NOTIF = "Selected book did change"
let BOOK_KEY = "Book Key"

class LibraryTableViewController: UITableViewController {

    // MARK: - Stored Properties
    let model : Library
    var delegate : LibraryTableViewControllerDelegate?


    // MARK: - Inits
    init(withModel model: Library) {

        self.model = model

        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        title = "HackerBooks"

        let order = ["Tags", "Title"]
        let sc = UISegmentedControl(items: order)
        sc.selectedSegmentIndex = 1

        sc.addTarget(self,
                     action: #selector(tableOrder),
                     forControlEvents: .ValueChanged)

        self.navigationItem.titleView = sc
    }


    var numberOfSections = Int()

    func tableOrder(sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex {
        case 0:
            print("has elegido tags")

            numberOfSections =  model.tagsCount

            func numberOfRows(inSection: Int) -> Int {
                return model.booksCount(forSection: inSection)
            }

            func bookFromBooks(indexPath: NSIndexPath) -> Book {

                let book = model.book(forIndexPath: indexPath)
                return book
            }

            self.tableView.reloadData()

        case 1:
            print("has elegido title")

            numberOfSections = 1

            func numberOfRows(inSection: Int) -> Int {
                return model.booksCount
            }

            func bookFromBooks(indexPath: NSIndexPath) -> Book {
                let book = model.book(forIndex: indexPath.row)

                return book
            }

            self.tableView.reloadData()

        default:
            print("has elegido tags")
        }
    }



    // MARK: - Table view data source
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {

//        return model.tagsCount
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

//        return model.booksCount(forSection: section)
        return model.booksCount
    }

//    override func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
//
//        return model.tagName(forSection: section)
//    }


    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {

        // Averiguamos el libro
//        let book = model.book(forIndexPath: indexPath)
        let book = model.book(forIndex: indexPath.row)

        // Creamos la celda
        let cellId = "bookCell"
        var cell = tableView.dequeueReusableCellWithIdentifier(cellId)

        if cell == nil {
            cell = UITableViewCell(style: .Subtitle, reuseIdentifier: cellId)
        }

        // Sincronizamos con la vista
        cell?.textLabel?.text = book.title
        cell?.detailTextLabel?.text = book.author
        cell?.imageView?.image = book.image

        return cell!
    }

    // MARK: - TableViewDelegate
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {

        // Averiguamos el libro
//        let book = model.book(forIndexPath: indexPath)
        let book = model.book(forIndex: indexPath.row)

        // Creamos un BookVC y hacemos un push
        // Solo para el caso de estar en un iPhone

        // Avisamos a nuestro delegate del cambio
        delegate?.libraryTableViewController(self, didSelectedBook: book)

        // Tambien enviamos el cambio con una notificacion
        let nc = NSNotificationCenter.defaultCenter()
        let notif = NSNotification(name: BOOK_DID_CHANGE_NOTIF,
                                   object: self,
                                   userInfo: [BOOK_KEY:book])
        nc.postNotification(notif)

    }

    // MARK: - LifeCycle
    override func viewWillAppear(animated: Bool) {

        // Nos damos de alta en notificaciones pasar saber cuando pulsan el boton de fav
        let nc = NSNotificationCenter.defaultCenter()
        nc.addObserver(self,
                       selector: #selector(favButtonPushed),
                       name: FAV_BUTTON_PUSHED_NOTIF,
                       object: nil)
    }
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)

        // Nos damos de baja del centro de notificaciones
        let nc = NSNotificationCenter.defaultCenter()
        nc.removeObserver(self)
    }

    func favButtonPushed() {

        model.processFavs()
        self.tableView.reloadData()
    }
}

// MARK: - LibraryTableViewControllerDelegate
protocol LibraryTableViewControllerDelegate {
    
    // funcion que mandamos a nuestro delegado
    // informa de que libro ha sido seleccionado 
    func libraryTableViewController(viewController: LibraryTableViewController, didSelectedBook book: Book)
    
}
