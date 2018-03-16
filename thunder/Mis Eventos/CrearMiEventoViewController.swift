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
        //Conexion
        let ref = FIRDatabase.database().reference().child("Usuarios").child(FIRAuth.auth()!.currentUser!.uid).child("Eventos")
        let nomb = nombreEventoTextField!.text!
        ref.child("\(nomb)").child("Inscritos").setValue("0")
        ref.child("\(nomb)").child("Mensajes").setValue("0")
    }
    
    @IBAction func cancelarBoton(_ sender: Any) {
        //performSegue(withIdentifier: <#T##String#>, sender: <#T##Any?#>)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == nombreEventoTextField {
            nombreEventoTextField.becomeFirstResponder()
        }
        return true
    }
    
}
