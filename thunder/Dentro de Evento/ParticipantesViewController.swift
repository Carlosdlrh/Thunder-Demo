//
//  ParticipantesViewController.swift
//  thunder
//
//  Created by CarlosDeLaRocha on 3/21/18.
//  Copyright © 2018 Bonsai. All rights reserved.
//

import UIKit
import Firebase

class ParticipantesViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    var Eventos : [Even] = []
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        //Cargar tabla
        print("Cargando Tabla")
        self.tableView.dataSource = self
        self.tableView.delegate = self
        
        //Buscar todos mis eventos creados
        print("Revisando Usuarios inscritos...")
        //Conectandome directamente con la lista de Eventos Creados por el usuario
        let snap = Even()
        let ref = Database.database().reference().child("Eventos").child("Eventos Generales").child(snap.Eveuid).child("Inscritos")
        ref.observe(DataEventType.childAdded, with: { snapshot in
            print(snapshot.value!)
            let snap = Even()
            
            let eventoDir = snapshot.value as! [String: Any]
            
            snap.InscritoId = eventoDir["Nombre"] as! String
            
            print(snap.InscritoId)
            
            self.Eventos.append(snap)
            self.tableView.reloadData()
        })
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Eventos.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        let evento = Eventos[indexPath.row]
        //Que aparescan solo los nombres en la tabla
        cell.textLabel?.text = evento.InscritoId
        
        
        return cell
    }
    

}
