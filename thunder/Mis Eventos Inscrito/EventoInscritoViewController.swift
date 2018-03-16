//
//  EventoInscritoViewController.swift
//  thunder
//
//  Created by CarlosDeLaRocha on 3/11/18.
//  Copyright © 2018 Bonsai. All rights reserved.
//

import UIKit

class EventoInscritoViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
    }

    @IBAction func reglamentoBoton(_ sender: Any) {
        performSegue(withIdentifier: "miReglamento", sender: nil)
    }
    
    @IBAction func participantesBoton(_ sender: Any) {
        performSegue(withIdentifier: "participantesEventoInscrito", sender: nil)
    }
    
    @IBAction func lugarBoton(_ sender: Any) {
        performSegue(withIdentifier: "lugarEventoInscrito", sender: nil)
    }
    
    @IBAction func mensajeBotn(_ sender: Any) {
        performSegue(withIdentifier: "mensajeEventoInscrito", sender: nil)
    }
    
    
}
