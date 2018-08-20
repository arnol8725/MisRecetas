//
//  TutorialPageViewController.swift
//  MisRecetas
//
//  Created by Arnol Peralta on 14/08/18.
//  Copyright © 2018 Arnol Peralta. All rights reserved.
//

import UIKit

class TutorialPageViewController: UIPageViewController {
    
    var tutorialSteps :  [TutorialStep] = []

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        let firsStep = TutorialStep(index: 0, heading: "Personaliza ", content: "Crea nuevas recetas", image: #imageLiteral(resourceName: "tuto-intro-1"))
        self.tutorialSteps.append(firsStep)
        let secondStep = TutorialStep(index: 1, heading: "Encuentra ", content: "Crea nuevas recetas", image: #imageLiteral(resourceName: "tuto-intro-2"))
        self.tutorialSteps.append(secondStep)
        let thirdStep = TutorialStep(index: 2, heading: "Descubre ", content: "Crea nuevas recetas", image: #imageLiteral(resourceName: "tuto-intro-3"))
        self.tutorialSteps.append(thirdStep)
        
        dataSource = self
        if let startVC = self.pageViewController(atIndex: 0) {
            setViewControllers([startVC], direction: .forward, animated: true, completion: nil)
        }
        
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
    
    func forward(toIndex: Int) {
        if let nextVC = self.pageViewController(atIndex: toIndex + 1) {
            self.setViewControllers([nextVC], direction: .forward, animated: true, completion: nil)
        }
    }

}
extension TutorialPageViewController : UIPageViewControllerDataSource {
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        var index = (viewController as! TutorialContentViewControler).tutorial.index
        index -= 1
       return self.pageViewController(atIndex: index)
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        var index = (viewController as! TutorialContentViewControler).tutorial.index
        index += 1
        return self.pageViewController(atIndex: index)
    }
    
    func pageViewController(atIndex: Int) -> TutorialContentViewControler? {
        if atIndex == NSNotFound  || atIndex < 0 || atIndex >= self.tutorialSteps.count{
            return nil
        }
        if let pageContentViewController = storyboard?.instantiateViewController(withIdentifier: "WaikThroughPageController") as? TutorialContentViewControler {
            pageContentViewController.tutorial = self.tutorialSteps[atIndex]
            return pageContentViewController
        }
        return nil
    }
    
    
}
