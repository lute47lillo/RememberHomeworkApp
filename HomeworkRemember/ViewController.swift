//
//  ViewController.swift
//  HomeworkRemember
//
//  Created by Lute Lillo on 10/9/20.
//
import RealmSwift
import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    @IBAction func SelectWeekButton(){
        
        //Go to Navigation Controller
        self.performSegue(withIdentifier: "nv_vc", sender: self)
        
        
    }
        
        // Do any additional setup after loading the view.

}
    
  



