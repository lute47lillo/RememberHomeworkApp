//
//  individualHomeworkVC.swift
//  HomeworkRemember
//
//  Created by Lute Lillo on 10/11/20.
//
import RealmSwift
import UIKit

class individualHomeworkVC: UIViewController {
   
    public var work: ToDoHomework? //Reference to object on WeekSelectorView
    
    public var deleteHandler: (()-> Void)?
    
    private let realm = try! Realm()
    
    //Attributes of the indvidual assignment
    
    @IBOutlet var workLabel: UILabel!  //Definition assignment
    @IBOutlet var dateLabel: UILabel!  //Date due
    
    //Formatter of date Style
    static let dateFormatter: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        return dateFormatter
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        workLabel.text = work?.item
        dateLabel.text = Self.dateFormatter.string(from: work!.date)
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(deleteAssignment))
      
    }
    
    //Delete an assignment when button .done is clicked
    @objc private func deleteAssignment(){
        guard let assign = self.work else {
            return
        }
        
        //Write to the database the deletion of an assignment
        realm.beginWrite()
        realm.delete(assign)
        try! realm.commitWrite()
        deleteHandler?()
        
        navigationController?.popToRootViewController(animated: true)
    }
    

}
