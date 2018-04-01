//
//  PerfilViewController.swift
//  thunder
//
//  Created by CarlosDeLaRocha on 3/25/18.
//  Copyright © 2018 Bonsai. All rights reserved.
//

import UIKit
import Firebase

class PerfilViewController: UIViewController {
    var tipo = sujeto()
    
    @IBOutlet weak var nombreTextField: UILabel!
    
    @IBOutlet weak var apellidoTextField: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        self.nombreTextField.text! = tipo.sujetoNom
        self.apellidoTextField.text! = tipo.sujetoApell
        
    }
    
    
}
