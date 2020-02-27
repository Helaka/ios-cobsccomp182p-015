//
//  EventsViewController.swift
//  Helaka-Cobscomp182p-015
//
//  Created by Minu Jayakody on 2/15/20.
//  Copyright © 2020 Minu Jayakody. All rights reserved.
//

import UIKit
import FirebaseStorage
import Firebase
import Kingfisher




struct Eventss {

    var eventname : String
    
    var eventdate: String
    
    var imageurl : String
    
}


class EventsViewController: UITableViewController{

    var eventsArray = [Eventss](){
        
        didSet{
            tableView.reloadData()
        }
    }
    
    @IBOutlet weak var eventName: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
       getAllData()
//        checkLoggedInUserStatus()
  }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return eventsArray.count
    }
    
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        
        return 150
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        
        
        return 1
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "EventCell") as!
        EventCell
        
            cell.eventName.text =  eventsArray[indexPath.row].eventname
        cell.eventDate.text = eventsArray[indexPath.row].eventdate
        
        
//            cell.etext = eventsArray[indexPath.row].description
        
        
        let imageut = URL(string: eventsArray[indexPath.row].imageurl)
        cell.EventImageView.kf.setImage(with: imageut)
        
//        cell.EventImageView.image =  UIImage[eventsArray[indexPath.row].imageurl]
        
   
            
        
//            cell.EventImageView.kf.setImage(with: )
        return cell
    }
    
    func getAllData(){
    
        let db = Firestore.firestore()
        db.collection("Events").getDocuments() { (querySnapshot, err) in
            if let err = err {
                print("Error getting documents: \(err)")
            } else {
                for document in querySnapshot!.documents {
                    
                
                    let eventname = document.data()["eventname"] as? String
                    
                    let Eventdate = document.data()["eventdate"] as? String
                    
                    
                    let imageurll =  document.data()["EventImageurl"] as? String
                    
//                    let imageurl = document.data()["EventImageurl"] as? String
                    
//                    let imageURL = URL(string: imageurl!)!
                    
                    print(imageurll)
//
//                    
//
//                    let image = UIImage(data: imageData)
                    
                    let events = Eventss(eventname: eventname!, eventdate: Eventdate!, imageurl: imageurll!)
                    
                    self.eventsArray.append(events)
                    
                    self.tableView.reloadData()
                        
                        print(events)
                }
            }
            
            print(self.eventsArray) // <-- This prints the content in db correctly

//            }
        }
        
        
    }

  
//    
//    fileprivate func checkLoggedInUserStatus(){
//        if Auth.auth().currentUser == nil{
//            
//            DispatchQueue.main.async {
//               self.getAllData()
//            }
//        }else{
//            
//          getAllData()
//        }
//        
//    }
    
    
}

