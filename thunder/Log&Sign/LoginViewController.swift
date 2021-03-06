//
//  LoginViewController.swift
//  thunder Demo
//
//  Created by CarlosDeLaRocha on 3/11/18.
//  Copyright © 2018 Bonsai. All rights reserved.
//

import UIKit
import Firebase

class LoginViewController: UIViewController, UITextFieldDelegate {
    
    //Botonsitos
    
    @IBOutlet weak var LoginOutlet: UIButton!
    
    @IBOutlet weak var signinOutlet: UIButton!
    
    @IBOutlet weak var nombreTextField: UITextField!

    @IBOutlet weak var apellidoTextField: UITextField!
    
    @IBOutlet weak var loginTextField: UITextField!
    
    @IBOutlet weak var passwordTextField: UITextField!
    
    @IBOutlet var entrarBoton: UIButton!
    
    @IBOutlet weak var registrarOutlet: UIButton!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.nombreTextField.isHidden = true
        self.apellidoTextField.isHidden = true
        self.registrarOutlet.isHidden = true
        self.LoginOutlet.isEnabled = false
        
    }
    //Boton de Acceder
    @IBAction func accessTapped(_ sender: Any) {
        self.signinOutlet.isEnabled = false
        //Acceder a usuario
        Auth.auth().signIn(withEmail: loginTextField.text!, password: passwordTextField.text!, completion: { (user, error) in
            print("Intentamos acceder")
            if error != nil{
                print("Error: \(String(describing: error))")
                print("Usuario no existe")
                self.signinOutlet.isEnabled = true
                
            }else{
                print("Bienbenido:\(String(describing: user))")
                self.performSegue(withIdentifier: "login", sender: nil)
            }
        })
    }
    
    //Boton de Registrarse
    @IBAction func RegistrarBoton(_ sender: Any) {
        self.registrarOutlet.isEnabled = false
        //Crea al usuario
        Auth.auth().createUser(withEmail: loginTextField.text!, password: passwordTextField.text!, completion: { (user, error) in
            print("Intentando Crear Usuario")
            if error != nil{
                print("Error: \(String(describing: error))")
                self.registrarOutlet.isEnabled = true
            }else{
                //Obtener el nombre
                let nombre = self.nombreTextField.text!
                let apellido = self.apellidoTextField.text!
                
                //Quary para conectarse y cargar usuario registrado a base de datos
                let ref = Database.database().reference().child("Usuarios").child(user!.uid)
                //Libreria directa de incrucion de objetos
                let her = ["Nombre":nombre, "Apellido":apellido,"Descripción":"", "Pro":"0", "Email":user!.email, "UserID":user!.uid, "Equipos":"0"]
                
                ref.setValue(her)
                
                print("¡Usuario creado con exito!")
                print("Bienbenido:\(String(describing: user))")
                self.performSegue(withIdentifier: "login", sender: nil)
                
                
            }
        })
    }
    
    //Botones para cambiar de UI
    
    @IBAction func signinBoton(_ sender: Any) {
        self.nombreTextField.isHidden = false
        self.apellidoTextField.isHidden = false
        self.entrarBoton.isHidden = true
        self.registrarOutlet.isHidden = false
        self.LoginOutlet.isEnabled = true
        self.signinOutlet.isEnabled = false
    }
    
    
    @IBAction func LoginBoton(_ sender: Any) {
        self.nombreTextField.isHidden = true
        self.apellidoTextField.isHidden = true
        self.entrarBoton.isHidden = false
        self.registrarOutlet.isHidden = true
        self.LoginOutlet.isEnabled = false
        self.signinOutlet.isEnabled = true
    }
    
    
    //Correcion de teclado!! --------------------
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == loginTextField {
            passwordTextField.becomeFirstResponder()
        }else if textField == passwordTextField{
            textField.resignFirstResponder()
        }
        return true
    }
    

}
