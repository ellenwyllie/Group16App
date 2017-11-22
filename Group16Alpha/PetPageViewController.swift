//
//  PetPageViewController.swift
//  Group16Alpha
//
//  Created by Taylor, Ryan M on 10/30/17.
//  Copyright © 2017 Wyllie, Ellen L. All rights reserved.
//

import UIKit
import CoreData

class PetPageViewController: UIViewController {

    @IBOutlet weak var photo: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var breedLabel: UILabel!
    @IBOutlet weak var ageLabel: UILabel!
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var genderLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var favoriteButton: UIButton!
    
    var favoritePetIDList = [NSManagedObject]()
    
    var name: String = ""
    var id: String = ""
    var breed: String = ""
    var age: String = ""
    var location: String = ""
    var gender: String = ""
    var desc: String = ""
    var pic = UIImage()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        photo.contentMode = .scaleAspectFit
        photo.image = pic
        nameLabel.text = name
        breedLabel.text = breed
        ageLabel.text = "\(age)"
        locationLabel.text = location
        genderLabel.text = gender
        descriptionLabel.text = desc
        
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
        
        var found = false
        
        for petID in favoritePetIDList
        {
            if(petID.value(forKey:"id") as! String == id)
            {
                found = true
                break
            }
        }
        
        if(found)
        {
            favoriteButton.setTitle("Remove from Favorites", for: .normal)
        }
        else
        {
            favoriteButton.setTitle("Add to Favorites", for: .normal)
        }
            
            
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
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
    
    @IBAction func addToFavorites(_ sender: Any) {
        if(favoriteButton.currentTitle == "Remove from Favorites")
        {
            removePet(id: id)
            favoriteButton.setTitle("Add to Favorites", for: .normal)
        }
        else
        {
            savePet(id: id)
            favoriteButton.setTitle("Remove from Favorites", for: .normal)
        }
    }
    
    func savePet(id: String)
    {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        
        let managedContext = appDelegate.managedObjectContext
        
        let entity = NSEntityDescription.entity(forEntityName: "Favorites", in: managedContext)
        
        let petID = NSManagedObject(entity: entity!, insertInto:managedContext)
        
        petID.setValue(id, forKey: "id")
        
        do {
            try managedContext.save()
        } catch {
            let nserror = error as NSError
            NSLog("Unresolved error \(nserror), \(nserror.userInfo)")
            abort()
        }
    }
    
    func removePet(id: String)
    {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        
        let managedContext = appDelegate.managedObjectContext
        
        var foundID = NSManagedObject()
        
        for petID in favoritePetIDList
        {
            if(petID.value(forKey:"id") as! String == id)
            {
                foundID = petID
            }
        }
        
        managedContext.delete(foundID)
        
        do {
            try managedContext.save()
        } catch {
            let nserror = error as NSError
            NSLog("Unresolved error \(nserror), \(nserror.userInfo)")
            abort()
        }
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
