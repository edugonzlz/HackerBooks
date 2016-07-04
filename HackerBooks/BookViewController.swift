//
//  BookViewController.swift
//  HackerBooks
//
//  Created by Edu González on 2/7/16.
//  Copyright © 2016 Edu González. All rights reserved.
//

import UIKit

class BookViewController: UIViewController {

    // MARK: - Stored Properties
    var model : Book
    @IBOutlet weak var titleLabel: UILabel?
    @IBOutlet weak var authorLabel: UILabel?
    @IBOutlet weak var titlePageImage: UIImageView?

    // MARK: - Init
    init(withModel model: Book) {

        self.model = model

        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Actions
    @IBAction func doFavorite(sender: UIBarButtonItem) {

        // Cambiar color del boton

        // Informar con una notificacion al modelo
        // En el modelo cambiar la propiedad fav true/false

    }
    @IBAction func readPDF(sender: UIBarButtonItem) {

        // Creamos un PDFViewController
        let pdfVC = PDFViewController(withModel: model)

        // Hacer un push al PDFViewController
        navigationController?.pushViewController(pdfVC, animated: true)

    }
    
    func syncModelWithView() {

        title = model.title
        self.titleLabel?.text = model.title
        self.authorLabel?.text = model.author
        self.titlePageImage?.image = model.image
    }



    override func viewDidLoad() {
        super.viewDidLoad()

        syncModelWithView()
        
        // Comprobar si somos favoritos

        // Cambiar color del boton segun corresponda
    }

}

// MARK: - LibraryTableViewControllerDelegate

extension BookViewController : LibraryTableViewControllerDelegate {

    func libraryTableViewController(viewController: LibraryTableViewController, didSelectedBook book: Book) {

        model = book

        syncModelWithView()
    }
}
