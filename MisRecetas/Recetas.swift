//
//  Recetas.swift
//  MisRecetas
//
//  Created by Arnol Peralta on 29/07/18.
//  Copyright © 2018 Arnol Peralta. All rights reserved.
//

import Foundation

struct Recetas : Codable{
    var mensaje: String
    var error: Bool
    var detRecetas : [ListaRecetas]
    
    
}


struct ListaRecetas : Codable{
    var receta : Receta
    var detIngredientes : [Ingredients]
    var detSteps : [Steps]
    
    
}

struct Receta : Codable {
    var id: Int
    var name: String
    var image :String
    var time : Int
    
    static func <(lhs: Receta, rhs: Receta) ->Bool {
        return lhs.id < rhs.id
    }
    static func ==(lhs: Receta, rhs: Receta) ->Bool {
        return lhs.id == rhs.id
    }
}
struct Ingredients : Codable {
    var  idIngredients:Int
    var  receta: Receta
    var  descipIngredient:String
}
struct Steps : Codable {
    var  idSteps:Int
    var  receta: Receta
    var  descipidSteps:String
}
