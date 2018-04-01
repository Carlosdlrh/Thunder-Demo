//
//  MiPerfilViewController.swift
//  thunder
//
//  Created by CarlosDeLaRocha on 3/11/18.
//  Copyright © 2018 Bonsai. All rights reserved.
//

import UIKit
import Firebase

class MiPerfilViewController: UIViewController {
    
    @IBOutlet weak var nombreText: UILabel!
    @IBOutlet weak var apellidoText: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        //Colores de la barra de estado configuracion obtenida desde el View Controller General
        var colors = [UIColor]()
        colors.append(UIColor(red: 19/255, green: 78/255, blue: 132/255, alpha: 2))
        colors.append(UIColor(red: 143/255, green: 0/255, blue: 108/255, alpha: 2))
        navigationController?.navigationBar.setGradientBackground(colors: colors)
        
        let userID = Auth.auth().currentUser?.uid
        let ref = Database.database().reference().child("Usuarios")
        ref.child(userID!).observeSingleEvent(of: .value, with: { (snapshot) in
            // Get user name
            let value = snapshot.value as? NSDictionary
            let username = value?["Nombre"] as? String ?? ""
            self.nombreText.text = username
            
            // Get user lastname
            let userlast = value?["Apellido"] as? String ?? ""
            self.apellidoText.text = userlast
            
        }) { (error) in
            print(error.localizedDescription)
        }
        
    }
    
    @IBAction func MisEventos(_ sender: Any) {
        performSegue(withIdentifier: "MisEventos", sender: nil)
    }
    
    
    @IBAction func DisiplinaBoton(_ sender: Any) {
        performSegue(withIdentifier: "perfilDisiplinas", sender: nil)
    }
    
    @IBAction func amigosBoton(_ sender: Any) {
        performSegue(withIdentifier: "perfilAmigos", sender: nil)
    }
    

}
