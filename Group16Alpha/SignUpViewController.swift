//
//  SignUpViewController.swift
//  Group16Alpha
//
//  Created by Wyllie, Ellen L on 10/25/17.
//  Copyright © 2017 Wyllie, Ellen L. All rights reserved.
//

import UIKit
import CoreData

class SignUpViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var confirmPasswordTextField: UITextField!
    
    @IBOutlet weak var signUpButton: UIButton!
    @IBOutlet weak var fidoFinderLabel: UILabel!
   
    var myAlert:UIAlertController? = nil

    
    override func viewDidLoad() {
        super.viewDidLoad()
        fidoFinderLabel.textColor = UIColor(red: (0/255.0), green: (128/225.0), blue: (128/225.0), alpha: 1.0)

        signUpButton.layer.cornerRadius = 10
        
        usernameTextField.delegate = self
        passwordTextField.delegate = self
        confirmPasswordTextField.delegate = self
        
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

    @IBAction func signupBtnClicked(_ sender: Any) {
        let username = usernameTextField.text
        let password = passwordTextField.text
        let confirmPassword = confirmPasswordTextField.text
        
        
        // Check for empty fields
        if ((username?.isEmpty)! || (password?.isEmpty)! || (confirmPassword?.isEmpty)!) {
            // Display alert message
            displayAlertMessage(userMessage: "All fields are required")
            return
        }
        
        // Check if passwords match
        if (password != confirmPassword) {
            // Display alert message
            displayAlertMessage(userMessage: "Passwords do not match")
            return
        }
        
        // Store data
        let defaults = UserDefaults.standard
        defaults.set(username, forKey: "username")
        defaults.set(password, forKey: "password")
        
        defaults.synchronize()
        
        // Display alert message with confirmation
        self.myAlert = UIAlertController(title: "Alert", message: "Sign up complete!", preferredStyle: UIAlertControllerStyle.alert)
        let okAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil)
        self.myAlert!.addAction(okAction)
        self.present(self.myAlert!, animated: true, completion: nil)
        
        
    }
    
    func displayAlertMessage(userMessage: String) {
        self.myAlert = UIAlertController(title: "Alert", message: userMessage, preferredStyle: UIAlertControllerStyle.alert)
        let okAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil)
        self.myAlert!.addAction(okAction)
        self.present(self.myAlert!, animated: true, completion: nil)
        
    }
}
