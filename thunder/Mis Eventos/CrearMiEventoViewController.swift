//
//  CrearMiEventoViewController.swift
//  thunder
//
//  Created by CarlosDeLaRocha on 3/15/18.
//  Copyright © 2018 Bonsai. All rights reserved.
//

import UIKit
import Firebase

class CrearMiEventoViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UITextFieldDelegate {
    
    var Eventos = Even()
    
    //Agregar controles para selecionar una imagen
    var imagePicker = UIImagePickerController()
    
    @IBOutlet weak var nombreEventoTextField: UITextField!
    
    @IBOutlet weak var imageView: UIImageView!
    
    @IBOutlet weak var crearBoton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        imagePicker.delegate = self
    }
    
    //Controles de fondo de la imagen cuando se termina de selecionar //Selecionar imagen
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        let image = info ["UIImagePickerControllerOriginalImage"] as! UIImage
        imageView.image = image
        print(image.size)
        imageView.backgroundColor = UIColor.clear
        imagePicker.dismiss(animated: true, completion: nil)
        
    }
    //Boton de selecionar imagen
    @IBAction func cameraTapped(_ sender: Any) {
        
        imagePicker.sourceType = .savedPhotosAlbum
        imagePicker.allowsEditing = false
        
        present(imagePicker,animated: true, completion: nil)
    }
    
    //Crear Evento Boton
    @IBAction func crearBoton(_ sender: Any) {
        self.crearBoton.isEnabled = false
        
        //Agregar cosas a firebase
        //Creas un objeto que sostenga ese codigo "imagesFolder"
        let imagesFolder = Storage.storage().reference().child("Imagenes").child("Eventos")
        let imagesData = UIImageJPEGRepresentation(imageView.image!, 0.1)
        
        //Esto es para darle un numero unico a la foto -> NSUUID().uuidString
        imagesFolder.child("\(NSUUID().uuidString).JPG").putData(imagesData!, metadata: nil) { (metadata, error) in
            print("se intentó cargar la imagen")
            if error != nil {
                print("Error en cargar la imagen:\(String(describing: error)) ")
                self.crearBoton.isEnabled = true
            }else{
                //Imprimir donde están las imagenes
                let URLdeImagen = metadata?.downloadURL as Any
                print(URLdeImagen)
            }
            
            let URLdeImagen = metadata?.downloadURL()!.absoluteString as Any
            
            //Mi libreria para conectarse
            //Creador guardarlo para pasarlo como Creador del Evento
            let ref1 = Database.database().reference().child("Usuarios").child(Auth.auth().currentUser!.uid)
            let creador = ref1.key
            print(creador)
            
            let her = ["CreadorID":creador, "Nombre":self.nombreEventoTextField!.text!, "Inscritos": "0", "Mensajes":"0", "Imagen":URLdeImagen] as [String : Any]
            
            //Conexion y guardar todo en base de datos
            //Guardar el Id del Evento en el usuario
            let ref = Database.database().reference().child("Eventos").child("Eventos Generales").childByAutoId()
            ref.setValue(her)
            
            //Si todo sale bien hacemos el segue
            print("Todo correcto!")
            self.navigationController!.popToRootViewController(animated: true)
        }
    }
    
    @IBAction func cancelarBoton(_ sender: Any) {
    navigationController!.popToRootViewController(animated: true)
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {//Controles para quitar el teclado de la pantalla
        self.view.endEditing(true)
    }
    
    /*override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        //Tomar todo lo ya escrito y enviarlo a la pantalla de evento
        //let nextVC = segue.destination as! MiEventoViewController
        //nextVC.Eventos = sender as! Even

    }*/
    
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == nombreEventoTextField {
            nombreEventoTextField.becomeFirstResponder()
        }
        return true
    }
    
}
