//
//  TutorialContentViewControler.swift
//  MisRecetas
//
//  Created by Arnol Peralta on 14/08/18.
//  Copyright © 2018 Arnol Peralta. All rights reserved.
//

import UIKit

class TutorialContentViewControler: UIViewController {

    @IBOutlet weak var titulo: UILabel!
    @IBOutlet weak var image: UIImageView!
    @IBOutlet weak var descripcion: UILabel!
    
    var tutorial: TutorialStep!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.titulo.text = self.tutorial.heading
        self.image.image = self.tutorial.image
        self.descripcion.text = self.tutorial.content

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


