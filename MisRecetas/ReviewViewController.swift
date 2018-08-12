//
//  ReviewViewController.swift
//  MisRecetas
//
//  Created by Arnol Peralta on 11/08/18.
//  Copyright © 2018 Arnol Peralta. All rights reserved.
//

import UIKit

class ReviewViewController: UIViewController {

    @IBOutlet weak var ratingStackView: UIStackView!
    @IBOutlet weak var backgroundImageView: UIImageView!
    var raitingSelect : String?
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let blurEffet = UIBlurEffect(style: .dark)
        let blurEffectView = UIVisualEffectView(effect: blurEffet)
        blurEffectView.frame = view.bounds
        
        backgroundImageView.addSubview(blurEffectView)

        let scale = CGAffineTransform(scaleX: 0.0, y: 0.0)
       let translation = CGAffineTransform(translationX: 0.0, y: 500.0)
        
        ratingStackView.transform = scale.concatenating(translation)
        // Do any additional setup after loading the view.
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
      /*  UIView.animate(withDuration: 0.5, delay: 0.0, options: [], animations: {
            self.ratingStackView.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
        }, completion: nil) */
        
        UIView.animate(withDuration: 0.5, delay: 0.0, usingSpringWithDamping: 0.3, initialSpringVelocity: 0.5, options: [], animations: {
            self.ratingStackView.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
        }, completion: nil)
        
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
    
    @IBAction func raitingPressed(_ sender: UIButton) {
        switch sender.tag {
        case 1:
            raitingSelect = "dislike"
        case 2:
            raitingSelect = "good"
        case 3:
            raitingSelect = "great"
        default:
            break
        }
        
        performSegue(withIdentifier: "unwindToDetailView", sender: sender)
    }
    
    

}
