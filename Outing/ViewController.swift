//
//  ViewController.swift
//  Outing
//
//  Created by SVECW-4 on 24/09/18.
//  Copyright © 2018 SVECW-5. All rights reserved.
//

import UIKit
import FirebaseAuth


class ViewController: UIViewController {

    @IBOutlet weak var regdField: UITextField!
    @IBOutlet weak var pswdField: UITextField!
    
    @IBAction func LoginBtn(_ sender: Any) {
        UserDefaults.standard.set(regdField.text, forKey:"regd")
        if regdField.text != "" && pswdField.text != "" {
            var x = regdField.text! + "@svecw.edu.in"
            Auth.auth().createUser(withEmail: x, password: pswdField.text!, completion: {
                (result,error) in
                if error == nil{
                    print("User created")
                    if(self.regdField.text?.hasPrefix("F"))! {
                        print("Something")
                        self.performSegue(withIdentifier: "signFWel", sender: nil)
                    }
                    else if(self.regdField.text?.hasPrefix("W"))! {
                        print("Something")
                        self.performSegue(withIdentifier: "WarSign", sender: nil)
                    }
                    else {
                    self.performSegue(withIdentifier: "studconn1", sender: nil)
                    }
                }
                else{
                    print("Error")
                }
            })
        }
        else{
            print("Enter details")
        }
        regdField.resignFirstResponder()

        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
        
    }


}

