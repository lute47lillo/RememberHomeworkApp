//
//  inputHWView.swift
//  HomeworkRemember
//
//  Created by Lute Lillo on 10/11/20.
//
import RealmSwift
import UIKit

class inputHWView: UIViewController, UITextFieldDelegate {
    
    @IBOutlet var textAdd: UITextField!
    @IBOutlet var datePicker: UIDatePicker!

    //Create a reference to the database Realm
    
    private let realm = try! Realm()
    
    public var saveHandler: (()-> Void)?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Open keyboard when view is displayed and delegate to it.
        textAdd.becomeFirstResponder()
        textAdd.delegate = self
        
        //Set the date to the one by default
        datePicker.setDate(Date(), animated: true)
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Add", style: .done, target: self, action: #selector(saveHomework))

        // Do any additional setup after loading the view.
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textAdd.resignFirstResponder() // Makes keyboard dissapear.
        return true
    }
    
    @objc func saveHomework(){
        //Check if text field is written
        if let text  = textAdd.text, !text.isEmpty{
            let date = datePicker.date
            
            //Save actual state to realm
            realm.beginWrite()
            
            let newHomework = ToDoHomework()
            newHomework.date = date
            newHomework.item = text
            realm.add(newHomework)
        
            try! realm.commitWrite()
            //The ? indicates that the save Handler is optional
            saveHandler?()
            
        }else{
            return
        }
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
