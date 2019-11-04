//
//  AdminLoginController.swift
//  Sewa
//
//  Created by Veer Doshi on 11/3/19.
//  Copyright © 2019 Veer Doshi. All rights reserved.
//

import UIKit

class AdminLoginController: UIViewController {

    @IBOutlet weak var usernameField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    @IBOutlet weak var wrongLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        wrongLabel.isHidden = true
        // Do any additional setup after loading the view.
    }
    
    @IBAction func submitLogin(_ sender: Any) {
        let realUsername = "admin"
        let realPassword = "password"
        let enteredUsername = String(usernameField.text!)
        let enteredPassword = String(passwordField.text!)
        
        if (enteredUsername==realUsername) && (enteredPassword==realPassword) {
            wrongLabel.isHidden = true
            print("correct!!")
            performSegue(withIdentifier: "loginToAdmin", sender: nil)
        } else {
            wrongLabel.isHidden = false
        }
        
    }
    
}
