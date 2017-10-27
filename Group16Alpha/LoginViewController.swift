//
//  LoginViewController.swift
//  Group16Alpha
//
//  Created by Wyllie, Ellen L on 10/25/17.
//  Copyright © 2017 Wyllie, Ellen L. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var signInButton: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        signInButton.layer.cornerRadius = 10
        
        usernameTextField.delegate = self
        passwordTextField.delegate = self
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
        
        if (storedUsername == username) {
            if (storedPassword == password) {
                // Login is successful
                defaults.set(true, forKey: "isUserLoggedIn")
                defaults.synchronize()
                
                performSegue(withIdentifier: <#T##String#>, sender: <#T##Any?#>)
            }
        }
    }
}
