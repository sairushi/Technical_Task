//
//  addContactViewController.swift
//  phoneBook
//
//  Created by mymac on 23/07/19.
//  Copyright © 2019 mymac. All rights reserved.
//

import UIKit
import CoreData

class addContactViewController: UIViewController {
    
    var titleLbaelText = "New Contact"
    var contact: NSManagedObject? = nil
    var indexpathForContact:IndexPath? = nil

    override func viewDidLoad() {
        super.viewDidLoad()
       titleLbl.text = titleLbaelText
        if let contact = self.contact {
            nameTextField.text = contact.value(forKey: "name") as? String
            phoneNumberTf.text = contact.value(forKey: "phoneNumber") as? String
        }
        // Do any additional setup after loading the view.
    }
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var phoneNumberTf: UITextField!
    
    @IBAction func cancel(_ sender: Any) {
        nameTextField.text = nil
        phoneNumberTf.text = nil
        performSegue(withIdentifier: "backToList", sender: self)
    }
    
    @IBOutlet weak var titleLbl: UILabel!
    @IBAction func save(_ sender: Any) {
     
         performSegue(withIdentifier: "backToList", sender: self)
    }
    
}
