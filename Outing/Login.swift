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
                    print("Login Error!!")
                }
            })
        }
        else{
            print("Enter details")
        }
        userNameField.resignFirstResponder()
    }
    
    @IBAction func signupbtn(_ sender: Any) {
        self.performSegue(withIdentifier: "conn", sender: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}
