//
//  PetPageViewController.swift
//  Group16Alpha
//
//  Created by Taylor, Ryan M on 10/30/17.
//  Copyright © 2017 Wyllie, Ellen L. All rights reserved.
//

import UIKit

class PetPageViewController: UIViewController {

    @IBOutlet weak var photo: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var breedLabel: UILabel!
    @IBOutlet weak var ageLabel: UILabel!
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var genderLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    var name: String = ""
    var breed: String = ""
    var age: Int = 0
    var location: String = ""
    var gender: String = ""
    var desc: String = ""
    var pic = UIImage()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        photo.image = pic
        nameLabel.text = name
        breedLabel.text = breed
        ageLabel.text = "\(age)"
        locationLabel.text = location
        genderLabel.text = gender
        descriptionLabel.text = desc

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
