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
        
        //Crear Conexion
        //Buscar todos los eventos creados
        let ref = Database.database().reference().child("Usuarios").childByAutoId()
        
        ref.child("Eventos").observe(.value, with: { snapshot in
            print(snapshot.value!)
            /*let snap = Even()
            snap.EveNom = snapshot.value(forKeyPath: "MiEvento") as! String
            print(snap.Eveuid)*/
        })
        
    }
    
    
    @IBAction func eventoBoton(_ sender: Any) {
        performSegue(withIdentifier: "eventoInscrito", sender: nil)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Eventos.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        
        //let Event = Eventos[indexPath.row]
        //cell.textLabel?.text = Event.email
        
        return cell
    }
}
