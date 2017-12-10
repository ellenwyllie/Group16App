//
//  LoginViewController.swift
//  Group16Alpha
//
//  Created by Wyllie, Ellen L on 10/25/17.
//  Copyright © 2017 Wyllie, Ellen L. All rights reserved.
//

import UIKit
import CoreData

class LoginViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var signInButton: UIButton!
    @IBOutlet weak var fidoFinderLabel: UILabel!
    @IBOutlet weak var signUpLabel: UIButton!
    
    var myAlert:UIAlertController? = nil

    override func viewDidLoad() {
        super.viewDidLoad()
        fidoFinderLabel.textColor = UIColor(red: (0/255), green: (128/225), blue: (128/225), alpha: 1)
        signInButton.layer.cornerRadius = 10
        
        usernameTextField.delegate = self
        passwordTextField.delegate = self
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let managedContext = appDelegate.managedObjectContext
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Settings")
        var fetchedResults:[NSManagedObject]? = nil
        
        do {
            try fetchedResults = managedContext.fetch(fetchRequest) as? [NSManagedObject]
        } catch {
            let nserror = error as NSError
            NSLog("Unresolved error \(nserror), \(nserror.userInfo)")
            abort()
        }
        
        if let results = fetchedResults {
            if !results.isEmpty {
                if results[0].value(forKey: "nightMode") as! Int == 1  {
                    self.view.backgroundColor = .black
                }
                
            }
        } else {
            print("Could not fetch")
        }
        
        self.navigationItem.setHidesBackButton(true, animated: false)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    
    @IBAction func signInBtnClicked(_ sender: Any) {
        let username = usernameTextField.text
        let password = passwordTextField.text
        
        let defaults = UserDefaults.standard
        let storedUsername = defaults.string(forKey: "username")
        let storedPassword = defaults.string(forKey: "password")
        
        if (storedUsername == username && storedPassword == password) {
            // Login is successful
            defaults.set(true, forKey: "isUserLoggedIn")
            defaults.synchronize()
                
            performSegue(withIdentifier: "AvailablePetsSegue", sender: nil)
        }
        else {
            // Login not successful
            defaults.set(false, forKey: "isUserLoggedIn")
            
            self.myAlert = UIAlertController(title: "Alert", message: "Incorrect username or password.", preferredStyle: UIAlertControllerStyle.alert)
            
            let okAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil)
            
            self.myAlert!.addAction(okAction)
            
            self.present(self.myAlert!, animated: true, completion: nil)
        }
        
    }
}
