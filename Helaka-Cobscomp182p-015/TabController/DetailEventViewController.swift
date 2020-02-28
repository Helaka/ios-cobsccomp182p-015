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
    
 
    
    
//   EVENT EDIT
    
    
    @IBOutlet weak var eventEditImage: UIImageView!
    @IBOutlet weak var eventNameEdit: UITextField!
    
    @IBOutlet weak var eventDescEdit: UITextField!
    
    @IBOutlet weak var eventEditDate: UITextField!
    
    @IBOutlet weak var eventLocationEdit: UITextField!
    
    
    @IBOutlet weak var editEventErrLbl: UILabel!
    
    var image = UIImage()
    
    var loggedInUser = ""
    
    var date = ""
    var name = ""
    var ownernamee = ""
    var descriptionn = ""
    var location = ""
  

    override func viewDidLoad() {
        super.viewDidLoad()
        
        eventDate.text = "\(date)"
        eventName.text = "\(name)"
        eventImageView.image = image
        eventDescription.text = "\(descriptionn)"
        eventLocation.text = "\(location)"
        ownername.text = "\(ownernamee)"
        
        
        editView.alpha = 0
        
        editEventErrLbl.alpha = 0

        // Do any additional setup after loading the view.
        
        retriveUserData()
        checkLoggedInUserStatus()
        
    }
    

    @IBAction func editEventButtonClick(_ sender: Any) {
        
        updateEvent()
    }
    
    
    
    @IBAction func editPostButtonClick(_ sender: Any) {
        
        
//        eventLocationEdit.text = eventLocation.text
//        eventEditDate.text = eventDate.text
//        eventDescEdit.text = eventDescription.text
//        eventNameEdit.text = eventName.text
        
        
     editView.alpha = 1
    
    
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
                    self.detailEditButton.alpha = 1
                }else{
                    
                    self.detailEditButton.alpha = 0
                }
                
                
            } else {
                print("Document does not exist")
                
                
            }
        }
        
    }
    
    fileprivate func checkLoggedInUserStatus(){
        if Auth.auth().currentUser == nil{
            
            detailEditButton.alpha = 0
            
        }else{
            
            retriveUserData()
        }
        
    }
    
    
    
    func updateEvent(){
        
        
       
        let EventNameEdit = eventNameEdit.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        let EventDesctiptionEdit = eventDescEdit.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        let EventDateEdit = eventEditDate.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        let EventLocationEdit = eventLocationEdit.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        let database = Firestore.firestore().collection("Events").document(eventName.text!)

        
        
//        if !EventNameEdit.isEmpty || !EventDesctiptionEdit.isEmpty || !EventDateEdit.isEmpty || !EventLocationEdit.isEmpty {
        
            
            database.updateData(["eventname": EventNameEdit,"eventDescription":EventDesctiptionEdit,
                                 "eventDate":EventDateEdit , "eventLocation": EventLocationEdit]) { (err) in
                                    
                            if let err = err{
                                        
                                    print(err.localizedDescription)
                                    }
                                    
                                
            let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "tabBarControllerIdentifier")
                                    self.present(vc, animated: true, completion: nil)
                            
        }
            
           
//        }
        
        

        
        
        
    }
    
    
    
    
    
}
