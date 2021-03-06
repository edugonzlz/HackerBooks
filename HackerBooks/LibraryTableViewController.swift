//
//  LibraryTableViewController.swift
//  HackerBooks
//
//  Created by Edu González on 2/7/16.
//  Copyright © 2016 Edu González. All rights reserved.
//

import UIKit

class LibraryTableViewController: UITableViewController, LibraryTableViewControllerDelegate{

    // MARK: - Stored Properties
    let model : Library
    var delegate : LibraryTableViewControllerDelegate?
    var orderSelected = TABLE_ORDER_DEFAULT


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

    // MARK: - Table view data source
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {

        return numberOfTags()
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        return numberOfBooks(forSection: section)
    }

    override func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {

        // Cuando la seccion favoritos esta vacia no aparece en la tabla
        if section == 0 && numberOfBooks(forSection: 0) == 0 {
            return nil
        }
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

        // Pintamos las celdas de favoritos cuando ordenamos por titulo
        if book.favorite && orderSelected == TABLE_ORDER_TITLE {
            cell?.backgroundColor = UIColor(red:1.00, green:0.91, blue:0.49, alpha:1.00)
        } else {
            cell?.backgroundColor = UIColor.whiteColor()
        }

        return cell!
    }

    // MARK: - TableViewDelegate
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {

        // Averiguamos el libro
        let book = getBook(forIndexPath: indexPath)

        // Avisamos a nuestro delegate del cambio
        delegate?.libraryTableViewController(self, didSelectedBook: book)

        // Tambien enviamos el cambio con una notificacion
        let nc = NSNotificationCenter.defaultCenter()
        let notif = NSNotification(name: BOOK_DID_CHANGE_NOTIF,
                                   object: self,
                                   userInfo: [BOOK_KEY:book])
        nc.postNotification(notif)
    }

    func libraryTableViewController(viewController: LibraryTableViewController, didSelectedBook book: Book) {

        // Creamos un BookVC y hacemos un push
        // Solo para el caso de estar en un iPhone
        // En el cual, al ser delegados de la tabla, implementamos esta funcion
        let bVC = BookViewController(withModel: book)
        navigationController?.pushViewController(bVC, animated: true)
    }

    // MARK: - LifeCycle
    override func viewWillAppear(animated: Bool) {

        // Nos damos de alta en la notificacion que informa de la acualizacion de favoritos
        let nc = NSNotificationCenter.defaultCenter()
        nc.addObserver(self,
                       selector: #selector(favsUpdated),
                       name: FAVS_ARRAY_UPDATED_NOTIF,
                       object: nil)

        // Recargamos tambien la tabla aqui
        // para en el caso que estamos en iphone, al hacer el pop y volver a la tabla, 
        // recuperar los favoritos nuevos
        if IS_IPHONE {

            tableView.reloadData()
        }
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

    // MARK: - Table Order Process for Segmented Control
    func sortTable(sender: UISegmentedControl) {

        orderSelected = sender.selectedSegmentIndex
        self.tableView.reloadData()
    }
    func numberOfTags() -> Int {

        switch orderSelected {
        case TABLE_ORDER_TAGS:
            return model.tagsCount
        case TABLE_ORDER_TITLE:
            return 1
        default:
            return model.tagsCount
        }
    }
    func numberOfBooks(forSection section: Int) -> Int {

        switch orderSelected {
        case TABLE_ORDER_TAGS:
            return model.booksCount(forSection: section)
        case TABLE_ORDER_TITLE:
            return model.booksCount
        default:
            return model.booksCount(forSection: section)
        }
    }
    func tagName(forSection section: Int) -> String? {

        switch orderSelected {
        case TABLE_ORDER_TAGS:
            return model.tagName(forSection: section)
        case TABLE_ORDER_TITLE:
            return "BOOKS BY TITLE"
        default:
            return model.tagName(forSection: section)
        }
    }
    func getBook(forIndexPath indexPath: NSIndexPath) -> Book {

        switch orderSelected {
        case TABLE_ORDER_TAGS:
            return model.book(forIndexPath: indexPath)
        case TABLE_ORDER_TITLE:
            return model.book(forIndex: indexPath.row)
        default:
            return model.book(forIndexPath: indexPath)
        }
    }

}

// MARK: - LibraryTableViewControllerDelegate
protocol LibraryTableViewControllerDelegate {
    
    // funcion que mandamos a nuestro delegado
    // informa de que libro ha sido seleccionado 
    func libraryTableViewController(viewController: LibraryTableViewController, didSelectedBook book: Book)
    
}
