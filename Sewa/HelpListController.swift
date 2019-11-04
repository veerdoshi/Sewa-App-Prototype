//
//  HelpListController.swift
//  Sewa
//
//  Created by Veer Doshi on 11/3/19.
//  Copyright © 2019 Veer Doshi. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class HelpListController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    var data: [String] = []

    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        getList()
    }
    
    func getList() {
        let url = "https://sewa-database.herokuapp.com/helplist"
        var countJSON : Int = 0
        Alamofire.request(url, method: .get).responseJSON {
            response in
            print("Success! Got the help data")
            let helpJSON : JSON = JSON(response.result.value!)
            countJSON = Int(helpJSON["helplist"].count - 1)
            
            for n in 0...countJSON {
                let givenName = String(helpJSON["helplist"][n]["name"].string ?? "")
                let phoneNumber = String(helpJSON["helplist"][n]["phonenumber"].string ?? "")
                let entity = "\(givenName), \(phoneNumber)"
                self.data.append(entity)
            }
            self.tableView.reloadData()
        }
    }
    

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = data[indexPath.row]
        return cell
    }

}
