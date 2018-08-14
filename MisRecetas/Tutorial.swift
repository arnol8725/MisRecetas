//
//  Tutorial.swift
//  MisRecetas
//
//  Created by Arnol Peralta on 14/08/18.
//  Copyright © 2018 Arnol Peralta. All rights reserved.
//

import Foundation
import UIKit

class TutorialStep  {
    var index = 0
    var heading = ""
    var content = ""
    var image: UIImage!
    
    init(index: Int, heading: String, content: String, image: UIImage) {
        self.index = index
        self.content = content
        self.heading = heading
        self.image = image
    }
    
}
