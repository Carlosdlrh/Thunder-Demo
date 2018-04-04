//
//  EventosEquiposTableViewController.swift
//  thunder
//
//  Created by CarlosDeLaRocha on 4/4/18.
//  Copyright © 2018 Bonsai. All rights reserved.
//

import UIKit

class EventosEquiposTableViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 0
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 0
    }

    @IBAction func CrearEvento(_ sender: Any) {
        performSegue(withIdentifier: "CrearEventoEquipoViewController", sender: nil)
    }
}
