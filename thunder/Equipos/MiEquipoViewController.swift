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
    @IBOutlet weak var partinoText: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        //Cargar toda la información en el objeto
        imageView.moa.url = Equipos.FotoURL
        nombreEquipo.text = Equipos.EquipNom
        
        //Crear Conexión
        let ref = Database.database().reference().child("Equipos").child("Equipos Generales").child(Equipos.Equipuid).child("Inscritos")
        
        //Contar a los que están inscritos
        //Para cargar
        print("Starting observing");
        ref.observe(.value, with: { (snapshot: DataSnapshot!) in
            print("Got snapshot");
            print(snapshot.childrenCount)
            
            let count = String(snapshot.childrenCount)
            
            self.partinoText.text! = count
        })
    }

    //Preparar el Envio--------------------------
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "EquipoParticipantes"{
            let nextVC = segue.destination as! ParticipantesEquiposTableViewController
            nextVC.Equipos = sender as! Equip
        }
    }
    
    @IBAction func participanteBoton(_ sender: Any) {
        let EquipId = Equipos
        performSegue(withIdentifier: "EquipoParticipantes", sender: EquipId)
    }
    
}
