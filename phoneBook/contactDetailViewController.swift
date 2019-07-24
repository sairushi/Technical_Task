//
//  contactDetailViewController.swift
//  phoneBook
//
//  Created by mymac on 23/07/19.
//  Copyright © 2019 mymac. All rights reserved.
//

import UIKit
import CoreData

class contactDetailViewController: UIViewController {
    
    var contact: NSManagedObject? = nil
    var isDelated:Bool = false
    var indexpath: IndexPath? = nil

    override func viewDidLoad() {
       
        super.viewDidLoad()        
        contactName.text = contact?.value(forKey:"name") as? String
        contactNumber.text = contact?.value(forKey:"phoneNumber") as? String
    }
    
    @IBOutlet weak var contactName: UILabel!
    
    @IBOutlet weak var contactNumber: UILabel!
    @IBAction func deleteContact(_ sender: Any) {
        isDelated = true
        performSegue(withIdentifier: "backToList", sender: self)
    }
    
    
    @IBAction func doneButton(_ sender: Any) {
        performSegue(withIdentifier: "backToList", sender: self)    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "editContact"{
            guard let viewcontroller = segue.destination as? addContactViewController else {return}
            viewcontroller.titleLbaelText = "Edit Contact"
            viewcontroller.contact = contact
            viewcontroller.indexpathForContact = self.indexpath!
        }
    }
}
