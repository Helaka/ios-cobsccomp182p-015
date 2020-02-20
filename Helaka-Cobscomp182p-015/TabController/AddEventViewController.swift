//
//  AddEventViewController.swift
//  Helaka-Cobscomp182p-015
//
//  Created by Minu Jayakody on 2/15/20.
//  Copyright © 2020 Minu Jayakody. All rights reserved.
//

import UIKit
import FirebaseAuth

class AddEventViewController: UIViewController {

    @IBOutlet weak var eventDateTextField: UITextField!
    @IBOutlet weak var eventNameTextField: UITextField!
    @IBOutlet weak var eventLocationTextField: UITextField!
    @IBOutlet weak var eventDescriptionTextField: UITextField!
    
    @IBOutlet weak var eventOwnerTextField: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        
        
         checkLoggedInUserStatus()
        view.backgroundColor = UIColor.white
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.title =  "Add Events"
       
  
    }
   
    
    @IBAction func addLocationButtonClick(_ sender: Any) {
    }
    
   
    
    fileprivate func checkLoggedInUserStatus(){
        
        
        if Auth.auth().currentUser == nil{
            
            DispatchQueue.main.async {
                
               
                let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "LoginView")
                self.present(vc, animated: true, completion: nil)
                
                return
            }
        }
        
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
