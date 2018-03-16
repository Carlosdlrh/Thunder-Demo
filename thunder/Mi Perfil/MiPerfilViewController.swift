//
//  MiPerfilViewController.swift
//  thunder
//
//  Created by CarlosDeLaRocha on 3/11/18.
//  Copyright © 2018 Bonsai. All rights reserved.
//

import UIKit


class MiPerfilViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        //Colores de la barra de estado configuracion obtenida desde el View Controller General
        var colors = [UIColor]()
        colors.append(UIColor(red: 19/255, green: 78/255, blue: 132/255, alpha: 2))
        colors.append(UIColor(red: 143/255, green: 0/255, blue: 108/255, alpha: 2))
        navigationController?.navigationBar.setGradientBackground(colors: colors)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func DisiplinaBoton(_ sender: Any) {
        performSegue(withIdentifier: "perfilDisiplinas", sender: nil)
    }
    
    @IBAction func amigosBoton(_ sender: Any) {
        performSegue(withIdentifier: "perfilAmigos", sender: nil)
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
