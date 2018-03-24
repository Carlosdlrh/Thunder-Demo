//
//  EventosInscritoViewController.swift
//  thunder
//
//  Created by CarlosDeLaRocha on 3/11/18.
//  Copyright © 2018 Bonsai. All rights reserved.
//

import UIKit
import Firebase

class EventosInscritoViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    //Declarar la clase de Eventos para obtener todos los eventos
    var Eventos : [Even] = []
    
    @IBOutlet weak var tableView: UITableView!
    
    
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
        print("Revisando tus eventos Inscrito...")
        //Conectandome directamente con la lista de Eventos Creados por el usuario
        //-------
        
        //Objetos a Comparar
        let uid = Database.database().reference().child("Usuarios").child(Auth.auth().currentUser!.uid).child("Eventos Inscrito")
        uid.observe(DataEventType.childAdded, with: { snaps in
            print(snaps.value!)
            
            let usr = snaps.value as! [String: Any]
            let uidc = usr["EventoID"] as! String
            print("Usuario Inscrito a")
            print(uidc)
            
            let ref = Database.database().reference().child("Eventos").child("Eventos Generales")
            ref.observe(DataEventType.childAdded, with: { snapshot in
                print("Eventos Todos")
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
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Eventos.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        let evento = Eventos[indexPath.row]
        //Que aparescan solo los nombres en la tabla
        cell.textLabel?.text = evento.EveNom
        
        //Ver imagen del Evento en la lista
        cell.imageView?.image = UIImage(named: "PHOTO")
        cell.imageView?.contentMode = .scaleAspectFit
        cell.imageView?.moa.url = evento.FotoURL
        
        self.tableView.rowHeight = UITableViewAutomaticDimension;
        self.tableView.estimatedRowHeight = 44.0;
        
        return cell
    }
    
    //Selecionar Evento
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let evento = Eventos[indexPath.row]
        performSegue(withIdentifier: "eventoInscrito", sender: evento)
        
    }
    //Preparar para el Envio
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "eventoInscrito"{
            let nextVC = segue.destination as! EventoInscritoViewController
            nextVC.Eventos = sender as! Even
        }
        
    }
    
}
