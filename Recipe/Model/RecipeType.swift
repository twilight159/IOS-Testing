//
//  RecipeType.swift
//  Recipe
//
//  Created by Aidan Lee on 02/11/2020.
//

import Foundation
import RealmSwift


public class RecipeType: Object {
    @objc dynamic var id: Int = 0
    @objc dynamic var recipetype: String = ""
    
    public override static func primaryKey() -> String? {
            return "id"
        }
    
    

    
        
        
        
        
    
    
    
    
}
