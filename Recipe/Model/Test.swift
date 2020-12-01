//
//  Test.swift
//  Recipe
//
//  Created by Aidan Lee on 01/12/2020.
//

import Foundation
import UIKit

class TestParser: NSObject {
    var xmlParser: XMLParser?
    var recipe: [Recipe] = []
    var xmlText = ""
    var currentRecipe: Recipe?
    
    init(withXML xml: String) {
        if let data = xml.data(using: .utf8){
            xmlParser = XMLParser(data: data)
        
        }
        
    }
    
    
    
    func parse() -> [Recipe] {
        
        xmlParser?.delegate = self
        xmlParser?.parse()
        return recipe
    }
    
    
    
}



extension TestParser: XMLParserDelegate {
    func parser(_ parser: XMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [String : String] = [:]) {
        xmlText = ""
        if elementName == "recipe" {
            currentRecipe = Recipe()
        }
    }
    
    func parser(_ parser: XMLParser, didEndElement elementName: String, namespaceURI: String?, qualifiedName qName: String?) {
        if elementName == "recipename" {
            currentRecipe?.Rname = xmlText.trimmingCharacters(in: NSCharacterSet.whitespacesAndNewlines)
        }
        if elementName == "recipetype"{
            currentRecipe?.RecType = xmlText.trimmingCharacters(in: NSCharacterSet.whitespacesAndNewlines)
        }
        if elementName == "recipeingredients"{
            currentRecipe?.Ingredients = xmlText.trimmingCharacters(in: NSCharacterSet.whitespacesAndNewlines)
        }
        if elementName == "recipesteps"{
            currentRecipe?.Steps = xmlText.trimmingCharacters(in: NSCharacterSet.whitespacesAndNewlines)
        }
        if elementName == "recipe" {
            if let reci = currentRecipe {
                recipe.append(reci)
            }
        }
    }
    
    func parser(_ parser: XMLParser, foundCharacters string: String) {
        xmlText += string
    }
    
    
}




