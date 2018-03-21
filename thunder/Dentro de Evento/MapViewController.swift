//
//  MapViewController.swift
//  thunder
//
//  Created by CarlosDeLaRocha on 3/20/18.
//  Copyright © 2018 Bonsai. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class MapViewController: UIViewController, MKMapViewDelegate, CLLocationManagerDelegate {

    @IBOutlet weak var Map: MKMapView!
    
    let locationManager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        // Designar esto a un objeto
        let lugar = "Lugar"
        let descrip = "Descrip"
        let lat = 22.1289
        let long = -101.0401
        
        //Llamar a cordenadas y meterlas a un objeto
        let location = CLLocationCoordinate2DMake(lat, long)
        let span = MKCoordinateSpanMake(0.002, 0.002)
        let region = MKCoordinateRegion(center: location,span: span)
        
        Map.setRegion(region, animated: true)
        
        let annotation = MKPointAnnotation()
        annotation.coordinate = location
        annotation.title = lugar
        annotation.subtitle = descrip
        
        Map.addAnnotation(annotation)
        
        //-----------------
        super.viewDidLoad()
        
        Map.showsUserLocation = true
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
