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
    @IBOutlet weak var favButton: UIBarButtonItem!

    // MARK: - Init
    init(withModel model: Book) {

        self.model = model

        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Actions
    @IBAction func doFavoriteButton(sender: UIBarButtonItem) {

        // TODO: - Informar con una notificacion al modelo???
        if !model.favorite {

            model.favorite = true
            // Cambiar color del boton
            favButton.tintColor = UIColor.yellowColor()

        } else if model.favorite {

            model.favorite = false
            favButton.tintColor = UIColor.blueColor()
        }

    }

    @IBAction func readPDFButton(sender: UIBarButtonItem) {

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

        // Comprobamos si somos favorito y pintamos el color segun corresponda
        if model.favorite {

            favButton.tintColor = UIColor.yellowColor()
        } else if !model.favorite {

            favButton.tintColor = UIColor.blueColor()
        }
    }



    override func viewDidLoad() {
        super.viewDidLoad()

        syncModelWithView()
    }

}

// MARK: - LibraryTableViewControllerDelegate
extension BookViewController : LibraryTableViewControllerDelegate {

    func libraryTableViewController(viewController: LibraryTableViewController, didSelectedBook book: Book) {

        model = book

        syncModelWithView()
    }
}
