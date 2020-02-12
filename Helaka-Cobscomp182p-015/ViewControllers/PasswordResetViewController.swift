//
//  PasswordResetViewController.swift
//  Helaka-Cobscomp182p-015
//
//  Created by Minu Jayakody on 2/12/20.
//  Copyright © 2020 Minu Jayakody. All rights reserved.
//

import UIKit
import FirebaseAuth
import Firebase



class PasswordResetViewController: UIViewController {

    @IBOutlet weak var resetEmailTextField: UITextField!
    
    @IBOutlet weak var errorLabel: UILabel!
    @IBOutlet weak var sendButton: UIButton!
    
      let validation = Validations()
    
    let signUpViewController = SignUpViewController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        errorLabel.alpha = 0

        // Do any additional setup after loading the view.
    }
    
    @IBAction func sendButtonClick(_ sender: Any) {
         let resetEmailText = resetEmailTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
           let errorMessage = validateTextFields()
        
        if errorMessage != nil{
            
            showErrorMessage(errorMessage!)
        }else{
            
            passwordReset(email: resetEmailText, onSuccess: {
             self.view.endEditing(true)
                self.navigationController?.popViewController(animated: true)
            }) { (errorMessage) in
                
               self.showErrorMessage(errorMessage)
            }
        }
        
       
      
        
    }
    
    func showErrorMessage(_ errorMessage:String){
        
        
        errorLabel.text = errorMessage
        errorLabel.alpha = 1
    }
    
    func validateTextFields() -> String? {
        
        
        if resetEmailTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" {
            
            
            return "Please fill the email address"
        }
        
        let resetEmailValidate = resetEmailTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
       
        
       
        
        if validation.isValidEmail(resetEmailValidate) == false {
            
            return "Invalid email Address please enter Valid email address"
        }
        
        
        return nil
    }
    
    
    
    func passwordReset(email: String, onSuccess: @escaping()->Void, onError: @escaping(_
        errorMessage: String)-> Void){

        let resetEmailText = resetEmailTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)

        Auth.auth().sendPasswordReset(withEmail: resetEmailText) { (error) in

            if error == nil{

                onSuccess()
            }else{

                onError(error!.localizedDescription)
            }
        }

    }
  
    

}
