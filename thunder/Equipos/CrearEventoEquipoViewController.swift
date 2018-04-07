//
//  CrearEventoEquipoViewController.swift
//  thunder
//
//  Created by CarlosDeLaRocha on 4/4/18.
//  Copyright © 2018 Bonsai. All rights reserved.
//

import UIKit
import Firebase

class CrearEventoEquipoViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UITextFieldDelegate {
    
    var Eventos = Even()
    var Equipos = Equip()
    
    //Agregar controles para selecionar una imagen
    var imagePicker = UIImagePickerController()
    
    @IBOutlet weak var nombreEventoTextField: UITextField!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var crearBoton: UIButton!
    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet weak var timePicker: UIDatePicker!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        datePicker.textColor = .white
        timePicker.textColor = .white
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
                print("Imagen URL")
                print(URLdeImagen)
            }
            
            let URLdeImagen = metadata?.downloadURL()!.absoluteString as Any
            
            //Mi libreria para conectarse
            //Creador guardarlo para pasarlo como Creador del Evento
            let ref1 = Database.database().reference().child("Usuarios").child(Auth.auth().currentUser!.uid)
            let creador = ref1.key
            print(creador)
            
            //Nombre del Evento
            let nombEve =  self.nombreEventoTextField!.text!
            
            //Conexion y guardar todo en base de datos
            //Guardar el Id del Evento en el usuario
            let ref = Database.database().reference().child("Eventos").child("Eventos Privados").child("Equipos").childByAutoId()
            let EveID = ref.key
            
            let her = ["EventoID":EveID, "CreadorID":creador, "Nombre":nombEve, "Inscritos": "0", "Imagen":URLdeImagen, "EquipoID":""] as [String : Any]
            
            ref.setValue(her)
            
            //Guardar el ID Del Evento en una lista de eventos de equipo
            //let refequip = 
            
            //Si todo sale bien hacemos el segue
            print("Todo correcto!")
            self.navigationController!.popToRootViewController(animated: true)
            
            //Guardar al participante creador como participante
            let participante = ref.child("Inscritos").childByAutoId()
            participante.child("UsuarioID").setValue(creador)
            
            //Guardar el ID del Equipo
            let equipid = self.Equipos.Equipuid
            let equip = ref.child("EquipoID")
            equip.setValue(equipid)
            
            //Guardar el ID del Evento en una lista de eventos
            let refevequip = Database.database().reference().child("Equipos").child("Equipos Generales").child(equipid).child("Eventos").childByAutoId().child("EventoID")
            refevequip.setValue(EveID)
        }
    }
    
    @IBAction func cancelarBoton(_ sender: Any) {
        navigationController!.popToRootViewController(animated: true)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {//Controles para quitar el teclado de la pantalla
        self.view.endEditing(true)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == nombreEventoTextField {
            nombreEventoTextField.becomeFirstResponder()
        }
        return true
    }
    
}
