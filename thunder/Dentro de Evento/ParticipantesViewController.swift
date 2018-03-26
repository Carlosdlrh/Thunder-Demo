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
    
    var Eventos = Even()
    
    var Participante : [sujeto] = []
    
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
        let snaph = Eventos.Eveuid
        print(snaph)
        let ref = Database.database().reference().child("Eventos").child("Eventos Generales").child(snaph).child("Inscritos")
        ref.observe(DataEventType.childAdded, with: { snapshot in
            print(snapshot.value!)
            let snapuno = sujeto()
            
            let eventoDir = snapshot.value as! [String: Any]
            snapuno.sujetoid = eventoDir["UsuarioID"] as! String
            print(snapuno.sujetoid)
            
            //ya tengo el ID de los sujetos que están inscritos, ahora solo falta obtener su nombre comparando el ID con la base de datos
            
            self.Participante.append(snapuno)
            self.tableView.reloadData()
            
            
        })
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Participante.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        let evento = Participante[indexPath.row]
        //Que aparescan solo los nombres en la tabla
        cell.textLabel?.text = evento.sujetoid
        
        
        return cell
    }
    

}
