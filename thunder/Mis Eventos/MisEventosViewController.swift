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
        print("Revisando tus eventos creados")
        let ref = FIRDatabase.database().reference().child("Usuarios").child(FIRAuth.auth()!.currentUser!.uid).child("Eventos")
        ref.observe(FIRDataEventType.childAdded/*.value*/, with: { snapshot in
            print(snapshot.value!)
            
            let snap = Even()
            //snap.EveNom = snapshot.value(forKeyPath: "Eventos") as! String
            snap.EveNom = snapshot.key
            print(snap.Eveuid)
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
        
        cell.textLabel?.text = evento.EveNom
        
        return cell
    }
    
    
    @IBAction func crearEvento(_ sender: Any) {
        performSegue(withIdentifier: "crearEvento", sender: nil)
    }
    
    @IBAction func eventoBoton(_ sender: Any) {
        performSegue(withIdentifier: "miEvento", sender: nil)
    }
    
    }

