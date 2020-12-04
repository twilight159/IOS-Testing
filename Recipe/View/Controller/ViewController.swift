//
//  ViewController.swift
//  Recipe
//
//  Created by Aidan Lee on 02/11/2020.
//

import UIKit
import RealmSwift
import Alamofire

class ViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate {
    
    private let realm = try! Realm()
    
    private var RTypeViewModel = [RecipeTypeViewModel]()
    
    let APIKey = "5c12e6a0c46245fcb47e546d50086ede"
    
    let firstRun = UserDefaults.standard.bool(forKey: "firstRun") as Bool
    
    
    
    
    
    @IBAction func addTypeButton(){
        guard let vc = storyboard?.instantiateViewController(identifier: "add") as? InputRecipeViewController else {
            return
        }
        vc.completionHandler = { [weak self] in self?.refresh()
        }
        
        vc.title = "New Recipe Type"
        vc.navigationItem.largeTitleDisplayMode = .never
        navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBOutlet weak var RecipePicker: UIPickerView!
    override func viewDidLoad() {
        super.viewDidLoad()
//        _  = fetchData
        
        if firstRun {
            
        } else {
            runFirst()
        }
        
        
        
        
        print(Realm.Configuration.defaultConfiguration.fileURL as Any)
        // Do any additional setup after loading the view.
        
        //RType = realm.objects(RecipeType.self).map({ $0 })
        let courses = realm.objects(RecipeType.self)
        
        self.RTypeViewModel = courses.map({return RecipeTypeViewModel(recipe: $0)})
        
        
        
        
        
        RecipePicker.dataSource = self
        RecipePicker.delegate = self
        
        RecipePicker.reloadAllComponents()
            
        
    }
    
    func runFirst(){
        _  = fetchData
        let recipeservice = RecipeParser(APIKey:"\(APIKey)")
        recipeservice.getallrecipetype()
        UserDefaults.standard.setValue(true, forKey: "firstRun")
    }
    
    
    
    private lazy var fetchData: Void = {
        
        do {
            if let xmlUrl = Bundle.main.url(forResource: "testtype", withExtension: "xml"){
                let xml = try String(contentsOf:xmlUrl, encoding: String.Encoding.utf8)
                let recipeParser  = TestType(withXML: xml)
                let recipes = recipeParser.parse()
                for rec in recipes {
                    print(rec)
                    //RType.append(rec)
                    let myRecipeType = RecipeType()
                    let rid = realm.objects(RecipeType.self)
                    let rrid = rid.last?.id
                    
                    
                    if(rrid == nil){
                        myRecipeType.recipetype = rec.recipetype
                    }else{
                        myRecipeType.id = rrid!+1
                        myRecipeType.recipetype = rec.recipetype
                    }

                    try! realm.write{
                        realm.add(myRecipeType)
                    }
                }
                
            }
            self.RecipePicker.reloadAllComponents()
        } catch {
            print(error)
        }
        
    }()
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return RTypeViewModel.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return RTypeViewModel[row].RecipeText
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        let reciperow = RTypeViewModel[row]
        
        guard let vc = storyboard?.instantiateViewController(identifier: "recipe") as? RecipeTableViewController else {
            return
        }
        vc.item  = reciperow
        vc.navigationItem.largeTitleDisplayMode = .never
        vc.title = reciperow.RecipeText
        navigationController?.pushViewController(vc, animated: true)
        
        
        
    }
    
    func refresh(){
        let courses = realm.objects(RecipeType.self)
        self.RTypeViewModel = courses.map({return RecipeTypeViewModel(recipe: $0)})
        RecipePicker.reloadAllComponents()
    }


}

