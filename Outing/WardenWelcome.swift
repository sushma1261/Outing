//
//  WardenWelcome.swift
//  Outing
//
//  Created by SVECW-4 on 26/09/18.
//  Copyright © 2018 SVECW-5. All rights reserved.
//

import UIKit
import FirebaseAuth
class WardenWelcome: UIViewController{
    
    
    @IBOutlet weak var warName: UILabel!
    
    
    @IBAction func navBtn(_ sender: Any) {
    }
    
    @IBAction func profWarBtn(_ sender: Any) {
    }
    
    
    @IBOutlet weak var leadConst: NSLayoutConstraint!
    
    var menuShowing = false
    
    @IBAction func slideBtn(_ sender: Any) {
        
        if(menuShowing){
            leadConst.constant = -148
        }
        else{
            leadConst.constant = 0
        }
        
        menuShowing = !menuShowing
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let regd:String = (UserDefaults.standard.value(forKey:"regd") as? String) {
            //print("Name:"+name)
            warName.text = "Welcome " + regd
            
        }
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
    
}
