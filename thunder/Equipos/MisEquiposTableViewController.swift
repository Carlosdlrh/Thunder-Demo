//
//  MisEquiposTableViewController.swift
//  thunder
//
//  Created by CarlosDeLaRocha on 3/28/18.
//  Copyright © 2018 Bonsai. All rights reserved.
//

import UIKit
import Firebase
import moa

class MisEquiposTableViewController: UITableViewController {

    var Equipos : [Equip] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        //Colores de la barra de estado configuracion obtenida desde el View Controller General
        var colors = [UIColor]()
        colors.append(UIColor(red: 19/255, green: 78/255, blue: 132/255, alpha: 2))
        colors.append(UIColor(red: 143/255, green: 0/255, blue: 108/255, alpha: 2))
        navigationController?.navigationBar.setGradientBackground(colors: colors)
        
        //Buscar todos mis Equipos creados
        print("Revisando tus Equipos creados...")
        //Conectandome directamente con la lista de Equipos Creados por el usuario
        let ref = Database.database().reference().child("Equipos").child("Equipos Generales")
        
        //Cuando un Child es agregado al identificador de Equipos se puede acceder directamente a el con solo mensionarlo como clave
        ref.observe(DataEventType.childAdded, with: { snapshot in
            print(snapshot.value!)
            let snap = Equip()
            
            //Objetos a Comparar
            let uid = Database.database().reference().child("Usuarios").child(Auth.auth().currentUser!.uid)
            let uidc = uid.key
            
            let eventoDir = snapshot.value as! [String: Any]
            let comparacion1 = eventoDir["CreadorID"] as! String
            
            //Comparación
            if comparacion1 == uidc{
                snap.EquipNom = eventoDir["Nombre"] as! String
                snap.Equipuid = snapshot.key
                snap.FotoURL = eventoDir["Imagen"] as! String
                snap.Creadoruid = eventoDir["CreadorID"] as! String
                
                //---- Test de immprenta
                print(snap.Equipuid)
                print(snap.EquipNom)
                print(snap.FotoURL)
                print(snap.Creadoruid)
                
                self.Equipos.append(snap)
                self.tableView.reloadData()
                
            }else{
                print("Error")
            }
        })
        
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Equipos.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        let Equips = Equipos[indexPath.row]
        //Que aparescan solo los nombres en la tabla
        cell.textLabel?.text = Equips.EquipNom
        
        //Ver imagen del Evento en la lista
        cell.imageView?.image = UIImage(named: "PHOTO")
        cell.imageView?.contentMode = .scaleAspectFit
        cell.imageView?.moa.url = Equips.FotoURL
        
        self.tableView.rowHeight = UITableViewAutomaticDimension;
        self.tableView.estimatedRowHeight = 44.0;
        
        return cell
    }
    
    //Selecionar Evento
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let evento = Equipos[indexPath.row]
        performSegue(withIdentifier: "miEquipo", sender: evento)
        
    }
    //Preparar para el Envio
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "miEquipo"{
            let nextVC = segue.destination as! MiEquipoViewController
            nextVC.Equipos = sender as! Equip
        }
        
    }
    
    @IBAction func crearEquipo(_ sender: Any) {
        performSegue(withIdentifier: "crearEquipo", sender: nil)
    }
    
}
