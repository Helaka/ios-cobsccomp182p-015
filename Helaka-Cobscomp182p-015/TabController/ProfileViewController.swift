//
//  ProfileViewController.swift
//  Helaka-Cobscomp182p-015
//
//  Created by Minu Jayakody on 2/15/20.
//  Copyright © 2020 Minu Jayakody. All rights reserved.
//

import UIKit
import FirebaseAuth
import FirebaseStorage
import Firebase
import Kingfisher
import LocalAuthentication


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
        
//         handleFaceIdTouchIhandleFaceIdTouchIdd()
        
        view.backgroundColor = UIColor.white
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.title =  "Profile"
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Sign out", style: .done, target: self, action: #selector(handleSignOutButtonTapped))
        
       
        
        
        
    }
    
    
    
//
//    @objc fileprivate func handleFaceIdTouchId(){
//
//        let context = LAContext()
//
//        if context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: nil){
//            context.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: "To have an access to NIBM Events we need to check your faceId/TouchID") { (wasSuccessful, error) in
//                if wasSuccessful{
//
//                    self.dismiss(animated: true, completion:nil)
//
//
//                }else{
//                    Alert.showBasics(title: "Incorrect credentials", msg: "Please try again", vc: self)
//                }
//            }
//
//        }else{
//            Alert.showBasics(title: "FaceID/TouchID is not configured", msg: "Please go to settings", vc: self)
//        }
//    }
//
    
    
    @objc func handleSignOutButtonTapped(){

        UserDefaults.standard.removeObject(forKey: "userLogIn")
        UserDefaults.standard.removeObject(forKey: "userId")
        UserDefaults.standard.removeObject(forKey: "userLogged")
        UserDefaults.standard.synchronize()
        
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

    guard let uid = Auth.auth().currentUser?.uid else{ return }
        
      print(uid)

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
        }

    }
    
}
