//
//  DetailViewController.swift
//  MisRecetas
//
//  Created by Arnol Peralta on 08/08/18.
//  Copyright © 2018 Arnol Peralta. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var recibeImageView: UIImageView!
    
    @IBOutlet weak var imageRaiting: UIButton!
    var recipe : Recipe!
    
    @IBOutlet weak var tableview: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = recipe.name
        
        self.tableView.backgroundColor = UIColor(red: 0.9, green: 0.9, blue: 0.9, alpha: 0.25)
        self.tableView.tableFooterView = UIView.init(frame: CGRect.zero)
        self.tableView.separatorColor = UIColor(red: 0.9, green: 0.9, blue: 0.9, alpha: 0.75)
        
        self.tableView.estimatedRowHeight = 44.0
        self.tableView.rowHeight = UITableViewAutomaticDimension
        
        
         /*self.tableview.dataSource = self
          self.tableview.delegate = self
        */
        // Do any additional setup after loading the view.
        self.recibeImageView.image = self.recipe.image
    }
    override func viewWillAppear(_ animated: Bool) {
       super.viewWillAppear(animated)
        navigationController?.hidesBarsOnSwipe = false
        navigationController?.setNavigationBarHidden(false, animated: true)
    }
   
    @IBAction func close(segue: UIStoryboardSegue){
        print("Entro")
        
        if let reviewVC = segue.source as? ReviewViewController{
            if let raiting = reviewVC.raitingSelect {
                print(raiting)
                recipe.raiting = raiting
                
                self.imageRaiting.setImage(UIImage(named: raiting), for: .normal)
                
                
                  //self.tableView.reloadData()
            }
            
        }
      
        
    }
    
   override var prefersStatusBarHidden: Bool {
        return true
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

extension DetailViewController : UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        
        return 3;
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return 3
        case 1:
            return self.recipe.ingredients.count
        case 2:
            return self.recipe.steps.count
        default:
            return 0
        }
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cellID = "RecipeDetailCell"
        
        let cell = tableView.dequeueReusableCell(withIdentifier: cellID, for: indexPath) as! RecipeDetailViewCell
        
        cell.backgroundColor = UIColor.clear
        switch indexPath.section {
            case 0:
                switch indexPath.row {
                case 0:
                    cell.keyLabel.text = "Nombre"
                    cell.valueLabel.text = self.recipe.name
                case 1:
                    cell.keyLabel.text = "Tiempo"
                    cell.valueLabel.text = "\(self.recipe.time!) min"
                case 2:
                    cell.keyLabel.text = "Raiting"
                   /* if self.recipe.isFavourite{
                        cell.valueLabel.text = "Si"
                    }else{
                        cell.valueLabel.text = "No"
                    }*/
                     cell.valueLabel.text = recipe.raiting
                   
                default:
                    break
                }
            case 1:
                if indexPath.row == 0{
                    cell.keyLabel.text = "Ingredientes"
                }else{
                    cell.keyLabel.text = ""
                }
                cell.valueLabel.text = "\(self.recipe.ingredients[indexPath.row])"
            
            case 2:
                if indexPath.row == 0{
                    cell.keyLabel.text = "Pasos"
                }else{
                    cell.keyLabel.text = ""
                }
                cell.valueLabel.text = "\(self.recipe.steps[indexPath.row])"
            
        default:
            break
        }
        
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        var title = ""
        switch section {
        case 1:
            title = "Ingredientes"
        case 2:
            title = "Pasos"
        default:
            break
        }
        
        return title
    }
    
}

extension DetailViewController : UITableViewDelegate {
    
}
