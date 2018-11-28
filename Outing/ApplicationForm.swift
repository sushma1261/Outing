//
//  ApplicationForm.swift
//  Outing
//
//  Created by SVECW-4 on 24/09/18.
//  Copyright © 2018 SVECW-5. All rights reserved.
//

import UIKit

import FirebaseDatabase
class ApplicationForm :UIViewController {
    
    @IBOutlet weak var regLabel: UILabel!
    
    @IBOutlet weak var reason: UITextField!
    
    @IBOutlet weak var place: UITextField!
    
    @IBOutlet weak var from: UITextField!
    
    @IBOutlet weak var to: UITextField!
    
    var regd1 :String = ""
    var stuPhNum :String = ""
    var parPhNum :String = ""
    var stu:Int64 = 0
    var par:Int64 = 0
    var ref:DatabaseReference!
    
    private var datePicker: UIDatePicker?
    private var datePicker1: UIDatePicker?
    
    @IBAction func applyBtn(_ sender: Any) {
        ref.child("student/\(regd1)").observeSingleEvent(of: DataEventType.value, with: { snapshot in
            
            if !snapshot.exists() { return }
            print(snapshot)
            self.stuPhNum = String(snapshot.childSnapshot(forPath: "student_number").value as! Int64)
            
            self.parPhNum = String(snapshot.childSnapshot(forPath: "parent_number").value as! Int64)
            self.stu = Int64(self.stuPhNum)!
            self.par = Int64(self.parPhNum)!
            //print(self.stu)
            
            let data = ["reason": self.reason.text!,"place": self.place.text!,"from_date": self.from.text!,"to_date": self.to.text!,"regnum": self.regd1,"student_num": self.stu,"parent_num": self.par] as [String : Any]
            
            
            self.ref.child("requests").child(self.regd1).setValue(data)
            
        })
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ref = Database.database().reference()
        if let regd:String = (UserDefaults.standard.value(forKey:"regd") as? String) {
            regLabel.text = "Welcome" + regd
            regd1 = regd
            
        }
        getCurrentDate()
        datePicker = UIDatePicker()
        datePicker?.datePickerMode = .date
        datePicker?.minimumDate = Date()
        datePicker?.addTarget(self, action: #selector(ApplicationForm.dateChanged(datePicker:)), for: .valueChanged)
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(ApplicationForm.viewTapped(gestureRecognizer:)))
        view.addGestureRecognizer(tapGesture)
        from.inputView = datePicker
        datePicker1 = UIDatePicker()
        datePicker1?.datePickerMode = .date
        //let df = DateFormatter()
        //df.dateFormat = "dd-MM-yyyy"
        //datePicker1?.minimumDate = Calendar.current.date(byAdding: .day, value: 1, to: df.date(from: from.text!)!)
        //print("From Date:")
        //print(df.date(from: from.text!)!)
        datePicker1?.minimumDate = Date()
        datePicker1?.addTarget(self, action: #selector(ApplicationForm.dateChanged1(datePicker:)), for: .valueChanged)
        let tapGesture1 = UITapGestureRecognizer(target: self, action: #selector(ApplicationForm.viewTapped(gestureRecognizer:)))
        view.addGestureRecognizer(tapGesture1)
        to.inputView = datePicker1
        
    }
    @objc func viewTapped(gestureRecognizer : UITapGestureRecognizer){
        view.endEditing(true)
        
    }
    @objc func dateChanged(datePicker: UIDatePicker) {
        let dateFormatter = DateFormatter()
        
        dateFormatter.dateFormat = "dd-MM-yyyy"
        
        from.text = dateFormatter.string(from: datePicker.date)
        
        //to.text = dateFormatter.string(from: datePicker.date)
        view.endEditing(true)
    }
    @objc func dateChanged1(datePicker: UIDatePicker) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd-MM-yyyy"
        //from.text = dateFormatter.string(from: datePicker.date)
        to.text = dateFormatter.string(from: datePicker.date)
        view.endEditing(true)
    }
    func getCurrentDate() -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd-MM-yyyy"
        let str = formatter.string(from: Date())
        print(str)
        return str
    }
}
