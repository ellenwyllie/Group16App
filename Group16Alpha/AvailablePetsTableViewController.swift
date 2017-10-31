//
//  AvailablePetsTableViewController.swift
//  Group16Alpha
//
//  Created by Taylor, Ryan M on 10/30/17.
//  Copyright © 2017 Wyllie, Ellen L. All rights reserved.
//

import UIKit
import CoreData

class AvailablePetsTableViewController: UITableViewController {

    var petList = [NSManagedObject]()
    
    func loadData()
    {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        
        let managedContext = appDelegate.managedObjectContext
        
        let entity = NSEntityDescription.entity(forEntityName: "Pet", in: managedContext)
        
        let pet = NSManagedObject(entity: entity!, insertInto:managedContext)
        
        pet.setValue(177, forKey: "age")
        pet.setValue("Poodle", forKey: "breed")
        pet.setValue("Male", forKey: "gender")
        pet.setValue("Fido", forKey: "name")
        pet.setValue("Large", forKey: "size")
        pet.setValue("Dog", forKey: "type")
        pet.setValue("Austin", forKey: "city")
        pet.setValue("Texas", forKey: "state")
        pet.setValue("Phat poodle with sick flow", forKey: "desc")
        
        do {
            try managedContext.save()
        } catch {
            let nserror = error as NSError
            NSLog("Unresolved error \(nserror), \(nserror.userInfo)")
            abort()
        }
        
        petList.append(pet)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Available Pets"
        loadData()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController!.navigationBar.barTintColor = UIColor(red: (0/255.0), green: (128/225.0), blue: (128/225.0), alpha: 1.0)
        self.navigationController!.navigationBar.tintColor = UIColor.black
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationController!.navigationBar.barTintColor = nil
        self.navigationController!.navigationBar.isTranslucent = true
        self.navigationController!.navigationBar.tintColor = UIColor.black
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return petList.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "petCell", for: indexPath) as! PetTableViewCell
        
        cell.photo.image = UIImage(named: "fido")
        
        return cell
    }
    
    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let nextScene = segue.destination as! PetPageViewController
        if let indexPath = self.tableView.indexPathForSelectedRow {
            let selectedPet = petList[indexPath.row]
            
            nextScene.age = selectedPet.value(forKey: "age") as! Int
            nextScene.breed = selectedPet.value(forKey: "breed") as! String
            nextScene.name = selectedPet.value(forKey: "name") as! String
            nextScene.location = selectedPet.value(forKey: "city") as! String
            nextScene.gender = selectedPet.value(forKey: "gender") as! String
            nextScene.desc = selectedPet.value(forKey: "desc") as! String
            nextScene.pic = UIImage(named: "fido")!
        }
    }
    

}
