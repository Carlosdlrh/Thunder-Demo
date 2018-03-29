//
//  MiEquipoViewController.swift
//  thunder
//
//  Created by CarlosDeLaRocha on 3/29/18.
//  Copyright © 2018 Bonsai. All rights reserved.
//

import UIKit
import Firebase
import moa

class MiEquipoViewController: UIViewController {

    var Equipos = Equip()
    
    @IBOutlet weak var nombreEquipo: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        //Cargar toda la información en el objeto
        imageView.moa.url = Equipos.FotoURL
        nombreEquipo.text = Equipos.EquipNom
    
    }

}
