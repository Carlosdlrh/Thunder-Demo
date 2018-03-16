//
//  CrearMiEventoViewController.swift
//  thunder
//
//  Created by CarlosDeLaRocha on 3/15/18.
//  Copyright © 2018 Bonsai. All rights reserved.
//

import UIKit
import Firebase

class CrearMiEventoViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var nombreEventoTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func crearBoton(_ sender: Any) {
        
        //Mi libreria para conectarse
        let her = ["Nombre":nombreEventoTextField!.text!, "Inscritos": "0", "Mensajes":"0"]
        
        //Conexion y guardar todo en base de datos
        let ref = FIRDatabase.database().reference().child("Usuarios").child(FIRAuth.auth()!.currentUser!.uid).child("Eventos").child("Mis Eventos")
            ref.childByAutoId().setValue(her)
        
        performSegue(withIdentifier: "creado", sender: nil)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {//Controles para quitar el teclado de la pantalla
        self.view.endEditing(true)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        //Tomar todo lo ya escrito y enviarlo a la pantalla de evento
        let nextVC = segue.destination as! MiEventoViewController
        nextVC.nombre = nombreEventoTextField.text!
    }
    

    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == nombreEventoTextField {
            nombreEventoTextField.becomeFirstResponder()
        }
        return true
    }
    
}
