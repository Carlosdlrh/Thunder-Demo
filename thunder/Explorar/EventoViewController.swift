//
//  EventoViewController.swift
//  thunder
//
//  Created by CarlosDeLaRocha on 3/11/18.
//  Copyright © 2018 Bonsai. All rights reserved.
//

import UIKit
import SDWebImage

class EventoViewController: UIViewController {

    var Eventos = Even()
    
    @IBOutlet weak var nombreEvento: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        //Colores de la barra de estado configuracion obtenida desde el View Controller General
        var colors = [UIColor]()
        colors.append(UIColor(red: 19/255, green: 78/255, blue: 132/255, alpha: 2))
        colors.append(UIColor(red: 143/255, green: 0/255, blue: 108/255, alpha: 2))
        navigationController?.navigationBar.setGradientBackground(colors: colors)
        
        UIImageView.sd_setImage(with: Eventos.FotoURL!)
        
        nombreEvento.text = Eventos.EveNom
        
    }
    
    //Botones de la plantilla --------------------------------------
    @IBAction func reglamentoBoton(_ sender: Any) {
        performSegue(withIdentifier: "eventoReglamento", sender: nil)
    }
    
    @IBAction func participanteBoton(_ sender: Any) {
        performSegue(withIdentifier: "eventoParticipantes", sender: nil)
    }
    
    @IBAction func lugarBoton(_ sender: Any) {
        performSegue(withIdentifier: "eventoLugar", sender: nil)
    }
    
    @IBAction func mensajeBoton(_ sender: Any) {
        performSegue(withIdentifier: "mensajeEvento", sender: nil)
    }
    
    
}
