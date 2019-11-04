//
//  VolunteerController.swift
//  Sewa
//
//  Created by Veer Doshi on 11/2/19.
//  Copyright © 2019 Veer Doshi. All rights reserved.
//

import UIKit
import Alamofire

class VolunteerController: UIViewController {

    @IBOutlet weak var name: UITextField!
    @IBOutlet weak var phone: UITextField!
    @IBOutlet weak var state: UITextField!
    
    @IBOutlet weak var communityBool: UISwitch!
    @IBOutlet weak var organizeBool: UISwitch!
    @IBOutlet weak var socialBool: UISwitch!
    @IBOutlet weak var materialBool: UISwitch!
    @IBOutlet weak var webpageBool: UISwitch!
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    
    @IBAction func submit(_ sender: Any) {
        var involvement = ""
        if communityBool.isOn {
            involvement += "Local community service, "
        }
        if organizeBool.isOn {
            involvement += "Plan and organize events, "
        }
        if socialBool.isOn {
            involvement += "Social networking and promotion, "
        }
        if materialBool.isOn {
            involvement += "Design promotional materials, "
        }
        if webpageBool.isOn {
            involvement += "Maintain chapter webpage"
        }
        
        let nameJSON = String(name.text ?? "")
        let phoneJSON = String(phone.text ?? "")
        let stateJSON = String(state.text ?? "")
        
        print(nameJSON)
        print(phoneJSON)
        print(stateJSON)
        print(involvement)
        
        performSegue(withIdentifier: "volunteerSegue", sender: nil)
        
    }
    

}
