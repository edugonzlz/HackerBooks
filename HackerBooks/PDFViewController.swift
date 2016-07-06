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

        browser.delegate = self

        activityView.startAnimating()
        browser.loadRequest(NSURLRequest(URL: model.pdf))
    }

    func bookDidChange(notification: NSNotification) {

        // Sacar el userInfo
        let info = notification.userInfo!

        // Sacar el book
        let book = info[BOOK_KEY] as? Book

        // Actualizar el modelo
        model = book!

        // TODO: - no aparece el activityView

        // Sincronizar
        syncModelWithView()

    }

    // MARK: - WebViewDelegate
    func webViewDidFinishLoad(webView: UIWebView) {

        activityView.stopAnimating()
        activityView.hidesWhenStopped = true
    }
}
