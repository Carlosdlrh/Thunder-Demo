//
//  MisEventosViewController.swift
//  thunder
//
//  Created by CarlosDeLaRocha on 3/11/18.
//  Copyright © 2018 Bonsai. All rights reserved.
//

import UIKit
import Firebase

class MisEventosViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    var Eventos : [Even] = []
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        //Colores de la barra de estado configuracion obtenida desde el View Controller General
        print("cargando UI")
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
            
            //Objetos a Comparar
            let uid = Database.database().reference().child("Usuarios").child(Auth.auth().currentUser!.uid)
            let uidc = uid.key
            
            let eventoDir = snapshot.value as! [String: Any]
            let comparacion1 = eventoDir["CreadorID"] as! String
            
            //Comparación
            if comparacion1 == uidc{
                snap.EveNom = eventoDir["Nombre"] as! String
                snap.Eveuid = snapshot.key
                
                //---- Test de immprenta
                print(snap.Eveuid)
                print(snap.EveNom)
                
                self.Eventos.append(snap)
                self.tableView.reloadData()
            }else{
                print("Error")
            }
        })
    }
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Eventos.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        let evento = Eventos[indexPath.row]
        
        cell.textLabel?.text = evento.EveNom
        
        return cell
    }
    //Selecionar Evento
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let evento = Eventos[indexPath.row]
        performSegue(withIdentifier: "miEvento", sender: evento)
        
    }
    //Preparar para el Envio
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "miEvento"{
            let nextVC = segue.destination as! MiEventoViewController
            nextVC.Eventos = sender as! Even
        }
        
    }
    
    @IBAction func crearEvento(_ sender: Any) {
        performSegue(withIdentifier: "crearEvento", sender: nil)
    }
    
    @IBAction func eventoBoton(_ sender: Any) {
        performSegue(withIdentifier: "miEvento", sender: nil)
    }
    
    }

