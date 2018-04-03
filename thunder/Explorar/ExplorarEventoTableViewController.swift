//
//  ExplorarEventoTableViewController.swift
//  thunder
//
//  Created by CarlosDeLaRocha on 3/30/18.
//  Copyright © 2018 Bonsai. All rights reserved.
//

import UIKit
import Firebase
import SDWebImage

class ExplorarEventoTableViewController: UITableViewController {
    
    var Eventos : [Even] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        //Colores de la barra de estado configuracion obtenida desde el View Controller General
        var colors = [UIColor]()
        colors.append(UIColor(red: 19/255, green: 78/255, blue: 132/255, alpha: 2))
        colors.append(UIColor(red: 143/255, green: 0/255, blue: 108/255, alpha: 2))
        navigationController?.navigationBar.setGradientBackground(colors: colors)
        
        //Cargar tabla
        print("Cargando Tabla")
        self.tableView.dataSource = self
        self.tableView.delegate = self
        
        //Buscar todos mis eventos creados
        print("Revisando tus eventos creados...")
        //Conectandome directamente con la lista de Eventos Creados por el usuario
        let ref = Database.database().reference().child("Eventos").child("Eventos Generales")
        
        
        //Cuando un Child es agregado al identificador de Eventos se puede acceder directamente a el con solo mensionarlo como clave
        ref.observe(DataEventType.childAdded, with: { snapshot in
            print(snapshot.value!)
            let snap = Even()
            
            let eventoDir = snapshot.value as! [String: Any]
            
            snap.EveNom = eventoDir["Nombre"] as! String
            snap.Eveuid = snapshot.key
            snap.FotoURL = eventoDir["Imagen"] as! String
            snap.Creadoruid = eventoDir["CreadorID"] as! String
            snap.costo = eventoDir["CostoEntradas"] as! String
            
            //---- Test de immprenta
            print(snap.Eveuid)
            print(snap.EveNom)
            print(snap.FotoURL)
            print(snap.Creadoruid)
            
            self.Eventos.append(snap)
            self.tableView.reloadData()
        })
        
    }
    
    //Preparar el Envio--------------------------
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "explorarEvento"{
            let nextVC = segue.destination as! EventoViewController
            nextVC.Eventos = sender as! Even
        }
        
    }
    
    //Funciones de la tabla----------------------
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Eventos.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell")
        let evento = Eventos[indexPath.row]
        
        let imageView = cell?.viewWithTag(2) as! UIImageView
        let url = URL(string: evento.FotoURL)
        imageView.sd_setImage(with: url)
 
        let labelView = cell?.viewWithTag(3) as! UILabel
        let eventoname = evento.EveNom
        labelView.text = eventoname
        
        
        return cell!
    }
    
    //Selecionar Evento
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let evento = Eventos[indexPath.row]
        performSegue(withIdentifier: "explorarEvento", sender: evento)
        
    }

}
