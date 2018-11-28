//
//  FacultyWelcome.swift
//  Outing
//
//  Created by SVECW-4 on 25/09/18.
//  Copyright © 2018 SVECW-5. All rights reserved.
//

import UIKit
import FirebaseAuth
class FacultyWelcome : UIViewController {
    
    
    @IBAction func navBtn(_ sender: Any) {
        self.performSegue(withIdentifier: "facmain", sender: nil)
    }
    
    
    @IBOutlet weak var wellabel: UILabel!
    
    @IBAction func profBtn(_ sender: Any) {
        self.performSegue(withIdentifier: "facprof", sender: nil)
    }
    
    @IBAction func logoutBtn(_ sender: Any) {
        let firebaseAuth = Auth.auth()
        do {
            print("In dooo")
            try firebaseAuth.signOut()
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let popOverVC = storyboard.instantiateViewController(withIdentifier: "xyz")
            self.addChildViewController(popOverVC)
            popOverVC.view.frame = self.view.frame
            
            self.view.addSubview(popOverVC.view)
            popOverVC.didMove(toParentViewController: self)
            
        } catch let signOutError as NSError {
            print ("Error signing out: %@", signOutError)
        }
        print("Lasttt")
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let regd:String = (UserDefaults.standard.value(forKey:"regd") as? String) {
            //print("Name:"+name)
            wellabel.text = "Welcome " + regd
            
        }
    }
}
