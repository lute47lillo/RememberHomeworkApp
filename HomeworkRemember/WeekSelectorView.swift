//
//  WeekSelectorView.swift
//  HomeworkRemember
//
//  Created by Lute Lillo on 10/10/20.
//
import RealmSwift  //Database
import UIKit

//Object ToDoHomework with 2 variables.
class ToDoHomework: Object{
    @objc dynamic var item: String = ""
    @objc dynamic var date: Date = Date()

    
}

class WeekSelectorView: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet var tableDo: UITableView!
    private let realm = try! Realm()
    private var items = [ToDoHomework]() //Create array of objects: homework to do.
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        items = realm.objects(ToDoHomework.self).map({$0})
        
        //Register the table
        tableDo.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        tableDo.delegate = self
        tableDo.dataSource = self
    }
    
    //returns number of things in the items array.
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    //Returns the item for single rows of the items array.
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = items[indexPath.row].item
        
        return cell
    }
    
    //Open for item and delete
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
   
    @IBAction func addHomework(){
        guard let vc = storyboard?.instantiateViewController(identifier: "input_hw_vc") as? inputHWView else{
            return
        }
        
        vc.saveHandler = { [weak self] in
            self?.refresh()
        }
        
        vc.title = "Add HomeWork"
        vc.navigationItem.largeTitleDisplayMode = .never
        
        //Get the new item into the Table View
        navigationController?.pushViewController(vc, animated: true)
    }
        
    //Refresh the data every time a new homewrok is added.
    func refresh(){
        
        
        items = realm.objects(ToDoHomework.self).map({$0})
        //.map is transforming the return object of realm into an array.
        
        tableDo.reloadData()
    }
        
    }
    
    
    
