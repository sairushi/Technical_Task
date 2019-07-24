//
//  contactsViewController.swift
//  phoneBook
//
//  Created by mymac on 23/07/19.
//  Copyright © 2019 mymac. All rights reserved.
//

import UIKit
import CoreData

class contactsViewController: UITableViewController{
    
    var contacts:[NSManagedObject] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        fetch()
        tableView.reloadData()

    }
    
    func fetch() {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        let managedObjectContext = appDelegate.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName:"Contact")
        do {
            contacts = try managedObjectContext.fetch(fetchRequest) as! [NSManagedObject]
        } catch let error as NSError {
            print("Could not fetch. \(error)")
        }
    }
    
    func save(name: String, phoneNumber: String) {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        let managedObjectContext = appDelegate.persistentContainer.viewContext
        guard let entity = NSEntityDescription.entity(forEntityName:"Contact", in: managedObjectContext) else { return }
        let contact = NSManagedObject(entity: entity, insertInto: managedObjectContext)
        contact.setValue(name, forKey: "name")
        contact.setValue(phoneNumber, forKey: "phoneNumber")
        do {
            try managedObjectContext.save()
            self.contacts.append(contact)
        } catch let error as NSError {
            print("Couldn't save. \(error)")
        }
    }
    
    func update(indexPath: IndexPath, name:String, phoneNumber: String) {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        let managedObjectContext = appDelegate.persistentContainer.viewContext
        let contact = contacts[indexPath.row]
        contact.setValue(name, forKey:"name")
        contact.setValue(phoneNumber, forKey: "phoneNumber")
        do {
            try managedObjectContext.save()
            contacts[indexPath.row] = contact
        } catch let error as NSError {
            print("Couldn't update. \(error)")
        }
    }
    
    func delete(_ contact: NSManagedObject, at indexPath: IndexPath) {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        let managedObjectContext = appDelegate.persistentContainer.viewContext
        managedObjectContext.delete(contact)
        contacts.remove(at: indexPath.row)
    }
    
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return contacts.count
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "contactCell", for: indexPath)
        let contact = contacts[indexPath.row]
        cell.textLabel?.text = contact.value(forKey:"name") as? String
        cell.detailTextLabel?.text = contact.value(forKey:"phoneNumber") as? String

        return cell
    }
    @IBAction func backToContacts(segue:UIStoryboardSegue) {
        if  let viewcontroller = segue.source as? addContactViewController{
            guard let name: String = viewcontroller.nameTextField.text, let phoneNumber: String = viewcontroller.phoneNumberTf.text else { return }
            if name != "" && phoneNumber != "" {
                if let indexPath = viewcontroller.indexpathForContact {
                    update(indexPath: indexPath, name: name, phoneNumber: phoneNumber)
                } else {
                    save(name:name, phoneNumber:phoneNumber)
                }
            }
        tableView.reloadData()
        } else if let viewcontroller = segue.source as? contactDetailViewController{
            if viewcontroller.isDelated{
                guard let indexPath: IndexPath = viewcontroller.indexpath else { return }
                let contact = contacts[indexPath.row]
                delete(contact, at: indexPath)
                tableView.reloadData()
                
            }
            
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "contactDetails"{
            
            guard let navViewController = segue.destination as? UINavigationController else { return }
            guard let viewController = navViewController.topViewController as? contactDetailViewController else { return }
            guard let indexPath = tableView.indexPathForSelectedRow else { return }
            let contact = contacts[indexPath.row]
            viewController.contact = contact
            viewController.indexpath = indexPath
        }
    }

}
