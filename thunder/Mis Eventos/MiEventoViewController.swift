//
//  MiEventoViewController.swift
//  thunder
//
//  Created by CarlosDeLaRocha on 3/11/18.
//  Copyright © 2018 Bonsai. All rights reserved.
//

import UIKit
import Firebase
import moa

class MiEventoViewController: UIViewController {
    
    var Eventos = Even()
    
    @IBOutlet weak var nombreEvento: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //Colores de la barra de estado configuracion obtenida desde el View Controller General
        var colors = [UIColor]()
        colors.append(UIColor(red: 19/255, green: 78/255, blue: 132/255, alpha: 2))
        colors.append(UIColor(red: 143/255, green: 0/255, blue: 108/255, alpha: 2))
        navigationController?.navigationBar.setGradientBackground(colors: colors)
        
        // Do any additional setup after loading the view.
        nombreEvento.text = Eventos.EveNom
        
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
