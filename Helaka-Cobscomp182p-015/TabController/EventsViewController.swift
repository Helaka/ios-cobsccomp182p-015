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
    
    var description : String
    
    var location : String
    
    var ownername : String
    
    var ownerid : String
    
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

  }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return eventsArray.count
    }
    
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return 400
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        
        return 1
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "EventCell") as!
        EventCell
        
        cell.eventName.text =  eventsArray[indexPath.row].eventname
        cell.eventDate.text = eventsArray[indexPath.row].eventdate
        cell.eventLocation.text = eventsArray[indexPath.row].location
        cell.ownerDescription.text = eventsArray[indexPath.row].description
        cell.ownerName.text = eventsArray[indexPath.row].ownername
        cell.ownerId.text = eventsArray[indexPath.row].ownerid
        
        let imagesURLS = URL(string: eventsArray[indexPath.row].imageurl)
        cell.EventImageView.kf.setImage(with: imagesURLS)
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let vc = storyboard?.instantiateViewController(withIdentifier: "eventDetail") as? DetailEventViewController
      
   
        vc?.date = eventsArray[indexPath.row].eventdate
        vc?.name = eventsArray[indexPath.row].eventname
        vc?.descriptionn = eventsArray[indexPath.row].description
        vc?.location = eventsArray[indexPath.row].location
        vc?.ownernamee = eventsArray[indexPath.row].ownername
        vc?.imageURl = eventsArray[indexPath.row].imageurl
        
        
        
        
        
        
        self.navigationController?.pushViewController(vc!, animated: true)
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
                    
                    let eventDescription = document.data()["eventDescription"] as? String
                    
                    let eventLocation = document.data()["eventlocation"] as! String
                
                    let ownerName = document.data()["ownername"] as! String
                    
                    let ownerId = document.data()["ownerID"] as! String
                    
                    let imageurll =  document.data()["EventImageurl"] as? String
                    
//                    let imageurl = document.data()["EventImageurl"] as? String
                    
//                    let imageURL = URL(string: imageurl!)!
                    
                    print(imageurll)
//
//                    
//
//                    let image = UIImage(data: imageData)
                    
                    let events = Eventss(eventname: eventname!, eventdate: Eventdate!, imageurl: imageurll!, description: eventDescription!, location:eventLocation, ownername: ownerName, ownerid: ownerId)
                    
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

