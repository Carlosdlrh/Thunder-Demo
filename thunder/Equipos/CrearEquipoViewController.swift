//
//  CrearEquipoViewController.swift
//  thunder
//
//  Created by CarlosDeLaRocha on 3/29/18.
//  Copyright © 2018 Bonsai. All rights reserved.
//

import UIKit
import Firebase

class CrearEquipoViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    var Eventos = Even()
    
    //Agregar controles para selecionar una imagen
    var imagePicker = UIImagePickerController()
    
    @IBOutlet weak var nombreEquipoTextField: UITextField!
    
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

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //Crear Evento Boton
    @IBAction func crearBoton(_ sender: Any) {
        self.crearBoton.isEnabled = false
        
        //Agregar cosas a firebase
        //Creas un objeto que sostenga ese codigo "imagesFolder"
        let imagesFolder = Storage.storage().reference().child("Imagenes").child("Equiposa")
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
            let nombEquip =  self.nombreEquipoTextField!.text!
            
            //Conexion y guardar todo en base de datos
            //Guardar el Id del Evento en el usuario
            let ref = Database.database().reference().child("Equipos").child("Equipos Generales").childByAutoId()
            let EquipID = ref.key
            
            let her = ["EquipoID":EquipID, "CreadorID":creador, "Nombre":nombEquip, "Inscritos": "0", "Imagen":URLdeImagen, "Eventos":"0"] as [String : Any]
            
            ref.setValue(her)
            
            //Guardar al participante creador como participante
            let participante = ref.child("Inscritos").childByAutoId()
            participante.child("UsuarioID").setValue(creador)
            
            //Guardar el ID del Equipo en el ID del creador
            let Equipcreado = ref1.child("Equipos").child("Equipos Creados").childByAutoId().child("EquipoID")
            Equipcreado.setValue(EquipID)
            
            //Si todo sale bien hacemos el segue
            print("Todo correcto!")
            self.navigationController!.popToRootViewController(animated: true)
        }
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
