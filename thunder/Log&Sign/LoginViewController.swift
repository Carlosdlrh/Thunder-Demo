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
    
    @IBOutlet weak var loginTextField: UITextField!
    
    @IBOutlet weak var passwordTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
    }
    
    @IBAction func accessTapped(_ sender: Any) {
        //Acceder a usuario
        FIRAuth.auth()?.signIn(withEmail: loginTextField.text!, password: passwordTextField.text!, completion: { (user, error) in
            print("Intentamos acceder")
            if error != nil{
                print("Error: \(String(describing: error))")
                //Acceder a usuario
                FIRAuth.auth()?.createUser(withEmail: self.loginTextField.text!, password: self.passwordTextField.text!, completion: { (user, error) in
                    print("Intentando Crear Usuario")
                    if error != nil{
                        print("Error: \(String(describing: error))")
                    }else{
                        print("¡Usuario creado con exito!")
                        //Quary para conectarse y cargar usuario registrado a base de datos
                        let ref = FIRDatabase.database().reference().child("Usuarios").child(user!.uid)
                        
                        ref.child("email").setValue(user!.email!)
                        ref.child("nombre").setValue(String(""))
                        
                        print("Bienbenido:\(String(describing: user))")
                        self.performSegue(withIdentifier: "login", sender: nil)
                    }
                })
            }else{
                print("Bienbenido:\(String(describing: user))")
                self.performSegue(withIdentifier: "login", sender: nil)
            }
        })
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
    
    
    /*----------------------------
     
     override func didReceiveMemoryWarning() {
     super.didReceiveMemoryWarning()
     // Dispose of any resources that can be recreated.
     }
     
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
