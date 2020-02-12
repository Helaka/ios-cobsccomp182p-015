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

class SignUpViewController: UIViewController {

    @IBOutlet weak var fnameTextField: UITextField!
    @IBOutlet weak var lastnameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var errorLabel: UILabel!
    
    let validation = Validations()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        
        errorLabel.alpha = 0
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
    
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
    
    
   

    @IBAction func signUpButtonClick(_ sender: Any) {
        
        let errorMessage = validateTextFields()
        
        if errorMessage != nil{
            
            showErrorMessage(errorMessage!)
        }else{
            
            
            let fNameText = fnameTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            
            let lNameText = lastnameTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            
            let emailText = emailTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            
            let passwordText = passwordTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            
            
            Auth.auth().createUser(withEmail: emailText, password: passwordText) { (result, error) in
                
                if error != nil {
                    
                    self.showErrorMessage("Error when creating the user please try it again")
                } else {
                    
                  let database = Firestore.firestore()
                    
                    database.collection("users").addDocument(data: ["firstname":fNameText, "lastname":lNameText, "email":emailText, "password":passwordText, "uid": result!.user.uid ])  { (error) in
                        
                        
                        if error != nil {
                            
                            self.showErrorMessage("Error in SignUp")
                        }
                    }
                    
                    
                    self.redirectToHomeController()
                    
                    
                    
                }
            }
            errorLabel.alpha = 0
        }
    }
    
    func showErrorMessage(_ errorMessage:String){
        
        
        errorLabel.text = errorMessage
        errorLabel.alpha = 1
    }
    
    
    func redirectToHomeController(){
        
        let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "HomeViewController") 
        self.present(vc, animated: true, completion: nil)
    }
    
    
//    func passwordReset(email: String, onSuccess: @escaping()->Void, onError: @escaping(_
//        errorMessage: String)-> Void){
//        
//        let resetEmailText = resetEmailTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
//        
//        Auth.auth().sendPasswordReset(withEmail: resetEmailText) { (error) in
//            
//            if error == nil{
//                
//                onSuccess()
//            }else{
//                
//                onError(error!.localizedDescription)
//            }
//        }
//        
//    }
    
}
