//
//  Recipe.swift
//  MisRecetas
//
//  Created by Arnol Peralta on 22/07/18.
//  Copyright © 2018 Arnol Peralta. All rights reserved.
//

import Foundation
import UIKit

class Recipe: NSObject {
    var name : String!
    var image :UIImage!
    var time: Int!
    var ingredients : [String]!
    var steps : [String]!
    var isFavourite : Bool = false
    var raiting :String = ""
    
    init(name: String, image: UIImage,time :Int, ingredients:  [String], steps: [String] ) {
        self.name = name
        self.image = image
        self.ingredients = ingredients
        self.steps = steps
        self.time = time
        
    }

    
}
