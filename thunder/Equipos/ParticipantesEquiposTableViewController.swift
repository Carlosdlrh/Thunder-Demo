//
//  ParticipantesEquiposTableViewController
//  thunder
//
//  Created by CarlosDeLaRocha on 3/29/18.
//  Copyright © 2018 Bonsai. All rights reserved.
//

import UIKit
import Firebase

class ParticipantesEquiposTableViewController: UITableViewController {

    var Equipos = Equip()
    
    var Participantes : [sujeto] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        //Cargar tabla
        print("Cargando Tabla")
        self.tableView.dataSource = self
        self.tableView.delegate = self
        
        //Buscar todos mis eventos creados
        print("Revisando Usuarios inscritos...")
        //Conectandose con el Evento actual
        print("Conectandose con el evento actual")
        //Conectandome directamente con la lista de Eventos Creados por el usuario
        let EquipoActual = Equipos.Equipuid
        print(EquipoActual)
        
        let ref = Database.database().reference().child("Equipos").child("Equipos Generales").child(EquipoActual).child("Inscritos")
        ref.observe(DataEventType.childAdded, with: { snapshot in
            print("Inscritos")
            print(snapshot.value!)
            let snapuno = sujeto()
            
            let EquipoDir = snapshot.value as! [String: Any]
            snapuno.sujetoid = EquipoDir["UsuarioID"] as! String
            let comparacion = EquipoDir["UsuarioID"] as! String
            print(snapuno.sujetoid)
            
            //ya tengo el ID de los sujetos que están inscritos, ahora solo falta obtener su nombre comparando el ID con la base de datos
            //-----------
            
            //Objetos a Comparar
            
            let uid = Database.database().reference().child("Usuarios")
            uid.observe(DataEventType.childAdded, with: { snaps in
                print("Todo el Paticipante:")
                print(snaps.value!)
                
                let usr = snaps.value as! [String: Any]
                let uidc = usr["UserID"] as! String
                print("ID del Paticipante:")
                print(uidc)
                
                if comparacion == uidc{
                    let snap = sujeto()
                    
                    print("Sí hay participantes")
                    
                    let userDir = snaps.value as! [String: Any]
                    
                    snap.sujetoNom = userDir["Nombre"] as! String
                    snap.sujetoid = snaps.key
                    
                    //---- Test de immprenta
                    print(snap.sujetoid)
                    print(snap.sujetoNom)
                    
                    self.Participantes.append(snap)
                    self.tableView.reloadData()
                    
                }else{
                    print("Error")
                }
                
            })
            
        })
        
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Participantes.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        let equipo = Participantes[indexPath.row]
        //Que aparescan solo los nombres en la tabla
        cell.textLabel?.text = equipo.sujetoNom
        
        return cell
    }
    
}
