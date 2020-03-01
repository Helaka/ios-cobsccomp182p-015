//
//  EditEventViewController.swift
//  Helaka-Cobscomp182p-015
//
//  Created by Minu Jayakody on 2/28/20.
//  Copyright © 2020 Minu Jayakody. All rights reserved.
//

import UIKit
import Firebase

class EditEventViewController: UIViewController {

    
    @IBOutlet weak var eventNameEdit: UITextField!
    @IBOutlet weak var eventDateEdit: UITextField!
    @IBOutlet weak var eventDescriptionEdit: UITextField!
    @IBOutlet weak var eventLocationEdit: UITextField!
    
    @IBOutlet weak var eventTitle: UILabel!
    @IBOutlet weak var editeventOverviewscrolview: UIScrollView!
    
    @IBOutlet weak var Editpageimageview: UIImageView!
    var finaleventname = ""
    var finaleventdescription = ""
    var finaleventlocation = ""
    var finaleventdate = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
      setEditData()
        
        Editpageimageview.layer.cornerRadius = 30
        editeventOverviewscrolview.layer.cornerRadius = 30
        
    
    }

    @IBAction func EventEditButtonClick(_ sender: Any) {
        
        updateEvent()
    }
    
    
    
    func updateEvent(){
        
        let EventNameEdit = eventNameEdit.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        let EventDesctiptionEdit = eventDescriptionEdit.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        let EventDateEdit = eventDateEdit.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        let EventLocationEdit = eventLocationEdit.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        let database = Firestore.firestore().collection("Events").document(eventTitle.text!)
        
        
        database.updateData(["eventname": EventNameEdit,"eventDescription":EventDesctiptionEdit,
                            "eventdate":EventDateEdit , "eventlocation": EventLocationEdit]) { (err) in
                                
        if let err = err{print(err.localizedDescription)}
        
        
        let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "tabBarControllerIdentifier")
        self.present(vc, animated: true, completion: nil)
        
                }
        
    }
    
    
    func setEditData(){
        
        eventTitle.text = finaleventname
        eventNameEdit.text = finaleventname
        eventDescriptionEdit.text = finaleventdescription
        eventLocationEdit.text = finaleventlocation
        eventDateEdit.text = finaleventdate
        
    }
}
