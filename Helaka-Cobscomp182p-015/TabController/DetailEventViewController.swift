//
//  DetailEventViewController.swift
//  Helaka-Cobscomp182p-015
//
//  Created by Minu Jayakody on 2/27/20.
//  Copyright © 2020 Minu Jayakody. All rights reserved.
//

import UIKit
import FirebaseAuth
import Firebase
import FirebaseStorage

class DetailEventViewController: UIViewController {
    @IBOutlet weak var eventImageView: UIImageView!
    
    @IBOutlet weak var eventLocation: UILabel!
    @IBOutlet weak var eventName: UILabel!
    
    @IBOutlet weak var eventDate: UILabel!
    
    @IBOutlet weak var eventDescription: UILabel!
    
    @IBOutlet weak var ownername: UILabel!
    
    @IBOutlet weak var detailEditButton: UIButton!

    @IBOutlet weak var editView: UIView!
    
    @IBOutlet weak var OwnerDeatilsView: UIView!
    
    @IBOutlet weak var EventdetailsScrollview: UIScrollView!
    
    @IBOutlet weak var OwnerProfileimage: UIImageView!
    
    @IBOutlet weak var goingButton: UIButton!
    
 
    var image = UIImage()
    var loggedInUser = ""
    
    var date = ""
    var name = ""
    var ownernamee = ""
    var descriptionn = ""
    var location = ""
    var imageURl = ""
    
   var eventname = ""
   var eventlocation = ""
   var eventdescription = ""
   var eventdate = ""
  

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        OwnerDeatilsView.layer.cornerRadius = 20
        EventdetailsScrollview.layer.cornerRadius = 30
        goingButton.layer.cornerRadius = 15
        OwnerProfileimage.layer.cornerRadius = OwnerProfileimage.frame.size.width/2
        
        
        
        eventDate.text = "\(date)"
        eventName.text = "\(name)"
        eventDescription.text = "\(descriptionn)"
        eventLocation.text = "\(location)"
        ownername.text = "\(ownernamee)"
        
        let imagesURLS = URL(string: "\(imageURl)")
        eventImageView.kf.setImage(with: imagesURLS)
        
        
        retriveUserData()
        checkLoggedInUserStatus()
        
    }
    
    @IBAction func editButtonCLick(_ sender: Any) {
        
        
        eventname = eventName.text!
        eventlocation = eventLocation.text!
        eventdate = eventDate.text!
        eventdescription = eventDescription.text!
        
        performSegue(withIdentifier: "eventeditname", sender: self)
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        let vc = segue.destination as! EditEventViewController
        vc.finaleventname = self.eventname
        vc.finaleventlocation = self.eventlocation
        vc.finaleventdate = self.eventdate
        vc.finaleventdescription = self.eventdescription
        
    }
    
    
    func retriveUserData(){
        
        guard let uid = Auth.auth().currentUser?.uid else{ return }
        
        print(uid)
        
        let db = Firestore.firestore()
        
        let docRef = db.collection("users").document(uid)
        
        print(docRef)
        
        docRef.getDocument { (document, error) in
            if let document = document, document.exists {
                let dataDescription = document.data().map(String.init(describing:)) ?? "nil"
                print("Document data: \(dataDescription)")
                
                self.loggedInUser = (document.get("firstname") as! String)
                
                if(self.loggedInUser == self.ownername.text){
                    
                    print("works")

                }else{
                    
                }
                
                
            } else {
                print("Document does not exist")
                
                
            }
        }
        
    }
    
    fileprivate func checkLoggedInUserStatus(){
        if Auth.auth().currentUser == nil{
            

            
        }else{
            
            retriveUserData()
        }
        
    }
    
    
    
    
    
}
