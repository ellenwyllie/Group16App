//
//  SearchViewController.swift
//  Group16Alpha
//
//  Created by Wyllie, Ellen L on 11/20/17.
//  Copyright © 2017 Wyllie, Ellen L. All rights reserved.
//

import UIKit

class SearchViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource, UITextFieldDelegate {

    @IBOutlet weak var animalTextField: UITextField!
    @IBOutlet weak var animalDropDown: UIPickerView!
    @IBOutlet weak var sizeTextField: UITextField!
    @IBOutlet weak var sizeDropDown: UIPickerView!
    @IBOutlet weak var ageTextField: UITextField!
    @IBOutlet weak var ageDropDown: UIPickerView!
    @IBOutlet weak var sexSegment: UISegmentedControl!
    
    let animalList = ["Any", "Barnyard", "Bird", "Cat", "Dog", "Horse", "Reptile", "Smallfurry"]
    
    let sizeList = ["Any", "Small", "Medium", "Large", "Extra Large"]
    
    let ageList = ["Any", "Baby", "Young", "Adult", "Senior"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Search"
        
        self.animalTextField.text = "Any"
        self.sizeTextField.text = "Any"
        self.ageTextField.text = "Any"
        
        self.animalDropDown.isHidden = true
        self.sizeDropDown.isHidden = true
        self.ageDropDown.isHidden = true

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        var rows = 0
        if pickerView == animalDropDown {
            rows = self.animalList.count
        }
        if pickerView == sizeDropDown {
            rows = self.sizeList.count
        }
        if pickerView == ageDropDown {
            rows = self.ageList.count
        }
        return rows
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        var titleRow = ""
        if pickerView == animalDropDown {
            titleRow = animalList[row]
        }
        if pickerView == sizeDropDown {
            titleRow = sizeList[row]
        }
        if pickerView == ageDropDown {
            titleRow = ageList[row]
        }
        return titleRow
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if pickerView == animalDropDown {
            self.animalTextField.text = self.animalList[row]
            self.animalDropDown.isHidden = true
        }
        if pickerView == sizeDropDown {
            self.sizeTextField.text = self.sizeList[row]
            self.sizeDropDown.isHidden = true
        }
        if pickerView == ageDropDown {
            self.ageTextField.text = self.ageList[row]
            self.ageDropDown.isHidden = true
        }
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        textField.endEditing(true)
        if (textField == self.animalTextField){
            self.animalDropDown.isHidden = false
        }
        if (textField == self.sizeTextField){
            self.sizeDropDown.isHidden = false
        }
        if (textField == self.ageTextField){
            self.ageDropDown.isHidden = false
        }
    }
    
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        
        let nextScene = segue.destination as! AvailablePetsTableViewController
        var request = ""
        
        if animalTextField.text != "Any" {
            request += "&animal=" + animalTextField.text!.lowercased()
        }
        
        if sizeTextField.text == "Small" {
            request += "&size=S"
        } else if sizeTextField.text == "Medium" {
            request += "&size=M"
        } else if sizeTextField.text == "Large" {
            request += "&size=L"
        } else if sizeTextField.text == "Extra Large" {
            request += "&size=XL"
        }
        
        if ageTextField.text != "Any" {
            request += "&age=" + ageTextField.text!
        }

        if sexSegment.selectedSegmentIndex == 1 {
            request += "&sex=M"
        } else if sexSegment.selectedSegmentIndex == 2 {
            request += "&sex=F"
        }
        
        nextScene.request = request
    }
    

}
