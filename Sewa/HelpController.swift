//
//  HelpController.swift
//  Sewa
//
//  Created by Veer Doshi on 11/2/19.
//  Copyright © 2019 Veer Doshi. All rights reserved.
//

import UIKit
import Alamofire
import CoreLocation

class HelpController: UIViewController, CLLocationManagerDelegate {
    
    let locationManager = CLLocationManager()
    
    @IBOutlet weak var problemTextField: UITextView!
    
    @IBOutlet weak var requirementsTextField: UITextView!
    
    @IBOutlet weak var phoneOutlet: UITextField!
    @IBOutlet weak var locationControl: UISegmentedControl!
    
    @IBOutlet weak var nameOutlet: UITextField!
    
    @IBOutlet weak var situationOutlet: UISegmentedControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        problemTextField.text = nil
        problemTextField.textColor = .black
        requirementsTextField.text = nil
        requirementsTextField.textColor = .black
        
        // Do any additional setup after loading the view.
    }
    
    
    @IBAction func submitPressed(_ sender: UIButton) {
        if (locationControl.selectedSegmentIndex == 0) {
            locationServices()
        } else {
            postToDatabase(lat: 0, lon: 0)
        }
    }
    
    func postToDatabase(lat: Float, lon: Float) {
        let name = String(nameOutlet.text ?? "")
        let problem = String(problemTextField.text ?? "")
        let requirements = String(requirementsTextField.text ?? "")
        var situation = ""
        let latitude = lat
        let longitude = lon
        let phonenumber = String(phoneOutlet.text ?? "")
        
        if (situationOutlet.selectedSegmentIndex == 0) {
            situation = "Family Services"
        } else {
            situation = "Natural Disaster"
        }
        
        let parameters: Parameters = ["name": name, "problem": problem, "requirements": requirements, "situation": situation, "latitude":latitude, "longitude":longitude]
        let url = "https://sewa-database.herokuapp.com/help/"
        let appendedURL = url+phonenumber
        Alamofire.request(appendedURL, method: .post, parameters: parameters).responseString { response in
            print(response)
        }
        performSegue(withIdentifier: "requestSubmitted", sender: nil)
    }
    
    func locationServices() {
        let  status = CLLocationManager.authorizationStatus()
        
        switch status {
            
        case .notDetermined:
            locationManager.requestWhenInUseAuthorization()
            return
            
        case .denied, .restricted:
            let alert = UIAlertController(title: "Location Services disabled", message: "Please enable Location Services in Settings", preferredStyle: .alert)
            let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
            alert.addAction(okAction)
            
            present(alert, animated: true, completion: nil)
            return
        case .authorizedAlways, .authorizedWhenInUse:
            break
        }
        
        locationManager.delegate = self
        //locationManager.startUpdatingLocation()
        locationManager.requestLocation()
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let currentLocation = locations.last {
            postToDatabase(lat: Float(currentLocation.coordinate.latitude), lon: Float(currentLocation.coordinate.longitude))
            print("Current location: \(currentLocation.coordinate.longitude)")
        }
    }
   
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error)
        postToDatabase(lat: 0, lon: 0)
    }
    
}
