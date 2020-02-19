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
import FirebaseDatabase

class ProfileViewController: UIViewController , UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet weak var profileImage: UIImageView!
    
    @IBOutlet weak var saveButton: UIButton!
    @IBOutlet weak var userNameTextField: UILabel!
    
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
//            let tabBarController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "tabBarControllerIdentifier")
//            if let navigator = self.navigationController {
//                navigator.pushViewController(tabBarController, animated: true)
//            }
            
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
            
        
        }
        
    }
//
//    func setupProfile(){
//
//          if Auth.auth().currentUser?.uid == nil{
//
//            checkLoggedInUserStatus()
//
//        }else{
//            profileImage.layer.cornerRadius = profileImage.frame.size.width/2
//            profileImage.clipsToBounds = true
//
//            let uid = Auth.auth().currentUser?.uid
//            databaseRef.child("users").child(uid!).observeSingleEvent(of: .value) { (snapshot) in
//
//                if let dict = snapshot.value as? [String: AnyObject]{
//
//                    self.userNameTextField.text = dict["fistname"] as? String
//                    if let profileImageURL = dict["pic"] as? String{
//
//                        let url = URL(string: profileImageURL)
//                        URLSession.shared.dataTask(with: url!, completionHandler: { (data, response, error) in
//
//                            if error != nil{
//
//                                print(error! )
//                                return
//
//                            }
//                            DispatchQueue.main.async {
//                                self.profileImage?.image = UIImage(data: data!)
//                            }
//                        }).resume()
//                    }
//                }
//            }
//        }
    
        
        
       
//    }

//    @IBAction func saveButtonClick(_ sender: Any) {
//
//        saveChanges()
//
//    }
    
    

    
    
//    @IBAction func uploadImageButtonClick(_ sender: Any) {
//
//        let picker = UIImagePickerController()
//        picker.delegate = self
//        picker.allowsEditing = true
//        picker.sourceType = .photoLibrary
//        self.present(picker , animated: true , completion: nil)
//    }
//
//    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
//
//        var selectedImageFrontPicker: UIImage?
//
//        if let editedImage = info[UIImagePickerController.InfoKey.editedImage] as? UIImage{
//
//            selectedImageFrontPicker = editedImage
//        }else if let originalImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage{
//
//            selectedImageFrontPicker = originalImage
//        }
//
//        if let selectedImage = selectedImageFrontPicker {
//
//            profileImage.image = selectedImage
//        }
//        dismiss(animated: true, completion: nil)
//
//    }
    
//    func saveChanges(){
//
//
//        let imageName = NSUUID().uuidString
//
//        let storedImage = storageRef.child("profile_images").child(imageName)
//
//        if let updatedData = (self.profileImage.image)!.pngData(){
//
//            storedImage.putData(updatedData, metadata: nil) { (metadata, error) in
//                if error != nil {
//                     print(error!)
//                    return
//                }
//                storedImage.downloadURL(completion: { (url, error) in
//
//                    if error != nil {
//                        print(error)
//                        return
//                    }
//                    if let urlText = url?.absoluteString{
//
//                        self.databaseRef.child("users").child(Auth.auth().currentUser!.uid).updateChildValues(["pic": urlText], withCompletionBlock: { (error, ref) in
//
//                            if error != nil {
//
//                                print(error!)
//
//                                return
//                            }
//                        })
//                    }
//                })
//            }
//        }
//    }
//
}
