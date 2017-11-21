//
//  RandomPet.swift
//  Group16Alpha
//
//  Created by Wyllie, Ellen L on 11/20/17.
//  Copyright © 2017 Wyllie, Ellen L. All rights reserved.
//

import Foundation

class RandomPet {
    var age:String = ""
    var size:String = ""
    var breed:String = ""
    var city:String = ""
    var state:String = ""
    var name:String = ""
    var gender:String = ""
    var descript:String = ""
    var url:URL!

    
    init(age: String, size: String, breed: String, city: String, state: String, name: String, gender: String, descript: String, url:URL) {
        self.age = age
        self.size = size
        self.breed = breed
        self.city = city
        self.state = state
        self.name = name
        self.gender = gender
        self.descript = descript
        self.url = url
    }
}

