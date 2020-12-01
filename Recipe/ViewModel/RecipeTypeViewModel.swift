//
//  RecipeTypeViewModel.swift
//  Recipe
//
//  Created by Aidan Lee on 02/12/2020.
//

import Foundation
import RealmSwift

struct RecipeTypeViewModel {
    let RType: String
    
    init(recipet: RecipeType) {
        self.RType = recipet.recipetype
    }
}
