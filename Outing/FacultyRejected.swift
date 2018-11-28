//
//  FacultyRejected.swift
//  Outing
//
//  Created by SVECW-4 on 26/09/18.
//  Copyright © 2018 SVECW-5. All rights reserved.
//

import UIKit
import FirebaseDatabase

class FacultyRejected: UIViewController,UITableViewDelegate,UITableViewDataSource{
    
    @IBOutlet weak var table1: UITableView!
    var regdArr:[String] = []
    
    var ref: DatabaseReference!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        table1.dataSource  = self
        table1.delegate = self
        getDetails()
    }
    
    func getDetails() {
        ref = Database.database().reference()
        ref.child("rejected").observeSingleEvent(of: DataEventType.value, with: { snapshot in
            var i:Int = 0
            //print(snapshot)
            for rest in snapshot.children.allObjects as! [DataSnapshot] {
                let restDict = rest.value as? [String:Any]
               // print(restDict)
                let x = rest.key as? String
               print("regd"+x!)
                print(i)
                self.regdArr.insert(x!, at: i)
                i = i + 1
                self.table1.reloadData()
            }
            print(self.regdArr)
        })
        //print(regdArr)
        //ild("rejected").obser
    }


    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = table1.dequeueReusableCell(withIdentifier: "cellRej", for: indexPath) as? CustomCell2
        cell?.regdL?.text = regdArr[indexPath.row]
        return cell!
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return regdArr.count
    }
    
}
