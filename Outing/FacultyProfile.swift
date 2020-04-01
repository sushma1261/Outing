//
//  FacultyProfile.swift
//  Outing
//
//  Created by SVECW-4 on 25/09/18.
//  Copyright © 2018 SVECW-5. All rights reserved.
//

import UIKit
import FirebaseDatabase

class FacultyProfile: UIViewController {
    var ref:DatabaseReference!
    var regd1 :String = ""
    
    @IBOutlet weak var idLabel: UILabel!
    
    
    @IBOutlet weak var nameLabel: UILabel!
    
    @IBOutlet weak var mobLabel: UILabel!
    
    
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        ref = Database.database().reference()
        if let regd:String = (UserDefaults.standard.value(forKey:"regd") as? String) {
            regd1 = regd
        }
        ref.child("faculty/\(regd1)").observeSingleEvent(of: DataEventType.value, with: { snapshot in
            
            if !snapshot.exists() { return }
            
            print(snapshot)
            self.idLabel.text = snapshot.childSnapshot(forPath: "Regnum").value as! String
            
            self.nameLabel.text = snapshot.childSnapshot(forPath: "name").value as! String
            self.mobLabel.text = String(snapshot.childSnapshot(forPath: "phnm").value as! Int64)
            
            
        })

        

    }
}
