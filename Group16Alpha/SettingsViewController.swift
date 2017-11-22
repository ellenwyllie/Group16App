//
//  SettingsViewController.swift
//  Group16Alpha
//
//  Created by Taylor, Ryan M on 11/21/17.
//  Copyright © 2017 Wyllie, Ellen L. All rights reserved.
//

import UIKit
import CoreData

class SettingsViewController: UIViewController {
    
    var colorToggle = NSManagedObject()

    @IBOutlet weak var colorSchemeToggle: UISwitch!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Setting"
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        
        let managedContext = appDelegate.managedObjectContext
        
        let entity = NSEntityDescription.entity(forEntityName: "Settings", in: managedContext)
        
        let setting1 = NSManagedObject(entity: entity!, insertInto:managedContext)
        
        do {
            try managedContext.save()
        } catch {
            let nserror = error as NSError
            NSLog("Unresolved error \(nserror), \(nserror.userInfo)")
            abort()
        }

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    /*@IBAction func toggleColors(_ sender: Any) {
        if colorSchemeToggle.isOn
        {
            colorToggle[0].setValue(false, forKey:"colorScheme")
        }
        else
        {
            colorToggle[0].setValue(true, forKey:"colorScheme")
            
        }
    }*/

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
