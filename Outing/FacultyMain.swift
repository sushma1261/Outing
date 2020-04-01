//
//  FacultyMain.swift
//  Outing
//
//  Created by SVECW-4 on 25/09/18.
//  Copyright © 2018 SVECW-5. All rights reserved.
//

import UIKit

class FacultyMain: UIViewController {
    
    @IBAction func reqBtn(_ sender: Any) {
        self.performSegue(withIdentifier: "reqFac", sender: nil)
    }
    
    
    @IBAction func appBtn(_ sender: Any) {
        
    }
    
    @IBAction func rejBtn(_ sender: Any) {
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}
