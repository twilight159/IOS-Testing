//
//  RecipeTableViewController.swift
//  Recipe
//
//  Created by Aidan Lee on 02/11/2020.
//

import UIKit
import RealmSwift

class RecipeTableViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    let realm = try! Realm()
    @IBOutlet var table: UITableView!
    private var data = [RecipeTableViewModel]()
    public var item: RecipeTypeViewModel?

    override func viewDidLoad() {
        super.viewDidLoad()
        print(item!.RecipeText)
        let fetch = realm.objects(Recipe.self)
        self.data = fetch.map({return RecipeTableViewModel(recipe: $0)})
        print(data)
        
        // Do any additional setup after loading the view.
        table.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        table.delegate = self
        table.dataSource = self
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Add", style: .done, target: self, action: #selector(TapAddButton))
        
//        fetchData()
        
        
    }
    
//    private func fetchData(){
//
//        do {
//            if let xmlUrl = Bundle.main.url(forResource: "test", withExtension: "xml"){
//                let xml = try String(contentsOf:xmlUrl, encoding: String.Encoding.utf8)
//                let recipeParser  = TestParser(withXML: xml)
//                let recipes = recipeParser.parse()
//                for rec in recipes {
//                    print(rec)
//                    data.append(rec)
//                }
//
//            }
//
//        } catch {
//            print(error)
//        }
//
//    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        let selected = item!.RecipeText
        let recipes = realm.objects(Recipe.self).filter("RecType == %@", selected)
        if indexPath.row < recipes.count {
            cell.textLabel?.text = recipes[indexPath.row].Rname
            return cell
        } else {
            return cell
        }
        
        
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let selected = item!.RecipeText
        let recipes = realm.objects(Recipe.self).filter("RecType == %@", selected)
        let reciperow = recipes[indexPath.row]
        guard let vc = storyboard?.instantiateViewController(identifier: "detailrecipe") as? DetailViewController else {
            return
        }
        vc.item  = reciperow
        vc.editHandler = {[weak self] in self?.refresh()
        }
        vc.deletionHandler = {[weak self] in self?.refresh()
        }
        vc.navigationItem.largeTitleDisplayMode = .never
        vc.title = reciperow.Rname
        navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc func TapAddButton(){
        guard let vc = storyboard?.instantiateViewController(identifier: "addrecipe") as? AddRecipeViewController else {
            return
        }
        vc.myrecipetype  = item
        vc.addHandler = {[weak self] in self?.refresh()
        }
        vc.navigationItem.largeTitleDisplayMode = .never
        navigationController?.pushViewController(vc, animated: true)
    }
    
    func refresh(){
        let fetch = realm.objects(Recipe.self)
        self.data = fetch.map({return RecipeTableViewModel(recipe: $0)})
        table.reloadData()
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
