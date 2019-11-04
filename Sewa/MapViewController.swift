//
//  MapViewController.swift
//  Sewa
//
//  Created by Veer Doshi on 11/3/19.
//  Copyright © 2019 Veer Doshi. All rights reserved.
//

import UIKit
import MapKit
import Alamofire
import SwiftyJSON

class MapViewController: UIViewController {

    @IBOutlet weak var mapView: MKMapView!
    override func viewDidLoad() {
        super.viewDidLoad()
        //mapView.delegate = self as! MKMapViewDelegate
        plotLocations()

        // Do any additional setup after loading the view.
    }
    
    func plotLocations() {
        let url = "https://sewa-database.herokuapp.com/helplist"
        
        Alamofire.request(url, method: .get).responseJSON {
            response in
            if response.result.isSuccess {
                print("Success! Got the help data")
                let helpJSON : JSON = JSON(response.result.value!)
                let countJSON : Int = helpJSON["helplist"].count - 1
                print(countJSON)
                
                let span = MKCoordinateSpan.init(latitudeDelta: 100, longitudeDelta: 100)
                
                for n in 0...countJSON {
                    let location = CLLocationCoordinate2D(latitude:helpJSON["helplist"][n]["latitude"].double!, longitude: helpJSON["helplist"][n]["longitude"].double!)
                    let region = MKCoordinateRegion(center: location, span: span)
                    self.mapView.setRegion(region, animated: true)
                    
                    let annotation = MKPointAnnotation()
                    annotation.coordinate = location
                    annotation.title = "\(helpJSON["helplist"][n]["situation"].string!)"
                    annotation.subtitle = "Name: \(helpJSON["helplist"][n]["name"].string!), Phone #: \(helpJSON["helplist"][n]["phonenumber"].string!)"
                    self.mapView.addAnnotation(annotation)
                }
                    
            } else {
                print("Error \(String(describing: response.result.error))")
            }
        }
           
    }

    @IBAction func refresh(_ sender: Any) {
        plotLocations()
    }
    
}
