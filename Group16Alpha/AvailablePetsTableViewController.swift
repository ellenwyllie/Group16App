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
        
        //let fidoImage = UIImageJPEGRepresentation(fido, 1);
        
        
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
        print("Debug 1")
        super.viewDidLoad()
        print("Debug 2")
        loadData()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return petList.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "petCell", for: indexPath) as! PetTableViewCell
        cell.photo.image = UIImage(named: "fido")
        
        // Configure the cell...

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

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
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
        // Pass the selected object to the new view controller.
    }
    

}
