//
//  StudentWelcome.swift
//  Outing
//
//  Created by SVECW-4 on 24/09/18.
//  Copyright © 2018 SVECW-5. All rights reserved.
//

import UIKit
import FirebaseAuth
import FirebaseStorage
class StudentWelcome:UIViewController   {
    
    
    @IBOutlet weak var photo: UIImageView!
    var imgName = ""
    @IBOutlet weak var welcomeLabel: UILabel!
    
    @IBAction func profileBtn(_ sender: Any) {
        self.performSegue(withIdentifier: "profileconn", sender: nil)
    }
    
    
    @IBAction func navigateBtn(_ sender: Any) {
        self.performSegue(withIdentifier: "appnconn", sender: nil)
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
            welcomeLabel.text = regd
            imgName = regd+".jpg"
        }
        
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
    }
    
}
