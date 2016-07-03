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
    let model : Book
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

        // Hacer un push al PDFViewController


    }
    func syncModelWithView() {

        self.titleLabel?.text = model.title
        self.authorLabel?.text = model.author
    }



    override func viewDidLoad() {
        super.viewDidLoad()

        syncModelWithView()
        
        // Comprobar si somos favoritos

        // Cambiar color del boton segun corresponda
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
