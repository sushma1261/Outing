//
//  Login.swift
//  Outing
//
//  Created by SVECW-4 on 24/09/18.
//  Copyright © 2018 SVECW-5. All rights reserved.
//

import UIKit
import FirebaseAuth

class Login:UIViewController    {
    
    
    @IBOutlet weak var userNameField: UITextField!
    
    
    @IBOutlet weak var pwdField: UITextField!
    
    
    @IBAction func logBtn(_ sender: Any) {
        if userNameField.text != "" && pwdField.text != "" {
            
            UserDefaults.standard.set(userNameField.text, forKey:"regd")
            let x = userNameField.text! + "@svecw.edu.in"
            Auth.auth().signIn(withEmail: x, password: pwdField.text!, completion: {
                (result,error) in
                if let res = result{
                    
                    print("Login Sucessful")
                    if(self.userNameField.text?.hasPrefix("F"))! {
                        print("Something")
                        self.performSegue(withIdentifier: "loginFWelcome", sender: nil)
                    }
                    else if(self.userNameField.text?.hasPrefix("W"))! {
                        print("Something")
                        self.performSegue(withIdentifier: "warLog", sender: nil)
                    }
                    else {
                        self.performSegue(withIdentifier: "conn2", sender: nil)
                    }
                    
                }
                else{
                    self.showToast()
                    print("Login Error!!")
                }
            })
        }
        else{
            print("Enter details")
        }
        userNameField.resignFirstResponder()
    }
    
    func showToast(){
        let label = UILabel()
        label.frame = CGRect(x: 0, y:view.frame.height-100, width:view.frame.width-50,height:0)
        label.text = "Login Error"
        label.textAlignment = .center
        label.sizeToFit()
        label.font = UIFont(name: "Font-name", size: 17)
        label.backgroundColor = UIColor.black.withAlphaComponent(0.4)
        label.textColor = UIColor.white
        label.alpha = 1.0
        label.layer.cornerRadius = 5
        label.clipsToBounds = true
        label.frame.origin.x = (view.frame.width/2)-(label.frame.width/2)
        self.view.addSubview(label)
        
    }
    
    @IBAction func signupbtn(_ sender: Any) {
        self.performSegue(withIdentifier: "conn", sender: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}
