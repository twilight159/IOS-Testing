//
//  RecipeType.swift
//  Recipe
//
//  Created by Aidan Lee on 02/11/2020.
//

import Foundation
import RealmSwift
import Alamofire

typealias DownloadComplete = () -> ()

class RecipeType: Object {
    let url = "https://cs.au.dk/~amoeller/XML/xml/recipes.xml"
    @objc dynamic var id: Int = 0
    @objc dynamic var recipetype: String = ""
    
    override static func primaryKey() -> String? {
            return "id"
        }
    

    
        
        
        
        
    
    
    
    
}
