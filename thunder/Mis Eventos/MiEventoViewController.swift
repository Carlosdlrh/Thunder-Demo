//
//  MiEventoViewController.swift
//  thunder
//
//  Created by CarlosDeLaRocha on 3/11/18.
//  Copyright © 2018 Bonsai. All rights reserved.
//

import UIKit
import Firebase

class MiEventoViewController: UIViewController {

    var nombre = ""
    
    @IBOutlet weak var nombreEvento: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        nombreEvento.text = nombre
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func reglamentoBoton(_ sender: Any) {
        performSegue(withIdentifier: "miReglamento", sender: nil)
    }
    
    @IBAction func participantesBoton(_ sender: Any) {
        performSegue(withIdentifier: "miParticipantes", sender: nil)
    }
    
    @IBAction func lugarBoton(_ sender: Any) {
        performSegue(withIdentifier: "miLugar", sender: nil)
    }
    
    @IBAction func staffBoton(_ sender: Any) {
        performSegue(withIdentifier: "mistaff", sender: nil)
    }
    
    @IBAction func mensajeBoton(_ sender: Any) {
        performSegue(withIdentifier: "mensajeMiEvento", sender: nil)
    }
    

}
