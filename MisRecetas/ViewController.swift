//
//  ViewController.swift
//  MisRecetas
//
//  Created by Arnol Peralta on 22/07/18.
//  Copyright © 2018 Arnol Peralta. All rights reserved.
//

import UIKit
import CoreData

class ViewController: UITableViewController { /*UITableViewController, UITableViewDataSource, UITableViewDelegate*/
    
    //var recipes = ["Tortillas de patatas"]
    let urlServicio = "http://192.168.100.13:9098/rest/detalleResetas"
    var searchResult : [Recipe] = []
    var recipes : [Recipe] = []
    let activityView = UIActivityIndicatorView(activityIndicatorStyle: .whiteLarge)
    var fetchResultsController : NSFetchedResultsController<RecetaCocina>!
    var searchController: UISearchController!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        
        self.searchController = UISearchController(searchResultsController: nil)
        self.tableView.tableHeaderView = self.searchController.searchBar
        self.searchController.searchResultsUpdater = self
            
        self.searchController.dimsBackgroundDuringPresentation = false
        self.searchController.searchBar.placeholder = "Buscar lugares..."
        self.searchController.searchBar.tintColor = UIColor.white
        self.searchController.searchBar.barTintColor = UIColor.darkGray
        
        
        /*Carga de activity */
        self.cargaActivity()
       
        /*Carga de servicio*/
        self.cargarDatos()
        
        /*Carga Datos del coreDate */
      //  self.llenarCoreData()
     
        
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
    
    func llenarCoreData()  {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        let entity = NSEntityDescription.entity(forEntityName: "RecetaCocina", in: context)
        
         print("recipe \(self.recipes.count)" )
       var id = 0
        
       
        
        for var recipe in self.recipes{
            print("recipe \(self.recipes.count)" )
            id = id + 1
            let newReceta = NSManagedObject(entity: entity!, insertInto: context)
            newReceta.setValue(id, forKey: "id")
            newReceta.setValue(recipe.name, forKey: "name")
            newReceta.setValue(recipe.time, forKey: "time")
            newReceta.setValue(recipe.name, forKey: "image")
        }
        
        
        
        do {
            try context.save()
        } catch {
            print("Failed saving")
        }
        
        print("Obtener el valor de receta")
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "RecetaCocina")
        //request.predicate = NSPredicate(format: "age = %@", "12")
        request.returnsObjectsAsFaults = false
        do {
            let result = try context.fetch(request)
            var ids = 0
            for data in result as! [NSManagedObject] {
                ids += 1
                print(ids)
                print(data.value(forKey: "name") as! String)
                
              /*  if let container = (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer {
                    let context = container.viewContext
                   // let placeToDelete = self.fetchResultsController.object(at: ids as! IndexPath)
                    context.delete(data)
                    
                    do {
                        try context.save()
                    } catch {
                        print("Error \(error)")
                    }
                    
                }*/
                
                
            }
            
        } catch {
            
            print("Failed Coredate")
        }
    }
    
    func eliminarCoreData(){
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        let entity = NSEntityDescription.entity(forEntityName: "RecetaCocina", in: context)
        
        print("Obtener el valor de receta")
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "RecetaCocina")
        //request.predicate = NSPredicate(format: "age = %@", "12")
        request.returnsObjectsAsFaults = false
        do {
            let result = try context.fetch(request)
            var ids = 0
            for data in result as! [NSManagedObject] {
                ids += 1
                print(ids)
                print(data.value(forKey: "name") as! String)
                
                  if let container = (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer {
                         let context = container.viewContext
                         // let placeToDelete = self.fetchResultsController.object(at: ids as! IndexPath)
                         print("Elimino \(data.value(forKey: "id"))")
                         context.delete(data)
                    
                         do {
                         try context.save()
                         } catch {
                         print("Error \(error)")
                         }
                 
                 }
                
                
            }
            
        } catch {
            
            print("Failed Coredate")
        }
    }

    func cargarDatos()  {
        
        let urlSession : URLSession = URLSession(configuration: .default)
        let urlRequest = URLRequest(url: URL(string: urlServicio)!)
        
        self.activityView.startAnimating()
        
        
        let task = urlSession.dataTask(with: urlRequest) { (data, response, error) in
          
            if (data != nil) {
                
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
                        
                       
                        /*Eliminar los datos actualues coredata*/
                        self.eliminarCoreData()
                        /*LLenar los datos del servicio*/
                        self.llenarCoreData()
                        
                    } catch{
                        //imprimir un mensaje de error al usuario...
                        print("Fallo")
                        print(error)
                        print(error.localizedDescription)
                        
                        self.recipes = self.datosDefult()
                        self.tableView.reloadData()
                          self.activityView.stopAnimating()
                    }
                    
                    
                }
                
            }else{
                print("Fallo al consultar el servicio")
                  self.activityView.stopAnimating()
               
                
                self.recipes = self.datosDefult()
                self.tableView.reloadData()
                
            }
          
        }
        task.resume()
    }
    
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if self.searchController.isActive{
             return self.searchResult.count
        }else{
             return self.recipes.count
        }
        
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var recipe : Recipe!
        if searchController.isActive{
            recipe = searchResult[indexPath.row]
        }else {
            recipe = recipes[indexPath.row]
        }
        //let recipe = recipes[indexPath.row]
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
    
    
    func filterContentFor(textToSearch: String)  {
        self.searchResult = self.recipes.filter({ (recipe) -> Bool in
            let recipeToFind = recipe.name.range(of: textToSearch,options: NSString.CompareOptions.caseInsensitive)
            return recipeToFind != nil
            
        })
    }
    

}


extension ViewController : UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        if let searchText = searchController.searchBar.text {
            self.filterContentFor(textToSearch: searchText)
            self.tableView.reloadData()
        }
        
        
    }
}

 




