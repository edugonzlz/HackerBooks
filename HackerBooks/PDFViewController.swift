//
//  PDFViewController.swift
//  HackerBooks
//
//  Created by Edu González on 2/7/16.
//  Copyright © 2016 Edu González. All rights reserved.
//

import UIKit

class PDFViewController: UIViewController, UIWebViewDelegate {

    // MARK: - Properties
    var model : Book
    @IBOutlet weak var browser: UIWebView!
    @IBOutlet weak var activityView: UIActivityIndicatorView!

    // MARK: - Inits
    init(withModel model: Book) {

        self.model = model

        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }


    // MARK: - LifeCycle
    override func viewWillAppear(animated: Bool) {

        // Nos damos de alta en el centro de notificaciones
        // Para enterarnos cuando pulsen un libro en la tabla
        let nc = NSNotificationCenter.defaultCenter()
        nc.addObserver(self,
                       selector: #selector(bookDidChange),
                       name: BOOK_DID_CHANGE_NOTIF,
                       object: nil)

        activityView.startAnimating()
    }
    override func viewDidAppear(animated: Bool) {

        syncModelWithView()
    }
    override func viewWillDisappear(animated: Bool) {

        // Nos damos de baja en el centro de notificaciones
        let nc = NSNotificationCenter.defaultCenter()
        nc.removeObserver(self)
    }

    // MARK: - Methods
    func syncModelWithView() {

        // TODO: - cuando cambio el libro desde la tabla y el pdf no se habia descargado
        // no se pinta el titulo y el activityView
        self.title = "Loading PDF..."
        activityView.startAnimating()

        browser.delegate = self

        guard let data = NSData(contentsOfURL: model.pdf) else {
            self.title = "Error Cargando PDF..."
            return print("Error tratando de recuperar el archivo pdf de nuestro libro")
        }
        browser.loadData(data,
                         MIMEType: "application/pdf",
                         textEncodingName: "utf-8",
                         baseURL: model.pdf)
    }

    func bookDidChange(notification: NSNotification) {

        // Extraemos el libro
        let info = notification.userInfo!
        let book = info[BOOK_KEY] as? Book

        // Actualizamos el modelo
        model = book!

        // Sincronizar
        syncModelWithView()
    }

    // MARK: - WebViewDelegate
    func webViewDidFinishLoad(webView: UIWebView) {

        self.title = ""
        
        activityView.stopAnimating()
        activityView.hidesWhenStopped = true
    }
}
