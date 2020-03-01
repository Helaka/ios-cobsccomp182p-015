//
//  EventOwnerProfileViewController.swift
//  Helaka-Cobscomp182p-015
//
//  Created by Minu Jayakody on 3/1/20.
//  Copyright © 2020 Minu Jayakody. All rights reserved.
//

import UIKit

import Firebase
import FirebaseStorage

class EventOwnerProfileViewController: UIViewController {

    @IBOutlet weak var ownerImageView: UIImageView!
    @IBOutlet weak var ownerNameLabel: UILabel!
    @IBOutlet weak var ownerEmailLabel: UILabel!
    @IBOutlet weak var ownerContactNumber: UILabel!
    @IBOutlet weak var ownerId: UILabel!
    
    
    
   var userid = ""
    
    var evntarr: Eventss!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
       
        
       getownerData()

        // Do any additional setup after loading the view.
    }
    
    
    func getownerData(){
        
        
    ownerId.text = userid
        
       
      
        let db = Firestore.firestore()
        
        let docRef = db.collection("users").document(ownerId.text!)
        
        print(docRef)
        
        docRef.getDocument { (document, error) in
            if let document = document, document.exists {
                let dataDescription = document.data().map(String.init(describing:)) ?? "nil"
                print("Document data: \(dataDescription)")
                
                
    
                self.ownerNameLabel.text = (document.get("firstname") as! String)
//                self.contactNumberLabel.text = (document.get("phoneNumber" ) as! String)
                self.ownerEmailLabel.text = (document.get("email") as! String)
                let profile = (document.get("profileimageurl") as! String)
                self.ownerImageView.kf.setImage(with: URL(string: profile), placeholder: nil, options: [.transition(.fade(0.7))], progressBlock: nil)
                
            } else {
                print("Document does not exist")
            }
        }
        
    }
    
        
    @IBAction func homebuttonClick(_ sender: Any) {
        
        
        
        let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "tabBarControllerIdentifier")
        self.present(vc, animated: true, completion: nil)
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
    
    
    
    



