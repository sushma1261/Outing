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
    
    @IBOutlet weak var dateText: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ref = Database.database().reference()
        table1.dataSource  = self
        table1.delegate = self
        //getDetails()
    }
    
    
    @IBAction func searchBtn(_ sender: Any) {
        regdArr.removeAll()
        ref.child("rejected").observeSingleEvent(of: DataEventType.value, with: { snapshot in
            var i:Int = 0
            print(snapshot)
            for rest in snapshot.children.allObjects as! [DataSnapshot] {
                for x in rest.children.allObjects as! [DataSnapshot] {
                    let t = x.value as! [String: Any]
                    let dd1 = t["from_date"] as! String
                    let ddText = self.dateText.text!
                    if(dd1 == ddText) {
                        print("Date Searched")
                        print(t["regnum"])
                        self.regdArr.insert(t["regnum"] as! String, at: i)
                        i = i + 1
                        self.table1.reloadData()
                    }
                }
            }
            
        })

        
    }
    
    
    func getDetails() {
        
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
