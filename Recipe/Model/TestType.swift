//
//  TestType.swift
//  Recipe
//
//  Created by Aidan Lee on 02/12/2020.
//

import Foundation
import UIKit

class TestType: NSObject {
    var xmlParser: XMLParser?
    var recipe: [RecipeType] = []
    var xmlText = ""
    var currentRecipe: RecipeType?
    
    init(withXML xml: String) {
        if let data = xml.data(using: .utf8){
            xmlParser = XMLParser(data: data)
        
        }
        
    }
    
    
    
    func parse() -> [RecipeType] {
        
        xmlParser?.delegate = self
        xmlParser?.parse()
        return recipe
    }
    
    
    
}



extension TestType: XMLParserDelegate {
    func parser(_ parser: XMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [String : String] = [:]) {
        xmlText = ""
        if elementName == "recipe" {
            currentRecipe = RecipeType()
        }
    }
    
    func parser(_ parser: XMLParser, didEndElement elementName: String, namespaceURI: String?, qualifiedName qName: String?) {
        if elementName == "recipetype"{
            currentRecipe?.recipetype = xmlText.trimmingCharacters(in: NSCharacterSet.whitespacesAndNewlines)
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
