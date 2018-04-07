//
//  EventosEquiposTableViewController.swift
//  thunder
//
//  Created by CarlosDeLaRocha on 4/4/18.
//  Copyright © 2018 Bonsai. All rights reserved.
//

import UIKit
import Firebase
import SDWebImage

class EventosEquiposTableViewController: UITableViewController {

    //Declarar la clase de Eventos para obtener todos los eventos
    var Equipos = Equip()
    var Eventos : [Even] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        //Colores de la barra de estado configuracion obtenida desde el View Controller General
        var colors = [UIColor]()
        colors.append(UIColor(red: 19/255, green: 78/255, blue: 132/255, alpha: 2))
        colors.append(UIColor(red: 143/255, green: 0/255, blue: 108/255, alpha: 2))
        navigationController?.navigationBar.setGradientBackground(colors: colors)
        
        //Conectar Tabla
        //Controles de la tabla de Eventos
        self.tableView.dataSource = self
        self.tableView.delegate = self
        
        //Buscar todos mis eventos creados
        print("Revisando Eventos de Equipo...")
        //Conectandome directamente con la lista de Eventos Creados por el usuario
        //-------
        let EquipoActual = Equipos.Equipuid
        print(EquipoActual)
        
        //Objetos a Comparar
        let uid = Database.database().reference().child("Equipos").child("Equipos Generales").child(EquipoActual).child("Eventos")
        uid.observe(DataEventType.childAdded, with: { snaps in
            print(snaps.value!)
            
            let usr = snaps.value as! [String: Any]
            let uidc = usr["EventoID"] as! String
            print("Usuario Inscrito a:")
            print(uidc)
            
            let ref = Database.database().reference().child("Eventos").child("Eventos Privados").child("Equipos")
            ref.observe(DataEventType.childAdded, with: { snapshot in
                print("Eventos Privados")
                print(snapshot.value!)
                print(ref.key)
                
                let eventoDir = snapshot.value as! [String: Any]
                let comparacion = eventoDir["EventoID"] as! String
                
                //Comparación
                if comparacion == uidc{
                    let snap = Even()
                    
                    print("Sí hay eventos")
                    
                    let eventoDir = snapshot.value as! [String: Any]
                    
                    snap.EveNom = eventoDir["Nombre"] as! String
                    snap.Eveuid = snapshot.key
                    snap.FotoURL = eventoDir["Imagen"] as! String
                    snap.Creadoruid = eventoDir["CreadorID"] as! String
                    
                    //---- Test de immprenta
                    print(snap.Eveuid)
                    print(snap.EveNom)
                    print(snap.FotoURL)
                    print(snap.Creadoruid)
                    
                    self.Eventos.append(snap)
                    self.tableView.reloadData()
                    
                }else{
                    print("Error")
                }
            })
        })
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Eventos.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "CellEventsEquips")
        let evento = Eventos[indexPath.row]
        
        let imageView = cell?.viewWithTag(15) as! UIImageView
        let url = URL(string: evento.FotoURL)
        imageView.sd_setImage(with: url)
        
        let labelView = cell?.viewWithTag(10) as! UILabel
        let eventoname = evento.EveNom
        labelView.text = eventoname
        
        return cell!
    }
    
    //Preparar el Envio--------------------------
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "CrearEventoEquipo"{
            let nextVC = segue.destination as! CrearEventoEquipoViewController
            nextVC.Equipos = sender as! Equip
        }
    }
    
    @IBAction func Crear(_ sender: Any) {
        let EquipId = Equipos
        performSegue(withIdentifier: "CrearEventoEquipo", sender: EquipId)
    }
    
}
