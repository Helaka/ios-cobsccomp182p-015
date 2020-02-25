//
//  LoginViewController.swift
//  Helaka-Cobscomp182p-015
//
//  Created by Minu Jayakody on 2/10/20.
//  Copyright © 2020 Minu Jayakody. All rights reserved.
//

import UIKit
import FirebaseAuth
import LocalAuthentication

class LoginViewController: UIViewController {
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var fogotButton: UIButton!
    @IBOutlet weak var errorLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        errorLabel.alpha = 0
//        handleFaceIdTouchId()
        authenticationWithTouchID()
        // Do any additional setup after loading the view.
    }
    

    @IBAction func loginButtonClick(_ sender: Any) {

            signin()
        

    }
    
    
    func signin(){
        
        let emailText = emailTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        let passwordText = passwordTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        
        Auth.auth().signIn(withEmail: emailText, password: passwordText) { (result, error) in
            
            if error != nil{
                self.errorLabel.text = error!.localizedDescription
                self.errorLabel.alpha = 1
            }else{
                self.redirectToHomeController()
//                self.handleFaceIdTouchId()
            }
            
        }
    }
    
    func redirectToHomeController(){
        
        let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "tabBarControllerIdentifier")
        self.present(vc, animated: true, completion: nil)
        
        
//        let tabBarController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "tabBarControllerIdentifier")
//        if let navigator = self.navigationController {
//            navigator.pushViewController(tabBarController, animated: true)
//        }
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    func authenticationWithTouchID() {
        let localAuthenticationContext = LAContext()
        localAuthenticationContext.localizedFallbackTitle = "Please use your Passcode"
        
        var authorizationError: NSError?
        let reason = "Authentication required to access the secure data"
        
        if localAuthenticationContext.canEvaluatePolicy(.deviceOwnerAuthentication, error: &authorizationError) {
            
            localAuthenticationContext.evaluatePolicy(.deviceOwnerAuthentication, localizedReason: reason) { success, evaluateError in
                
                if success {
                    DispatchQueue.main.async() {
                        let alert = UIAlertController(title: "Success", message: "Authenticated succesfully!", preferredStyle: UIAlertController.Style.alert)
                        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                        self.present(alert, animated: true, completion: nil)
                        
                        self.signin()
                    }
                    
                } else {
                    // Failed to authenticate
                    guard let error = evaluateError else {
                        return
                    }
                    print(error)
                    
                }
            }
        } else {
            
            guard let error = authorizationError else {
                return
            }
            print(error)
        }
    }
    
    
    @IBAction func signUpButtonClick(_ sender: Any) {
        redirectToSignUpController()
        
    }
    
    
    func redirectToSignUpController(){
        let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "signUpView")
        self.present(vc, animated: true, completion: nil)
    }
}
