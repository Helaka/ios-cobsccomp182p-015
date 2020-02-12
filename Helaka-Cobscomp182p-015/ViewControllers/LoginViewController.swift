//
//  LoginViewController.swift
//  Helaka-Cobscomp182p-015
//
//  Created by Minu Jayakody on 2/10/20.
//  Copyright © 2020 Minu Jayakody. All rights reserved.
//

import UIKit
import FirebaseAuth

class LoginViewController: UIViewController {
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var fogotButton: UIButton!
    @IBOutlet weak var errorLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        errorLabel.alpha = 0
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
            }
            
        }
    }
    
    func redirectToHomeController(){
        
        let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "HomeViewController")
        self.present(vc, animated: true, completion: nil)
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
