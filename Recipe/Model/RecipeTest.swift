//
//  RecipeTest.swift
//  Recipe
//
//  Created by Aidan Lee on 02/12/2020.
//

import Foundation

class RecipeAlamo {
    let alamorecipetype: String?

    struct RecipeKeys{
        static let alamorecipetype = "title"
    }
    
    init(recipeDictionary : [String : Any]) {
        alamorecipetype = recipeDictionary[RecipeKeys.alamorecipetype] as? String
    }

}


