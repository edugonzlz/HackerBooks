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

        // Añadimos un segmentedControl
        let order = ["Tags", "Title"]
        let sc = UISegmentedControl(items: order)

        // Arrancamos con la posicion 1
        sc.selectedSegmentIndex = 1

        // Reordenamos la tabla
        tableOrder(sc)

        sc.addTarget(self,
                     action: #selector(tableOrder),
                     forControlEvents: .ValueChanged)


        self.navigationItem.titleView = sc
    }

    // MARK: - Table Order Process for Segmented Control
    var orderSelected = Int()

    func tableOrder(sender: UISegmentedControl) {
        orderSelected = sender.selectedSegmentIndex

        switch sender.selectedSegmentIndex {
        case 0:
            print("has elegido ordenar por tags, index: \(orderSelected)")

            self.tableView.reloadData()

        case 1:
            print("has elegido ordenar por title, index: \(orderSelected)")

            self.tableView.reloadData()

        default:
            print("has elegido ordenar por tags por defecto, index: \(orderSelected)")
        }
    }

    func numberOfRows(forSection section: Int) -> Int {

        if orderSelected == 1 {

            return model.booksCount
        }

        return model.booksCount(forSection: section)
    }

    func getBook(forIndexPath indexPath: NSIndexPath) -> Book {

        if orderSelected == 1 {

           return model.book(forIndex: indexPath.row)
        }

        return model.book(forIndexPath: indexPath)
    }

    // MARK: - Table view data source
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {

        if orderSelected == 1 {

            return 1
        }
        return model.tagsCount
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        return numberOfRows(forSection: section)
    }

    override func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {

        if orderSelected == 1 {

            return "Books by Title"
        }
        return model.tagName(forSection: section)
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
        var book = model.book(forIndexPath: indexPath)

        if orderSelected == 1 {

            book = model.book(forIndex: indexPath.row)
        }

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
