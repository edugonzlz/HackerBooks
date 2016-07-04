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

    // MARK: - Methods
    func syncModelWithView() {

        browser.delegate = self

        activityView.startAnimating()
        browser.loadRequest(NSURLRequest(URL: model.pdfURL))
    }

    // MARK: - LifeCycle
    override func viewWillAppear(animated: Bool) {

        syncModelWithView()
    }

    // MARK: - WebViewDelegate
    func webViewDidFinishLoad(webView: UIWebView) {

        activityView.stopAnimating()
        activityView.hidesWhenStopped = true
    }
}
