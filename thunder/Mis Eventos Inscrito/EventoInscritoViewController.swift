//
//  EventoInscritoViewController.swift
//  thunder
//
//  Created by CarlosDeLaRocha on 3/11/18.
//  Copyright © 2018 Bonsai. All rights reserved.
//

import UIKit
import Firebase
import moa
import SDWebImage

class EventoInscritoViewController: UIViewController {

    var Eventos = Even()
    
    @IBOutlet weak var nombreEvento: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var partinoText: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        //Colores de la barra de estado configuracion obtenida desde el View Controller General
        var colors = [UIColor]()
        colors.append(UIColor(red: 19/255, green: 78/255, blue: 132/255, alpha: 2))
        colors.append(UIColor(red: 143/255, green: 0/255, blue: 108/255, alpha: 2))
        navigationController?.navigationBar.setGradientBackground(colors: colors)
        
        //Set interface
        //imageView.moa.url = Eventos.FotoURL
        imageView.sd_setImage(with: URL(string: Eventos.FotoURL))
        nombreEvento.text = Eventos.EveNom
        
        //Contar a los que están inscritos
        //Para cargar
        print("Empezar a contar")
        let ref = Database.database().reference().child("Eventos").child("Eventos Generales").child(Eventos.Eveuid).child("Inscritos")
        ref.observe(.value, with: { (snapshot: DataSnapshot!) in
            print("Got snapshot");
            print(snapshot.childrenCount)
            
            let count = String(snapshot.childrenCount)
            
            self.partinoText.text! = count
        })
        
    }

    @IBAction func reglamentoBoton(_ sender: Any) {
        performSegue(withIdentifier: "miReglamento", sender: nil)
    }
    
    //Preparar el Envio--------------------------
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "participantesEventoInscrito"{
            let nextVC = segue.destination as! ParticipantesTableViewController
            nextVC.Eventos = sender as! Even
        }
    }
    
    @IBAction func participantesBoton(_ sender: Any) {
        let EveId = Eventos
        performSegue(withIdentifier: "participantesEventoInscrito", sender: EveId)
    }
    
    @IBAction func lugarBoton(_ sender: Any) {
        performSegue(withIdentifier: "lugarEventoInscrito", sender: nil)
    }
    
    @IBAction func mensajeBotn(_ sender: Any) {
        performSegue(withIdentifier: "mensajeEventoInscrito", sender: nil)
    }
    
    
}
