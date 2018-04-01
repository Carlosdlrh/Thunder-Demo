//
//  ParticipantesTableViewController.swift
//  thunder
//
//  Created by CarlosDeLaRocha on 4/1/18.
//  Copyright © 2018 Bonsai. All rights reserved.
//

import UIKit
import Firebase

class ParticipantesTableViewController: UITableViewController {

    var Eventos = Even()
    
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
        let EventoActual = Eventos.Eveuid
        print(EventoActual)
        
        let ref = Database.database().reference().child("Eventos").child("Eventos Generales").child(EventoActual).child("Inscritos")
        ref.observe(DataEventType.childAdded, with: { snapshot in
            print("Inscritos")
            print(snapshot.value!)
            let snapuno = sujeto()
            
            let eventoDir = snapshot.value as! [String: Any]
            snapuno.sujetoid = eventoDir["UsuarioID"] as! String
            let comparacion = eventoDir["UsuarioID"] as! String
            print(snapuno.sujetoid)
            
            //ya tengo el ID de los sujetos que están inscritos, ahora solo falta obtener su nombre comparando el ID con la base de datos
            //-----------
            
            //Objetos a Comparar
            //Obteniendo toda la información de los usuarios
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
                    snap.sujetoApell = userDir["Apellido"] as! String
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
        let evento = Participantes[indexPath.row]
        //Que aparescan solo los nombres en la tabla
        cell.textLabel?.text = evento.sujetoNom
        return cell
    }
    
    //Preparar para el Envio
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "tiposujeto"{
            let nextVC = segue.destination as! PerfilViewController
            nextVC.tipo = sender as! sujeto
        }
    }
    
    //Selecionar Evento
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let participante = Participantes[indexPath.row]
        performSegue(withIdentifier: "tiposujeto", sender: participante)
    }
}
