//
//  ExplorarEventoViewController.swift
//  thunder
//
//  Created by CarlosDeLaRocha on 3/12/18.
//  Copyright © 2018 Bonsai. All rights reserved.
//

import UIKit
import Firebase

class ExplorarEventoViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

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
        
        //Cargar tabla
        print("Cargando Tabla")
        self.tableView.dataSource = self
        self.tableView.delegate = self
        
        //Buscar todos mis eventos creados
        print("Revisando tus eventos creados...")
        //Conectandome directamente con la lista de Eventos Creados por el usuario
        let ref = FIRDatabase.database().reference().child("Eventos").child("Eventos Generales")
        
        
        //Cuando un Child es agregado al identificador de Eventos se puede acceder directamente a el con solo mensionarlo como clave
        ref.observe(FIRDataEventType.childAdded, with: { snapshot in
            print(snapshot.value!)
            let snap = Even()
            
            let eventoDir = snapshot.value as! [String: Any]
            
            snap.EveNom = eventoDir["Nombre"] as! String
            snap.Eveuid = snapshot.key
            
            //---- Test de immprenta
            print(snap.Eveuid)
            print(snap.EveNom)
            
            self.Eventos.append(snap)
            self.tableView.reloadData()
        })

    }
    
    
    @IBAction func explorarBoton(_ sender: Any) {
        performSegue(withIdentifier: "explorarEvento", sender: nil)
    }
    
    @IBAction func mundoBoton(_ sender: Any) {
        performSegue(withIdentifier: "mundoEventos", sender: nil)
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
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
