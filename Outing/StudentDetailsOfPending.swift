//
//  StudentDetailsOfPending.swift
//  Outing
//
//  Created by SVECW-4 on 25/09/18.
//  Copyright © 2018 SVECW-5. All rights reserved.
//

import UIKit
import Firebase

class StudentDetailsOfPending: UIViewController,UITableViewDelegate,UITableViewDataSource {
    
    var regdNum:String = ""
    var approverId:String = ""
    var approverName:String = ""
    var stuName:String = ""
    var stuBr: String = ""
    var stuSelf:String = ""
    var ds:String = ""
    var stuYear:Int = 0
    var diffindays:Int = 0
    var ref:DatabaseReference!
    var stuNum:Int64 = 0
    var parNum:Int64 = 0
    
    @IBOutlet weak var regNum: UILabel!
    
    @IBOutlet weak var photo: UIImageView!
    
    var imgName = ""
    
    @IBOutlet weak var nameL: UILabel!
    
    @IBOutlet weak var branchL: UILabel!
    
    @IBOutlet weak var placeL: UILabel!
    
    @IBOutlet weak var reasonL: UILabel!
    
    @IBOutlet weak var fromL: UILabel!
    
    @IBOutlet weak var outL: UILabel!
    
    @IBOutlet weak var toL: UILabel!
    
    @IBOutlet weak var daysL: UILabel!
    
    
    @IBOutlet weak var table1: UITableView!
    var reasonArr:[String] = []
    var permitArr:[Int] = []
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.table1.dequeueReusableCell(withIdentifier: "cellDelay", for: indexPath) as? DelayCustomCell
        cell?.reasonL?.text = self.reasonArr[indexPath.row]
        cell?.permitL?.text = String(self.permitArr[indexPath.row])
        return cell!
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.reasonArr.count
    }

    
    @IBAction func callStuBtn(_ sender: UIButton) {
        let stuph : String = String(stuNum)
        sender.setTitle(stuph, for: .normal)
        if(stuph != "") {
            guard let num = sender.titleLabel?.text , let url = URL(string : "tel://\(num)") else {
                return
            }
            print(url)
            UIApplication.shared.open(url)
            print(sender.titleLabel?.text!)
        }

        
    }
    
    @IBAction func callParBtn(_ sender: UIButton) {
        
        let stuph : String = String(parNum)
        sender.setTitle(stuph, for: .normal)
        if(stuph != "") {
            guard let num = sender.titleLabel?.text , let url = URL(string : "tel://\(num)") else {
                return
            }
            print(url)
            UIApplication.shared.open(url)
            print(sender.titleLabel?.text!)
        }

    }
    
    
    
    @IBAction func appBtn(_ sender: UIButton) {
        ref.child("requests/\(regdNum)").observeSingleEvent(of: DataEventType.value, with: { snapshot in
            
            if !snapshot.exists() { return }
            
            //print(snapshot)
            if let value = snapshot.value{
                //there is data available
                var data = value as! Dictionary<String, AnyObject>
              //  print("\(data)")
                data["approverName"] = self.approverName as AnyObject
                data["branch"] = self.stuBr as AnyObject
                data["name"] = self.stuName as AnyObject
                data["permittedDays"] = self.diffindays as AnyObject
                data["self"] = self.stuSelf as AnyObject
                data["today"] = self.ds as AnyObject
                data["year"] = self.stuYear as AnyObject
                
            //self.ref.child("approved").child(self.regdNum).childByAutoId().setValue(data)
                self.ref.child("approved").child(self.regdNum).setValue(data)
                self.ref.child("requests").child(self.regdNum).removeValue()
            }
            
            
        }) { (error) in
            print(error.localizedDescription)
        }
        
    }
    
    
    @IBAction func rejectBtn(_ sender: Any) {
        
        ref.child("requests/\(regdNum)").observeSingleEvent(of: DataEventType.value, with: { snapshot in
            
            if !snapshot.exists() { return }
            
            print(snapshot)
            if let value = snapshot.value{
                //there is data available
                var data = value as! Dictionary<String, AnyObject>
                print("\(data)")
                data["approverName"] = self.approverName as AnyObject
                data["branch"] = self.stuBr as AnyObject
                data["name"] = self.stuName as AnyObject
                data["permittedDays"] = self.diffindays as AnyObject
                data["self"] = self.stuSelf as AnyObject
                data["today"] = self.ds as AnyObject
                data["year"] = self.stuYear as AnyObject
                
                self.ref.child("rejected").child(self.regdNum).childByAutoId().setValue(data)
                //self.ref.child("rejected").child(self.regdNum).setValue(data)
                self.ref.child("requests").child(self.regdNum).removeValue()
            }
            else{
                print("Error")
            }
            
            
        }) { (error) in
            print(error.localizedDescription)
        }
    }
    
    
    @IBOutlet weak var leadConst: NSLayoutConstraint!
    
    var menuShowing = false
    
    @IBAction func openMenuBtn(_ sender: Any) {
        
        if(menuShowing){
            leadConst.constant = -227
        }
        else{
            leadConst.constant = 0
        }
        
        menuShowing = !menuShowing
        getDetails()
        
    }
    func getDetails() {
        reasonArr.removeAll()
        permitArr.removeAll()
        ref.child("granted").observeSingleEvent(of: DataEventType.value, with: { snapshot in
            //print("Reason snap")
            //print(snapshot)
            var i:Int = 0
            for rest in snapshot.children.allObjects as! [DataSnapshot] {
                for x in rest.children.allObjects as! [DataSnapshot] {
                    let t = x.value as! [String: Any]
                    let reg = t["regnum"] as! String
                    
                    if(reg == self.regdNum){
                        
                        let fromdate = t["from_date"] as! String
                        let todate = t["to_date"] as! String
                        let df = DateFormatter()
                        df.dateFormat = "dd-MM-yyyy"
                        print(fromdate)
                        
                        let formatFd : Date? = df.date(from: fromdate)
                        let formattd : Date? = df.date(from: todate)
                        print(formatFd)
                        print(formattd)
                        let diff = formattd?.timeIntervalSince(formatFd!)
                        self.diffindays = Int(diff!/(60*60*24))
                        
                        print(self.diffindays)
                        self.permitArr.insert(self.diffindays as! Int, at: i)
                        
                        self.reasonArr.insert(t["reason"] as! String, at: i)
                        i = i + 1
                    }
                    self.table1.reloadData()
                }
            }
            
        })
    }

    
    override func viewDidLoad() {
        super.viewDidLoad()
        ref = Database.database().reference()
        table1.dataSource  = self
        table1.delegate = self
        
        if let regd:String = (UserDefaults.standard.value(forKey:"regdNo") as? String) {
            //print("Name:"+name)
            regNum.text = regd
            regdNum = regd
            imgName = regd+".jpg"
            print("regd:" + regd)
        }
        
        
        
        let storage = Storage.storage().reference()
        let tempImageRef = storage.child(imgName)
        tempImageRef.getData(maxSize: 1*1000*1000) {
            (data,error) in
            if error == nil{
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

        
        print(regdNum)
        ref.child("student/\(regdNum)").observeSingleEvent(of: DataEventType.value, with: { snapshot in
            
            if !snapshot.exists() { return }
            
            print(snapshot)
            self.nameL.text = snapshot.childSnapshot(forPath: "first_name").value as! String
            self.stuName = self.nameL.text!
            self.branchL.text  = snapshot.childSnapshot(forPath: "branch").value as! String
            self.stuBr = self.branchL.text!
            self.stuSelf  = snapshot.childSnapshot(forPath: "self").value as! String
            self.stuYear  = snapshot.childSnapshot(forPath: "year").value as! Int
            
        })
        
        ref.child("granted").child(regdNum).observeSingleEvent(of: DataEventType.value, with: { snapshot in
            
            if !snapshot.exists() { return }
            
            print(snapshot)
            print(snapshot.childrenCount)
            self.outL.text = String(snapshot.childrenCount)
        })
        
        ref.child("requests/\(regdNum)").observeSingleEvent(of: DataEventType.value, with: { snapshot in
            
            if !snapshot.exists() { return }
            print(snapshot)
            
            self.placeL.text = snapshot.childSnapshot(forPath: "place").value as! String
            self.reasonL.text  = snapshot.childSnapshot(forPath: "reason").value as! String
            self.fromL.text  = snapshot.childSnapshot(forPath: "from_date").value as! String
            self.toL.text  = snapshot.childSnapshot(forPath: "to_date").value as! String
            self.stuNum  = snapshot.childSnapshot(forPath: "student_num").value as! Int64
            self.parNum  = snapshot.childSnapshot(forPath: "parent_num").value as! Int64
            print(self.stuNum)
            print(self.parNum)
            
            let fromdate = snapshot.childSnapshot(forPath: "from_date").value as! String
            let todate = snapshot.childSnapshot(forPath: "to_date").value as! String
            let df = DateFormatter()
            df.dateFormat = "dd-MM-yyyy"
            print(fromdate)
            
            let formatFd : Date? = df.date(from: fromdate)
            let formattd : Date? = df.date(from: todate)
            print(formatFd)
            print(formattd)
            let diff = formattd?.timeIntervalSince(formatFd!)
            self.diffindays = Int(diff!/(60*60*24))
            
            print(self.diffindays)
            self.daysL.text = String(self.diffindays)
            
        })
        
        if let regd:String = (UserDefaults.standard.value(forKey:"regd") as? String) {
            approverId = regd
        }
        
        ref.child("faculty/\(approverId)").observeSingleEvent(of: DataEventType.value, with: { snapshot in
            
            if !snapshot.exists() { return }
            
            print(snapshot)
            self.approverName = snapshot.childSnapshot(forPath: "name").value as! String
            
            
        })
        
    }
}
