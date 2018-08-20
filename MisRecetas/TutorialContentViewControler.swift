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
    @IBOutlet weak var nextButton: UIButton!
    
    @IBOutlet weak var pageControl: UIPageControl!
    
    var tutorial: TutorialStep!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.titulo.text = self.tutorial.heading
        self.image.image = self.tutorial.image
        self.descripcion.text = self.tutorial.content
        self.pageControl.currentPage = self.tutorial.index
        
        
        switch self.tutorial.index {
        case 0...1:
            self.nextButton.setTitle("Siguiente", for: .normal)
        case 2:
            self.nextButton.setTitle("Empezar", for: .normal)
        default:
            break
        }
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func nextTutorial(_ sender: Any) {
        
        switch self.tutorial.index {
        case 0...1:
             let pageViewController = parent as! TutorialPageViewController
            pageViewController.forward(toIndex: self.tutorial.index)
        case 2:
            let defaults = UserDefaults.standard
            defaults.set(true, forKey: "hasViewedTutorial")
            self.dismiss(animated: true, completion: nil)
        default:
            break
        }
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


