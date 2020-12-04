import UIKit
import Foundation
import Alamofire
import RealmSwift

class RecipeParser: NSObject{
    
    fileprivate var APIKey: String
    fileprivate var baseUrl: URL?
    
    init(APIKey: String) {
        self.APIKey = APIKey
        baseUrl = URL(string: "https://api.spoonacular.com/recipes/716429/information?includeNutrition=false&apiKey=\(APIKey)")
        
    }
    
    
    func getallrecipetype(){
        let realm = try! Realm()
        if let recipeURL = URL(string: "\(baseUrl!)"){
            AF.request(recipeURL).responseJSON(completionHandler: {(response) in
                
                switch response.result {
                               case .success(let value):
                                if let jsonDictionary = value as? [String:Any] {
                                       let currentRecipeDictionary = jsonDictionary["title"] as! String
                                       
                                        let myRecipeType = RecipeType()
                                        let rid = realm.objects(RecipeType.self)
                                        let rrid = rid.last?.id
                                        
                                        
                                        if(rrid == nil){
                                            myRecipeType.recipetype = currentRecipeDictionary
                                        }else{
                                            myRecipeType.id = rrid!+1
                                            myRecipeType.recipetype = currentRecipeDictionary
                                        }

                                        try! realm.write{
                                            realm.add(myRecipeType)
                                        }
                                   }
                               case .failure(let error): break
                                   // error handling
                               }
                
                
                    
                
                
            })
        }
    }
    
    
    
    
    
    
}
