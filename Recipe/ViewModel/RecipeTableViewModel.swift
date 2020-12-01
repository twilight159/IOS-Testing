//
//  PickerViewModel.swift
//  Recipe
//
//  Created by Aidan Lee on 02/12/2020.
//

import Foundation

struct RecipeTableViewModel {
    let Rname: String
    
    init(recipe: Recipe) {
        self.Rname = recipe.Rname
    }
}


    
    

