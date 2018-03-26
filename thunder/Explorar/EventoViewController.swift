//
//  EventoViewController.swift
//  thunder
//
//  Created by CarlosDeLaRocha on 3/11/18.
//  Copyright © 2018 Bonsai. All rights reserved.
//

import UIKit
import Firebase
import moa

class EventoViewController: UIViewController {

    var Eventos = Even()
    
    @IBOutlet weak var nombreEvento: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var inscribirseBoton: UIButton!
    @IBOutlet weak var salirBoton: UIButton!
    @IBOutlet weak var costoText: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.salirBoton.isHidden = true
        // Do any additional setup after loading the view.
        
        //Colores de la barra de estado configuracion obtenida desde el View Controller General
        var colors = [UIColor]()
        colors.append(UIColor(red: 19/255, green: 78/255, blue: 132/255, alpha: 2))
        colors.append(UIColor(red: 143/255, green: 0/255, blue: 108/255, alpha: 2))
        navigationController?.navigationBar.setGradientBackground(colors: colors)
        
        //Cargar toda la información en el objeto
        imageView.moa.url = Eventos.FotoURL
        nombreEvento.text = Eventos.EveNom
        
        //Chcar si el costo es mayor o igual a cero para asignar valor como gratuito o no
        let costoval = Eventos.costo
        if costoval == "Gratuito"{
            costoText.text = costoval
        }else{
            costoText.text = "$ "+costoval
        }
        
        //Revisar si ya estás inscrito
        //Buscar todos mis eventos creados
        print("Revisando Todos los eventos creados...")
        //Conectandome directamente con la lista de Eventos Creados por el usuario
        let ref = Database.database().reference().child("Eventos").child("Eventos Generales").child(Eventos.Eveuid).child("Inscritos")
        
        //Cuando un Child es agregado al identificador de Eventos se puede acceder directamente a el con solo mensionarlo como clave
        ref.observe(DataEventType.childAdded, with: { snapshot in
            print(snapshot.value!)
            
            
            //Objetos a Comparar para saber si el usuario está inscrito
            let uid = Database.database().reference().child("Usuarios").child(Auth.auth().currentUser!.uid)
            let uidc = uid.key
            
            let eventoDir = snapshot.value as! [String: Any]
            let comparacion1 = eventoDir["UsuarioID"] as! String
            
            //Comparación
            if comparacion1 == uidc{
                //Deshabilitar boton
                self.inscribirseBoton.isHidden = true
                self.salirBoton.isHidden = false
            }else{
                print("Error")
            }
        })
        
    }
    
    //Boton de Inscribirse
    @IBAction func inscribirseBoton(_ sender: Any) {
        
        //Buscar todos mis eventos creados
        print("Revisando eventos creados...")
        //Conectandome directamente con la lista de Eventos Creados
        let ref = Database.database().reference().child("Eventos").child("Eventos Generales").child(Eventos.Eveuid).child("Inscritos").childByAutoId()
        
        //Conectandose con el usuario
        let ref1 = Database.database().reference().child("Usuarios").child(Auth.auth().currentUser!.uid)
        let user = ref1.key
        print(user)
        let her = ["UsuarioID":user]
        
        ref.setValue(her)
        
        //refereiar el evento para que se guarde en la lsita de eventos inscritos del usuario
        ref1.child("Eventos Inscrito").childByAutoId().child("EventoID").setValue(Eventos.Eveuid)
        
        navigationController!.popToRootViewController(animated: true)
        
    }
    
    @IBAction func salirBoton(_ sender: Any) {
    }
    
    
    //Botones de la plantilla --------------------------------------
    @IBAction func reglamentoBoton(_ sender: Any) {
        performSegue(withIdentifier: "eventoReglamento", sender: nil)
    }
    
    
    @IBAction func lugarBoton(_ sender: Any) {
        performSegue(withIdentifier: "eventoLugar", sender: nil)
    }
    
    @IBAction func mensajeBoton(_ sender: Any) {
        performSegue(withIdentifier: "mensajeEvento", sender: nil)
    }
    
    //Preparar el Envio--------------------------
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "eventoParticipantes"{
            let nextVC = segue.destination as! ParticipantesViewController
            nextVC.Eventos = sender as! Even
        }
    }
        
        @IBAction func participanteBoton(_ sender: Any) {
            let EveId = Eventos
            performSegue(withIdentifier: "eventoParticipantes", sender: EveId)
        }
    
}
