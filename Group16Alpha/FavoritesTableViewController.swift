//
//  FavoritesTableViewController.swift
//  Group16Alpha
//
//  Created by Taylor, Ryan M on 11/21/17.
//  Copyright © 2017 Wyllie, Ellen L. All rights reserved.
//

import UIKit
import CoreData
import Alamofire

class FavoritesTableViewController: UITableViewController {

    var favoritePetIDList = [NSManagedObject]()
    var favoritePetList = [RandomPet]()
    
    func getPet(id:String) {
        var age:String = ""
        var size:String = ""
        var breed:String = ""
        var city:String = ""
        var state:String = ""
        var name:String = ""
        var gender:String = ""
        var descript:String = ""
        var url:URL! = URL(string: "https://pvsmt99345.i.lithium.com/t5/image/serverpage/image-id/10546i3DAC5A5993C8BC8C?v=1.0")
        
        let requestURL:String = "https://api.petfinder.com/pet.get?key=1a41317ad4a0e37d5ddfc61c1c98e34b&format=json" + "&id=" + id
        //print(requestURL)
        
        Alamofire.request(requestURL).responseJSON{ response in
            //print(response)
            
            if let petJSON = response.result.value {
                let responseObject:Dictionary = petJSON as! Dictionary<String, Any>
                
                // get pet object
                let petFinderObject:Dictionary = responseObject["petfinder"] as! Dictionary<String, Any>
                let petObject:Dictionary = petFinderObject["pet"] as! Dictionary<String, Any>
                
                // get age
                if let ageObject:Dictionary = petObject["age"] as? Dictionary<String, Any> {
                    if !ageObject.isEmpty {
                        age = ageObject["$t"] as! String
                    }
                }
                
                // get size
                if let sizeObject:Dictionary = petObject["size"] as? Dictionary<String, Any> {
                    if !sizeObject.isEmpty {
                        size = sizeObject["$t"] as! String
                    }
                }
                
                // get photo
                let mediaObject:Dictionary = petObject["media"] as! Dictionary<String, Any>
                if !mediaObject.isEmpty {
                    let photosObject:Dictionary = mediaObject["photos"] as! Dictionary<String, Any>
                    let photoArrayObject:Array = photosObject["photo"] as! Array<Dictionary<String, Any>>
                    let firstPhotoObject:Dictionary = photoArrayObject[2]
                    let firstPhotoUrlObject:String = firstPhotoObject["$t"] as! String
                    
                    url = URL(string: firstPhotoUrlObject)!
                }
                
                // get breed
                let breedsObject:Dictionary = petObject["breeds"] as! Dictionary<String, Any>
                // case where there is one breed (breeds contains one dictionary)
                if let breedDictObject:Dictionary = breedsObject["breed"] as? [String: Any] {
                    breed = breedDictObject["$t"] as! String
                }
                    // case where there are multiple breeds (breeds contains array of dictionaries)
                else {
                    let breedArrayObject:Array = breedsObject["breed"] as! [[String: Any]]
                    let firstElementofInnerDict:Dictionary = breedArrayObject[0]
                    breed = firstElementofInnerDict["$t"] as! String
                }
                
                // get city
                let contactObject:Dictionary = petObject["contact"] as! Dictionary<String, Any>
                if let cityObject:Dictionary = contactObject["city"] as? [String: Any] {
                    city = cityObject["$t"] as! String
                }
                // get state
                if let stateObject:Dictionary = contactObject["state"] as! Dictionary<String, Any> {
                    state = stateObject["$t"] as! String
                }
                
                // get name
                if let nameObject:Dictionary = petObject["name"] as? Dictionary<String, Any> {
                    if !nameObject.isEmpty {
                        name = nameObject["$t"] as! String
                    }
                }
                
                // get gender
                if let genderObject:Dictionary = petObject["sex"] as? Dictionary<String, Any> {
                    if !genderObject.isEmpty {
                        gender = genderObject["$t"] as! String
                    }
                    
                }
                
                // get description
                if let descriptionObject:Dictionary = petObject["description"] as? Dictionary<String, Any> {
                    if !descriptionObject.isEmpty {
                        descript =  descriptionObject["$t"] as! String
                    }
                    else {
                        descript = "No description available"
                    }
                }
                
                // get id
                /*if let idObject:Dictionary = petObject["id"] as? Dictionary<String, Any> {
                    if !idObject.isEmpty {
                        id = idObject["$t"] as! String
                    }
                }*/
                
                
                DispatchQueue.main.async{
                    self.tableView.reloadData()
                }
                
            }
    
            self.favoritePetList.append(RandomPet(age: age, size: size, breed: breed, city: city, state: state, name: name, gender: gender, descript: descript, url: url, id: id))

        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Favorites"
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        
        let managedContext = appDelegate.managedObjectContext
        
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Favorites")
        
        var fetchedResults:[NSManagedObject]? = nil
        
        do {
            try fetchedResults = managedContext.fetch(fetchRequest) as? [NSManagedObject]
        } catch {
            let nserror = error as NSError
            NSLog("Unresolved error \(nserror.userInfo)")
            abort()
        }
        
        if let results = fetchedResults {
            favoritePetIDList = results
        } else {
            print("Could not fetch")
        }
        
        for i in favoritePetIDList
        {
            getPet(id: i.value(forKey:"id") as! String)
        }
        

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
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
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return favoritePetList.count
    }

   
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "favoritePetCell", for: indexPath) as! FavoritePetTableViewCell
        
        let selectedPet = self.favoritePetList[indexPath.row]
        //print("url", selectedPet.url)
        if (selectedPet.url != nil) {
            let data = try? Data(contentsOf: selectedPet.url) //make sure your image in this url does exist, otherwise unwrap in   a if let check / try-catch
            cell.photo.image = UIImage(data: data!)
        }
        
        
        
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
        if segue.identifier == "favoritesSegue" {
            let nextScene = segue.destination as! PetPageViewController
            if let indexPath = self.tableView.indexPathForSelectedRow {
                let selectedPet = favoritePetList[indexPath.row]
                //print("selectedPet", selectedPet)
                nextScene.age = selectedPet.age
                nextScene.breed = selectedPet.breed
                nextScene.name = selectedPet.name
                nextScene.location = selectedPet.city + ", " + selectedPet.state
                nextScene.gender = selectedPet.gender
                nextScene.desc = selectedPet.descript
                nextScene.id = selectedPet.id
                if (selectedPet.url != nil) {
                    let data = try? Data(contentsOf: selectedPet.url) //make sure your image in this url does exist, otherwise unwrap in   a if let check / try-catch
                    nextScene.pic = UIImage(data: data!)!
                }
                
                //nextScene.pic = UIImage(named: "fido")!
            }
        }
    }
    

}
