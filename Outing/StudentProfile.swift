//
//  StudentProfile.swift
//  Outing
//
//  Created by SVECW-4 on 24/09/18.
//  Copyright © 2018 SVECW-5. All rights reserved.
//

import UIKit
import FirebaseDatabase
import FirebaseStorage
class StudentProfile:UIViewController   {
    
    @IBOutlet weak var photo: UIImageView!
    
    @IBOutlet weak var regd: UILabel!
    
    @IBOutlet weak var name: UILabel!
    
    @IBOutlet weak var branch: UILabel!
    
    @IBOutlet weak var stuNum: UILabel!
    
    @IBOutlet weak var dadNum: UILabel!
    
    @IBOutlet weak var momNum: UILabel!
    
    @IBOutlet weak var hostel: UILabel!
    
    @IBOutlet weak var roomNum: UILabel!
    
    @IBOutlet weak var selfLabel: UILabel!
    
    var ref:DatabaseReference!
    var imgName = ""
    var regd1 :String = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        ref = Database.database().reference()
        if let regd:String = (UserDefaults.standard.value(forKey:"regd") as? String) {
            regd1 = regd
            imgName = regd+".jpg"
        }
        print(regd1)
        let storage = Storage.storage().reference()
        let tempImageRef = storage.child(imgName)
        tempImageRef.getData(maxSize: 1*1000*1000) {
            (data,error) in
            if error == nil{
                //self.photo.image = UIImage(named : "img1.png")
                self.photo.layer.borderWidth = 1
                self.photo.layer.masksToBounds = false
                self.photo.layer.borderColor = UIColor.white.cgColor
                self.photo.layer.cornerRadius = self.photo.frame.height/2
                self.photo.clipsToBounds = true
                self.photo.image = UIImage(data:data!)
                print(data!)
            }
            else{
                print("Error!!!")
                print(error?.localizedDescription)
            }
        }

        
        ref.child("student/\(regd1)").observeSingleEvent(of: DataEventType.value, with: { snapshot in
            
            if !snapshot.exists() { return }
            
            print(snapshot)
            self.regd.text = snapshot.childSnapshot(forPath: "Regnum").value as! String
            
            self.name.text = snapshot.childSnapshot(forPath: "first_name").value as! String
            self.branch.text = snapshot.childSnapshot(forPath: "branch").value as! String
            self.stuNum.text = String(snapshot.childSnapshot(forPath: "student_number").value as! Int64)
            self.momNum.text = String(snapshot.childSnapshot(forPath: "parent_number").value as! Int64)
            self.dadNum.text = String(snapshot.childSnapshot(forPath: "parent_number").value as! Int64)
            self.hostel.text = snapshot.childSnapshot(forPath: "hostel_name").value as! String
            self.roomNum.text = String(snapshot.childSnapshot(forPath: "room_number").value as! Int)
            self.selfLabel.text = snapshot.childSnapshot(forPath: "self").value as! String
            
            
        })
        
    }
    
}
