//
//  LibraryTableViewController.swift
//  HackerBooks
//
//  Created by Edu González on 2/7/16.
//  Copyright © 2016 Edu González. All rights reserved.
//

import UIKit

//let BOOK_DID_CHANGE_NOTIF = "Selected book did change"
//let BOOK_KEY = "Book Key"

let TABLE_ORDER_TAGS = 0
let TABLE_ORDER_TITLE = 1
let TABLE_ORDER_TAGS_NAME = "Tags"
let TABLE_ORDER_TITLE_NAME = "Title"

class LibraryTableViewController: UITableViewController {

    // MARK: - Stored Properties
    let model : Library
    var delegate : LibraryTableViewControllerDelegate?
    var orderSelected = TABLE_ORDER_TAGS


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

        // Añadimos un segmentedControl
        let order = [TABLE_ORDER_TAGS_NAME, TABLE_ORDER_TITLE_NAME]

        let sc = UISegmentedControl(items: order)

        // posicion al arrancar
        sc.selectedSegmentIndex = orderSelected

        sc.addTarget(self,
                     action: #selector(sortTable),
                     forControlEvents: .ValueChanged)


        self.navigationItem.titleView = sc
    }

    // MARK: - Table Order Process for Segmented Control

    func sortTable(sender: UISegmentedControl) {

        orderSelected = sender.selectedSegmentIndex
        self.tableView.reloadData()
    }

    func numberOfTags() -> Int {

        if orderSelected == TABLE_ORDER_TITLE {

            return 1
        }
        return model.tagsCount
    }
    func numberOfBooks(forSection section: Int) -> Int {

        if orderSelected == TABLE_ORDER_TITLE {

            return model.booksCount
        }

        return model.booksCount(forSection: section)
    }
    func tagName(forSection section: Int) -> String? {

        if orderSelected == TABLE_ORDER_TITLE {

            return "Books by Title"
        }

        return model.tagName(forSection: section)
    }
    func getBook(forIndexPath indexPath: NSIndexPath) -> Book {

        if orderSelected == TABLE_ORDER_TITLE {

           return model.book(forIndex: indexPath.row)
        }

        return model.book(forIndexPath: indexPath)
    }


    // MARK: - Table view data source
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {

        return numberOfTags()
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        return numberOfBooks(forSection: section)
    }

    override func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {

        return tagName(forSection: section)
    }


    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {

        let book = getBook(forIndexPath: indexPath)

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
        let book = getBook(forIndexPath: indexPath)

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

        // Nos damos de alta en la notificacion que informa de la acualizacio de favoritos
        let nc = NSNotificationCenter.defaultCenter()
        nc.addObserver(self,
                       selector: #selector(favsUpdated),
                       name: FAVS_ARRAY_UPDATED_NOTIF,
                       object: nil)
    }

    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)

        // Nos damos de baja del centro de notificaciones
        let nc = NSNotificationCenter.defaultCenter()
        nc.removeObserver(self)
    }

    func favsUpdated() {

        self.tableView.reloadData()
    }
}

// MARK: - LibraryTableViewControllerDelegate
protocol LibraryTableViewControllerDelegate {
    
    // funcion que mandamos a nuestro delegado
    // informa de que libro ha sido seleccionado 
    func libraryTableViewController(viewController: LibraryTableViewController, didSelectedBook book: Book)
    
}
