//
//  ProfileViewController.swift
//  Helaka-Cobscomp182p-015
//
//  Created by Minu Jayakody on 2/15/20.
//  Copyright © 2020 Minu Jayakody. All rights reserved.
//

import UIKit
import FirebaseAuth
import FirebaseDatabase
import FirebaseStorage
import Firebase
import Kingfisher


class ProfileViewController: UIViewController , UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet weak var profileimage: UIImageView!
    @IBOutlet weak var usenameLabel: UILabel!
    
    @IBOutlet weak var emailTextLabel: UILabel!
    @IBOutlet weak var contactNumberLabel: UILabel!
    
//    @IBOutlet weak var saveButton: UIButton!
//    @IBOutlet weak var userNameTextField: UILabel!
    
//    let storageRef = Storage.storage().reference(forURL:"gs://event-app-93d34.appspot.com")
//    let databaseRef = Database.database().reference()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
    
        
        checkLoggedInUserStatus()
        
        view.backgroundColor = UIColor.white
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.title =  "Profile"
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Sign out", style: .done, target: self, action: #selector(handleSignOutButtonTapped))
        
       
        
        
        
    }
    
  
    
    
    @objc func handleSignOutButtonTapped(){
        
        do{
            try Auth.auth().signOut()
            let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "tabBarControllerIdentifier")
            self.present(vc, animated: true, completion: nil)
        }catch let err{
            
            print("Failed to sign out with error",err)
        
            
        }
      
    }
    
    fileprivate func checkLoggedInUserStatus(){
        if Auth.auth().currentUser == nil{
            
            DispatchQueue.main.async {
                let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "LoginView")
                self.present(vc, animated: true, completion: nil)
                
                return
            }
        }else{
        
            retriveUserData()
        }
        
    }
        
    
    
    
    
    func retriveUserData(){
//
//
//
//
//        if Auth.auth().currentUser != nil{
//
//
                        guard let uid = Auth.auth().currentUser?.uid else{
                            return
                        }
        
        print(uid)
//            ////
//            //            Database.database().reference().child("users").child(uid).observeSingleEvent(of: .value, with: { (snapshot) in
//            //
//            //                guard let dict = snapshot.value as? [String : Any] else { return }
//            //
//            //                let user = CurrentUser(uid: uid, dictionary: dict)
//            //
//            //                self.usenameLabel.text = user.name
//            //
//            //            }) { (error) in
//            //
//            //                print(error)
//            //            }
        
       
//
//
            let db = Firestore.firestore()

            let docRef = db.collection("users").document(uid)
        
        print(docRef)

            docRef.getDocument { (document, error) in
                if let document = document, document.exists {
                    let dataDescription = document.data().map(String.init(describing:)) ?? "nil"
                    print("Document data: \(dataDescription)")



                     self.usenameLabel.text = (document.get("firstname") as! String)
                     self.emailTextLabel.text = (document.get("email") as! String)
                    let profile = (document.get("profileimageurl") as! String)
                    self.profileimage.kf.setImage(with: URL(string: profile), placeholder: nil, options: [.transition(.fade(0.7))], progressBlock: nil)

                } else {
                    print("Document does not exist")
                }

//            docRef.collection("users").document(currentUser.uid)
//                .getDocument { (snapshot, error ) in
//
//                    if let document = snapshot {
//
//                        let user = User.transformUser(dict: document.data()!, key: document.documentID)
//                        completion(user)
//
//                    } else {
//
//                        print("Document does not exist")
//
//                    }
//            }
//            }
    
//        guard let currentUser = Auth.auth().currentUser else{
//            return
//        }
        
//        db.collection("users").document(currentUser.uid)
//            .getDocument { (snapshot, error ) in
//
//                if let document = snapshot {
//
////                    let user = User.transformUser(dict: document.data()!, key: document.documentID)
////                    completion(user)
//                    self.usenameLabel.text =  (document.get("firstname") as! String)
//                    self.emailTextLabel.text = (document.get("email") as! String)
//
//
//                } else {
//
//                    print("Document does not exist")
//
//                }
//        }
    }
//
//
//
//
    
//    end of retrieveUserData
    
//
//    func observeCurrentUser(completion: @escaping (User) -> Void) {
//        guard let currentUser = Auth.auth().currentUser else {
//            return
//        }
//                    let db = Firestore.firestore()
//        //
////        let docRef = db.collection("users").document("HbZm51TvFShpoXk8I3Li")
//        if let userId = Auth.auth().currentUser?.uid {
//            db.collection("users").document(currentUser.uid)
//                .getDocument { (snapshot, error ) in
//
//                    if let document = snapshot {
//
////                        let user = User.transformUser(dict: document.data()!, key: document.documentID)
////                        completion(user)
//                        self.usenameLabel.text =  (document.get("firstname") as! String)
//                        self.emailTextLabel.text = (document.get("email") as! String)
//
//                    } else {
//
//                        print("Document does not exist")
//
//                    }
//            }
//        }
//    }
    }
    
}
