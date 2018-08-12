//
//  ViewController.swift
//  MisRecetas
//
//  Created by Arnol Peralta on 22/07/18.
//  Copyright © 2018 Arnol Peralta. All rights reserved.
//

import UIKit

class ViewController: UITableViewController { /*UITableViewController, UITableViewDataSource, UITableViewDelegate*/
    
    //var recipes = ["Tortillas de patatas"]
    let urlServicio = "http://192.168.100.13:9098/rest/detalleResetas"
    var recipes : [Recipe] = []
    let activityView = UIActivityIndicatorView(activityIndicatorStyle: .whiteLarge)

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
      
      
        /*Carga de activity */
        self.cargaActivity()
       
        /*Carga de servicio*/
        self.cargarDatos()
        
        
     
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.hidesBarsOnSwipe = true
        
    }
    
    func datosDefult() -> [Recipe] {
        
          var recipe = Recipe(name: "Tortilla de patatas",
         image: #imageLiteral(resourceName: "tortilla"),
         time: 20,
         ingredients: ["Patatas", "Huevos", "Cebolla"],
         steps: ["Pelar las patatas y la cebolla",
         "Cortar las patatas y la cebolla y sofreir",
         "Batir los huevos y echarlos durante 1 minuto a la sartén con el resto"])
         recipes.append(recipe)
         
         recipe = Recipe(name: "Pizza margarita",
         image: #imageLiteral(resourceName: "pizza"),
         time: 60,
         ingredients: ["Harina", "Levadura", "Aceite", "Sal", "Salsa de Tomate", "Queso"],
         steps: ["Hacemos la masa con harina, levadura, aceite y sal",
         "Dejamos reposar la masa 30 minutos",
         "Extendemos la masa encima de una bandeja y añadimos el resto de ingredientes",
         "Hornear durante 12 minutos"])
         recipes.append(recipe)
         
         recipe = Recipe(name: "Hamburguesa con queso",
         image: #imageLiteral(resourceName: "hamburguesa"),
         time: 10,
         ingredients: ["Pan de hamburguesa", "Lechuga", "Tomate", "Queso", "Carne de hamburguesa"],
         steps: ["Poner al fuego la carne al gusto",
         "Montar la hamburguesa con sus ingredientes entre los panes"])
         recipes.append(recipe)
         
         recipe = Recipe(name: "Ensalada César",
         image: #imageLiteral(resourceName: "ensalada"),
         time: 15,
         ingredients: ["Lechuga", "Tomate", "Cebolla", "Pimiento", "Salsa César", "Pollo"],
         steps: ["Limpiar todas las verduras y trocearlas",
         "Cocer el pollo al gusto",
         "Xuntar todos los ingredientes en una ensaladera y servir con salsa César por encima"])
         recipes.append(recipe)
         
         recipe = Recipe(name: "Paella nuevo",
         image: #imageLiteral(resourceName: "paella"),
         time: 30,
         ingredients: ["Arroz Bomba", "Marisco variado", "Caldo de pescado", "Guisantes"],
         steps: ["Tostar el arroz en una paellera.",
         "Tras dorarse, echar el caldo de pescado, el marisco y los guisantes.",
         "Dejar cocer a fuego lento hasta que todo el arroz se haya bebido el caldo."])
         recipes.append(recipe)
         
         recipe = Recipe(name: "Batido de fresa",
         image: #imageLiteral(resourceName: "paella"),
         time: 5,
         ingredients: ["10 fresas maduras", "Leche", "Azúcar"],
         steps: ["Limpiar y cortar las fresas.",
         "Mezclarlas con la leche y una cucharada de azúcar",
         "Triturar hasta que quede hecho papilla."])
         recipes.append(recipe)
        
        return recipes
    }
    
    func cargaActivity()  {
        /*Agregar UIActivity a la vista principal*/
        
        activityView.center = self.view.center
        activityView.color = UIColor.blue
        self.view.addSubview(activityView)
    }

    func cargarDatos()  {
        
        let urlSession : URLSession = URLSession(configuration: .default)
        let urlRequest = URLRequest(url: URL(string: urlServicio)!)
        
        self.activityView.startAnimating()
        
        
        let task = urlSession.dataTask(with: urlRequest) { (data, response, error) in
            print("valor de data \(data!)")
            guard let data = data else { return }
            print("valor de data \(data)")
            
            
            DispatchQueue.main.async {
                //Procesar el json
                do{
                    //intentar descondificar el JSON
                    self.activityView.stopAnimating()
                    
                    let decoder = JSONDecoder()
                    
                    print("valor de decoder ")
                    let musicResult = try decoder.decode(Recetas.self, from: data)
                    let recetas = musicResult.detRecetas //as! [ListaRecetas]
                    
                    for var receta in recetas {
                        print(receta.receta.name)
                        
                        if let filePath = Bundle.main.path(forResource: "tortilla", ofType: "jpg"), let image = UIImage(contentsOfFile: filePath) {
                            
                            print("entro")
                            
                            
                        }
                        print("image : \(receta.receta.image)")
                        let reci =   Recipe(name: receta.receta.name,
                                            image: UIImage(named: receta.receta.image)!,
                                            time: receta.receta.time,
                                            ingredients: ["Patatas", "Huevos", "Cebolla"],
                                            steps: ["Pelar las patatas y la cebolla",
                                                    "Cortar las patatas y la cebolla y sofreir",
                                                    "Batir los huevos y echarlos durante 1 minuto a la sartén con el resto"])
                        
                        self.recipes.append(reci)
                        
                        self.tableView.reloadData()
                    }
                    
                    if let recetas = musicResult.detRecetas.first?.receta
                    {
                        let detRecetas = recetas  as! Receta
                        print("Valor de reseta  \(detRecetas)")
                        
                    }
                    
                    /*
                     if let songs = musicResult.results.songs.first?.data {
                     let shuffledSongs = (songs as NSArray).shuffled() as! [Song]
                     //Mostrar el VC del juego
                     let gameVC = GameViewController()
                     gameVC.songs = shuffledSongs
                     self.present(gameVC, animated: true)
                     return
                     }
                     */
                    
                } catch{
                    //imprimir un mensaje de error al usuario...
                    print("Fallo")
                    print(error)
                    print(error.localizedDescription)
                    
                    self.recipes = self.datosDefult()
                    self.tableView.reloadData()
                   
                }
                
                
            }
        }
        task.resume()
    }
    
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.recipes.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let recipe = recipes[indexPath.row]
        let cellID = "RecipeCell"
        let cell = tableView.dequeueReusableCell(withIdentifier: cellID, for: indexPath) as! RecipeCell
        cell.thumbnailImageView.image = recipe.image
        cell.nameLabel.text = recipe.name
        cell.timeLabel.text = "\(recipe.time!) min"
        cell.IngredientsLabel.text = "Ingredientes: \(recipe.ingredients.count)"
        if (recipe.isFavourite) {
            cell.accessoryType = .checkmark
        }else{
            cell.accessoryType = .none
        }
        
        /*
        cell.thumbnailImageView.layer.cornerRadius = 42.0
        cell.thumbnailImageView.clipsToBounds = true
        */
        
        /*cell.textLabel?.text = recipe.name
        cell.imageView?.image = recipe.image
        */
        return cell
        
    }
    override var prefersStatusBarHidden: Bool {
        return true
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK - UITableViewDelegate
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
     /*   print("He seleccionado la fila \(indexPath.row)")
        let recipe = self.recipes[indexPath.row]
        let alertController = UIAlertController(title: nil, message: "Valora este plato", preferredStyle: .alert)
        
        let cancelAction = UIAlertAction(title: "Cancelar", style: .cancel, handler: nil)
         alertController.addAction(cancelAction )
        
        
        var favoriteAction = "Favorito"
        var favoriteActionStyle = UIAlertActionStyle.default
        if recipe.isFavourite{
            favoriteAction = "No Favorito"
            favoriteActionStyle = UIAlertActionStyle.destructive
        }
        
        let favorite = UIAlertAction(title: favoriteAction, style: favoriteActionStyle) { (action) in
            let recipe = self.recipes[indexPath.row]
            recipe.isFavourite = !recipe.isFavourite
            self.tableView.reloadData()
        }
         alertController.addAction(favorite )
        
      

       
        self.present(alertController,animated: true,completion: nil) */
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showRecipeDetail" {
            if let indexPath = self.tableView.indexPathForSelectedRow {
                let selectRecipe = self.recipes[indexPath.row]
                let destinationViewController = segue.destination as! DetailViewController
                destinationViewController.recipe = selectRecipe
            }
        }
    }
    
    override func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        //Compartir
        //Compartir
        let shareAction = UITableViewRowAction(style: .default, title: "Compartir") { (action, indexPath) in
            
            let shareDefaultText = "Estoy mirando la receta de \(self.recipes[indexPath.row].name!) en la App del curso de iOS 10 con Juan Gabriel"
            
            let activityController = UIActivityViewController(activityItems: [shareDefaultText, self.recipes[indexPath.row].image!], applicationActivities: nil)
            
            activityController.popoverPresentationController?.sourceView = self.view
            
            self.present(activityController, animated: true, completion: nil)
        }
        
        shareAction.backgroundColor = UIColor(red: 30.0/255.0, green: 164.0/255.0, blue: 253.0/255.0, alpha: 1.0)
        
        //Borrar
        let deleteAction = UITableViewRowAction(style: .default, title: "Borrar") { (action, indexPath) in
             self.recipes.remove(at: indexPath.row)
             self.tableView.deleteRows(at: [indexPath], with: .fade)
        }
          deleteAction.backgroundColor = UIColor(red: 202.0/255.0, green: 202.0/255.0, blue: 202.0/255.0, alpha:1.0)
        return [shareAction,deleteAction]
        
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        
        if editingStyle == .delete{
            self.recipes.remove(at: indexPath.row)
            
        }
        self.tableView.deleteRows(at: [indexPath], with: .fade)
        
       /* for recipe in self.recipes {
            print("\(recipe.name!)")
        }*/
    }
    
    
    

}



