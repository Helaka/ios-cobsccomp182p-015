//
//  SignInViewController.swift
//  Helaka-Cobscomp182p-015
//
//  Created by Minu Jayakody on 2/10/20.
//  Copyright © 2020 Minu Jayakody. All rights reserved.
//

import UIKit
import FirebaseAuth
import Firebase
import FirebaseStorage

class SignUpViewController: UIViewController {

    @IBOutlet weak var fnameTextField: UITextField!
    @IBOutlet weak var lastnameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var errorLabel: UILabel!
    
    var image: UIImage? = nil

    @IBOutlet weak var profileImage: UIImageView!
    
    let validation = Validations()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        errorLabel.alpha = 0
        
        setUpProfileImage()
        
    }
    
//    Text Field Validations
    
    func validateTextFields() -> String? {
        
        if fnameTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" || lastnameTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||
            emailTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||
            passwordTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == ""{
            
            return "Please fill all the text fields"
        }
        
        let passwordValidate = passwordTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        let emailValidate = emailTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        
        if Validations.isPasswordValid(passwordValidate) == false{
            
            return "Please make password 8 charactors long with special charactors and numbers"
        }
        
        if validation.isValidEmail(emailValidate) == false {
            
            return "Invalid email Address please enter Valid email address"
        }
        
        return nil
    }
    
//    SignUp Button Click
    @IBAction func signUpButtonClick(_ sender: Any) {
        
        let errorMessage = validateTextFields()
        if errorMessage != nil{
            
            showErrorMessage(errorMessage!)
        }else{
          
            
            signUp()

            errorLabel.alpha = 0
        }
    }
    
    
//     Error message
    func showErrorMessage(_ errorMessage:String){
        
        
        errorLabel.text = errorMessage
        errorLabel.alpha = 1
    }
    
//    Event Page Redirect
    func redirectToHomeController(){
        
        let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "tabBarControllerIdentifier")
        self.present(vc, animated: true, completion: nil)
    }
    
//    SignUp Process firebase
    
    func signUp(){
        
        
        let fNameText = fnameTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        
        let lNameText = lastnameTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        
        let emailText = emailTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        
        let passwordText = passwordTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        
        guard let imageSelected = self.image else{
            
            print("profile image nil")
            return
        }
        
        guard let imageData = imageSelected.jpegData(compressionQuality: 0.4)else{
            
            return
        }
        
        Auth.auth().createUser(withEmail: emailText, password: passwordText) { (result, error) in
            
            if error != nil {
                
                self.showErrorMessage("Error when creating the user please try it again")
            } else {
                
                
                
                let storageRef = Storage.storage().reference(forURL: "gs://event-app-93d34.appspot.com")
                let storageProfileRef = storageRef.child("profile").child((result?.user.uid)!)
                
                let metadata = StorageMetadata()
                let database = Firestore.firestore()
                metadata.contentType = "image/jpg"
                storageProfileRef.putData(imageData, metadata: metadata, completion: { (StorageMetadata, error) in
                    
                    if error != nil
                    {
                        print(error?.localizedDescription)
                        return
                    }
                    
                    storageProfileRef.downloadURL(completion: { (url, error) in
                        
                        if let metaImageUrl = url?.absoluteString{
                            
                            database.collection("users").addDocument(data: ["firstname":fNameText, "lastname":lNameText, "email":emailText, "password":passwordText, "profileimageurl":metaImageUrl, "uid": result!.user.uid ])  { (error) in
                                
                                
                                if error != nil {
                                    
                                    self.showErrorMessage("Error in SignUp")
                                }
                            }
                            
                            print(metaImageUrl)
                        }
                    })
                    
                    
                })
                
                
                
               
                
                self.redirectToHomeController()
                
            }
        }
        
    }
    
    
    func setUpProfileImage(){
        
        
        profileImage.layer.cornerRadius = profileImage.frame.size.width/2
        profileImage.clipsToBounds = true
        profileImage.isUserInteractionEnabled = true
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(presentPicker))
        profileImage.addGestureRecognizer(tapGesture)
    }
    
    
    @objc func presentPicker(){
        
        let picker = UIImagePickerController()
        picker.sourceType = .photoLibrary
        picker.allowsEditing = true
        picker.delegate = self
        self.present(picker, animated: true , completion: nil)
        
        
    }
    
}


extension SignUpViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate{
    
    
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        if let imageSelected = info[UIImagePickerController.InfoKey.editedImage] as? UIImage{
            
            image = imageSelected
            profileImage.image = imageSelected
        }
        
        if let imageOriginal = info[UIImagePickerController.InfoKey.originalImage] as? UIImage{
            
            image = imageOriginal
            profileImage.image = imageOriginal
        }
        
        picker.dismiss(animated: true, completion: nil)
    }
}



