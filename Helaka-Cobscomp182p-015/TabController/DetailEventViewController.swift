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
    @IBOutlet weak var eventEditButton: UIButton!
    @IBOutlet weak var ownername: UILabel!
    @IBOutlet weak var OwnerDeatilsView: UIView!
    @IBOutlet weak var EventdetailsScrollview: UIScrollView!
    @IBOutlet weak var OwnerProfileimage: UIImageView!
    @IBOutlet weak var goingButton: UIButton!
    @IBOutlet weak var goingErrorLable: UILabel!
    @IBOutlet weak var goingSignUpButtonClick: UIButton!
    @IBOutlet weak var goingCount: UILabel!
    @IBOutlet weak var uidLabel: UILabel!
    
    @IBOutlet weak var profileImageButton: UIView!
    @IBOutlet weak var likeButton: UIButton!
    @IBOutlet weak var CountOverView: UIView!
    
    @IBOutlet weak var profileButtonClick: UIButton!
    @IBOutlet weak var likeCountimageview: UIImageView!

    
    @IBOutlet weak var goingCountimageview: UIImageView!
    @IBOutlet weak var sharecountimageview: UIImageView!
    // going count
    
    @IBOutlet weak var likeCountLabel: UILabel!
    var attendeceCount: Int = 0
   
    
    
    var image = UIImage()
    var loggedInUser = ""

    // like count
     let count = ""
    
    var date = ""
    var name = ""
    var ownernamee = ""
    var descriptionn = ""
    var location = ""
    var imageURl = ""
    var uid = ""
   
    var eventname = ""
    var eventlocation = ""
    var eventdescription = ""
    var eventdate = ""
  
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        // hide error message and signup button
        
         UserDefaults.standard.string(forKey: "goingcount")
        goingErrorLable.alpha = 0
        goingSignUpButtonClick.alpha = 0
        
        // set goingcount label to 0
        
        goingCount.text = "0"
     
        
        
        
        // get goin count
        
        
        CountOverView.layer.cornerRadius = 20
        likeCountimageview.layer.cornerRadius = likeCountimageview.frame.size.width/2
        goingCountimageview.layer.cornerRadius = goingCountimageview.frame.size.width/2
//        sharecountimageview.layer.cornerRadius = sharecountimageview.frame.size.width/2
 
        
        OwnerDeatilsView.layer.cornerRadius = 20
        EventdetailsScrollview.layer.cornerRadius = 30
        goingButton.layer.cornerRadius = 15
        OwnerProfileimage.layer.cornerRadius = OwnerProfileimage.frame.size.width/2
        
        eventDate.text = "\(date)"
        eventName.text = "\(name)"
        eventDescription.text = "\(descriptionn)"
        eventLocation.text = "\(location)"
        ownername.text = "\(ownernamee)"
        uidLabel.text = "\(uid)"
        
        let imagesURLS = URL(string: "\(imageURl)")
        eventImageView.kf.setImage(with: imagesURLS)
        
        retriveUserData()
        checkLoggedInUserStatus()
        getEventOwnerProfile()
        
        setUpProfileImage()
        
    }
    
    @IBAction func editButtonCLick(_ sender: Any) {
        
        eventname = eventName.text!
        eventlocation = eventLocation.text!
        eventdate = eventDate.text!
        eventdescription = eventDescription.text!
        
        performSegue(withIdentifier: "eventeditname", sender: self)
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        
        
        if segue.identifier == "eventeditname"{
           
            let vc = segue.destination as! EditEventViewController
            
            vc.finaleventname = self.eventname
            vc.finaleventlocation = self.eventlocation
            vc.finaleventdate = self.eventdate
            vc.finaleventdescription = self.eventdescription
        }
        else{
              let vc = segue.destination as! EventOwnerProfileViewController
            
                vc.userid = self.uid
        }
        
        
    }
    
    
    func retriveUserData(){
        
        guard let uid = Auth.auth().currentUser?.uid else{ return }
        
        print(uid)
        
        let db = Firestore.firestore()
        
        let docRef = db.collection("users").document(uid)
        
        docRef.getDocument { (document, error) in
            if let document = document, document.exists {
                _ = document.data().map(String.init(describing:)) ?? "nil"
//                print("Document data: \(dataDescription)")
                
                self.loggedInUser = (document.get("firstname") as! String)
                
                if(self.loggedInUser == self.ownername.text){
                    
                        self.eventEditButton.alpha = 1
                }else{
                    
                    self.eventEditButton.alpha = 0
                }
                
            } else {
                print("Document does not exist")
                
                
            }
        }
        
    }
    
    fileprivate func checkLoggedInUserStatus(){
        if Auth.auth().currentUser == nil{
            
          self.eventEditButton.alpha = 0
            
            
        }else{
            
            retriveUserData()
         
        }
        
    }
    
    
    func checkRegisterdUser(){
        
        
        if Auth.auth().currentUser == nil{

            
            goingErrorLable.text = "Please login to mark attendence"
            goingErrorLable.alpha = 1
            
            goingSignUpButtonClick.alpha = 1
            goingCount.alpha = 0
            
        
        }else{
            
            goingErrorLable.alpha = 0
            
            goingCount.alpha = 1
            goingSignUpButtonClick.alpha = 0
        
            
            updateGoingCount()
            
            getGoingCount()
            
            

        }
    }
    
    
    @IBAction func goingButtonClick(_ sender: Any) {
        
        checkRegisterdUser()
        
    }
    
    func LikeButtonCheck(){
        
        if Auth.auth().currentUser == nil{
            
            
            goingErrorLable.text = "Please login to Like this event"
            goingErrorLable.alpha = 1
            
            goingSignUpButtonClick.alpha = 1
            likeButton.alpha = 1
            goingCount.alpha = 0
            
            
        }else{
            
            goingErrorLable.alpha = 0
            
            goingCount.alpha = 1
            goingSignUpButtonClick.alpha = 0
            
            
            updateLikeCount()
            
//            getGoingCount()
            getLikeCount()
            
        }
        
    }
    
    
    
    
    @IBAction func likeButtonClick(_ sender: Any) {
        
        LikeButtonCheck()
    }
    
    
    
    @IBAction func goinSignUpButtonClick(_ sender: Any) {
        
        redirectToSignUpController()
        
        
    }
    
    func redirectToSignUpController(){
        let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "signUpView")
        self.present(vc, animated: true, completion: nil)
    }
    
    
    
    func updateGoingCount(){
        
        
        print(eventName.text as Any)
           let database = Firestore.firestore().collection("Events").document(eventName.text!)
        
        database.updateData(["goingCount": FieldValue.increment(Int64(1))]) { (err) in
            
            if let err = err {
                
                print(err.localizedDescription)
            }else{
                
                
                self.goingButton.isUserInteractionEnabled = false
                
                
            }
            
            
            
        }
    }
    
    
    
    func getGoingCount(){
        
        let db = Firestore.firestore()
        
        let docRef = db.collection("Events").document(eventName.text!)
        
        
        docRef.getDocument { (document, error) in
            if let document = document, document.exists {
                let dataDescription = document.data().map(String.init(describing:)) ?? "nil"
                print("Document data: \(dataDescription)")
                
                
                    let count = ((document.get("goingCount") as! NSNumber))
           
                    self.goingCount.text = count.stringValue
                print(self.goingCount.text)
                
            } else {
                print("Document does not exist")
            }
        }
    }
    
    
    
    func updateLikeCount(){
        
    
        let database = Firestore.firestore().collection("Events").document(eventName.text!)
        
        database.updateData(["likecount": FieldValue.increment(Int64(1))]) { (err) in
            
            if let err = err {
                
                print(err.localizedDescription)
            }else{
                
                
                self.likeButton.isUserInteractionEnabled = false
                
                
            }
            
            
            
        }
    }
    
    
    
   
    func getLikeCount(){
        
        let db = Firestore.firestore()
        
        let docRef = db.collection("Events").document(eventName.text!)
        
        
        docRef.getDocument { (document, error) in
            if let document = document, document.exists {
                let dataDescription = document.data().map(String.init(describing:)) ?? "nil"
                print("Document data: \(dataDescription)")
                
                
                let count = ((document.get("likecount") as! NSNumber))
                
                self.likeCountLabel.text = count.stringValue
                
                
            } else {
                print("Document does not exist")
            }
        }
    }
    
    
    
    
    func getEventOwnerProfile(){
        
        
        let ownerProfile = Firestore.firestore()
        
        let ownerProfileRef = ownerProfile.collection("users").document(uidLabel.text!)
        
        
        ownerProfileRef.getDocument { (document, error) in
            if let document = document, document.exists {
                _ = document.data().map(String.init(describing:)) ?? "nil"
                //                print("Document data: \(dataDescription)")
                
                let ownerProfileImage = (document.get("profileimageurl") as! String)
                self.OwnerProfileimage.kf.setImage(with: URL(string: ownerProfileImage), placeholder: nil, options: [.transition(.fade(0.7))], progressBlock: nil)
                
            } else {
                print("Document does not exist")
                
                
            }
        }
    }
    
    
    func setUpProfileImage(){
        
        
        
        //        profileImage.layer.cornerRadius = profileImage.frame.size.width/2
        OwnerProfileimage.clipsToBounds = true
        OwnerProfileimage.isUserInteractionEnabled = true
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(imageclick))
        OwnerProfileimage.addGestureRecognizer(tapGesture)
        
        
    }
    
    
    @objc func imageclick(){
        
//        let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "EventOwnerProfile")
//        self.present(vc, animated: true, completion: nil)
//        
//               performSegue(withIdentifier: "eventeditname", sender: self)
    }
  
//    @IBAction func profileImagBtnClick(_ sender: Any) {
//
//
//
//    }
//
//    @IBAction func ownerProfileImageClick(_ sender: Any) {
//
//        let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "EventOwnerProfile")
//        self.present(vc, animated: true, completion: nil)
//    }
//

    @IBAction func profileimagebuttonclick(_ sender: Any) {
        
       
          uid = uidLabel.text!
        
         performSegue(withIdentifier: "profileConnection", sender: self)
    }
    
    
    func markGoingEvent(){
        
        
        
        guard let uid = Auth.auth().currentUser?.uid else{ return }
        
        print(uid)
        
        let db = Firestore.firestore()
        
        let docRef = db.collection("users").document(uid)
        
        print(docRef)
        
        docRef.getDocument { (document, error) in
            if let document = document, document.exists {
                let dataDescription = document.data().map(String.init(describing:)) ?? "nil"
                print("Document data: \(dataDescription)")
                
                
                
              
                
            } else {
                print("Document does not exist")
            }
        }
    }
    
    
    
    
}
