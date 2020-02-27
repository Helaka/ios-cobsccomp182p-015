//
//  AddEventViewController.swift
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
import GooglePlacesSearchController
import CoreLocation
import MapKit
import GoogleMaps
import GooglePlaces
import LocalAuthentication



class AddEventViewController: UIViewController ,UIImagePickerControllerDelegate,UINavigationControllerDelegate {
    
    var image: UIImage? = nil
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var eventDateTextField: UITextField!
    @IBOutlet weak var eventNameTextField: UITextField!
    @IBOutlet weak var eventLocationTextField: UITextField!
    @IBOutlet weak var eventDescriptionTextField: UITextField!
    @IBOutlet weak var eventOwnerTextField: UITextField!
    
//    @IBOutlet weak var imageButton: UIButton!
//    @IBOutlet weak var imageButton: UIButton!
    
    @IBOutlet weak var eventImageView: UIImageView!
    
    
    private var datePicker : UIDatePicker?
    
    var imagePicker: UIImagePickerController!
    
//    let googlePlaceAPIKey = "AIzaSyA_LkeWsqFXkJQDoWDa5wUV-ZXMR_CXqmQ"
    @IBOutlet weak var errorLabel: UILabel!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        checkLoggedInUserStatus()
        
        errorLabel.alpha = 0
       
        getEventOwnerName()
        view.backgroundColor = UIColor.white
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.title =  "Add Events"
        
        
        setDate()
        
//
  
    }
    
   
    @IBAction func addEventImageButtonClick(_ sender: Any) {
        
        addEventImage()
    }
    
    
    
    func addEventImage(){
        
        let imagePickerController = UIImagePickerController()
        imagePickerController.delegate = self
        
        let actionSheet = UIAlertController(title: "photo Source", message: "Choose a image", preferredStyle: .actionSheet)
        
        actionSheet.addAction(UIAlertAction(title: "Camera", style: .default, handler: { (action:UIAlertAction) in
            
            if UIImagePickerController.isSourceTypeAvailable(.camera){
                self.present(imagePickerController, animated: true , completion: nil)
            }else{
                
//                return "Camere is Not Available"
                
                print("Camera Not Availabale")
            }
            
            imagePickerController.sourceType = .camera
            self.present(imagePickerController, animated: true, completion: nil)
            
        }))
        
        actionSheet.addAction(UIAlertAction(title: "Photo Library", style: .default, handler: { (action:UIAlertAction) in
            imagePickerController.sourceType = .photoLibrary
            self.present(imagePickerController, animated: true, completion: nil)
        }))
        actionSheet.addAction(UIAlertAction(title: "Cansel", style: .cancel, handler: nil))
        
        self.present(actionSheet, animated: true , completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
//        let imageSelected = info[UIImagePickerController.InfoKey.originalImage] as! UIImage
//
//
//        image = imageSelected
//        eventImageView.image = imageSelected
//        picker.dismiss(animated: true, completion: nil)
        
        
        
        if let imageSelected = info[UIImagePickerController.InfoKey.editedImage] as? UIImage{
            
            image = imageSelected
            eventImageView.image = imageSelected
        }

        if let imageOriginal = info[UIImagePickerController.InfoKey.originalImage] as? UIImage{
            
            image = imageOriginal
            eventImageView.image = imageOriginal
        }
//
        picker.dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
    func validateTextFields() -> String? {
        
        
        if eventNameTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" || eventOwnerTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||
            eventDescriptionTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||
            eventDateTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == ""{
            
            return "Please fill all the text fields"
        }
        
        return nil
       
    }
    
    
    @IBAction func addEventButtonClick(_ sender: Any) {
        
        let errorMessage = validateTextFields()
        if errorMessage != nil{
            
            showErrorMessage(errorMessage!)
        }else{
            
            
            AddEvent()
            
            errorLabel.alpha = 0
        }
    }
    
    func showErrorMessage(_ errorMessage:String){
        
        
        errorLabel.text = errorMessage
        errorLabel.alpha = 1
    }
    
    
    
    func AddEvent(){
        
        guard let imageSelected = self.image else{
            
            print("profile image nil")
            return
        }
        
        guard let imageData = imageSelected.jpegData(compressionQuality: 0.4)else{
            
            return
        }
        
        let eventName = eventNameTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        
        let eventDate = eventDateTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        
        let eventDescription = eventDescriptionTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        
        let eventOwnerName = eventOwnerTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        
        let eventLocation =  eventLocationTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        
        let metadata = StorageMetadata()
        
        let database  = Firestore.firestore()
        metadata.contentType = "image/jpg"
        let storageRef = Storage.storage().reference(forURL: "gs://event-app-93d34.appspot.com")
        
        guard let uid = Auth.auth().currentUser?.uid else{ return }
        
//        let docRef = database.collection("users").document()
        
        let storageProfileRef = storageRef.child("Events")
        
        
        
        
        storageProfileRef.putData(imageData, metadata: metadata) { (StorageMetaData, error) in
            
            if error != nil
            {
                print(error?.localizedDescription)
                return
            }

            storageProfileRef.downloadURL(completion: { (url, error) in
                
                if let metaImageUrl = url?.absoluteString{
                    database.collection("Events").document().setData(["eventname":eventName , "eventdate": eventDate , "eventDescription": eventDescription, "ownername": eventOwnerName , "eventlocation": eventLocation,"EventImageurl":metaImageUrl ]) { (error) in
                        
                        
                        if error != nil {
                            
                            self.showErrorMessage("Error when creating Event")
                        }else{
                            
                            self.redirectToHomeController()
                        }
                        
                        
                        
                    }
                    
                    print(metaImageUrl)
                }
                
            })
           
        }
        
        
//        database.collection("Events").document().setData(["eventname":eventName , "eventdate": eventDate , "eventDescription": eventDescription, "ownername": eventOwnerName , "eventlocation": eventLocation, "EventImageurl":metaImageUrl ]) { (error) in
//
//
//            if error != nil {
//
//                self.showErrorMessage("Error when creating Event")
//            }else{
//
//                self.redirectToHomeController()
//            }
//
//
//
//        }
        
    }
    
    
    
    
    fileprivate func checkLoggedInUserStatus(){
        
        
        if Auth.auth().currentUser == nil{
            
            DispatchQueue.main.async {
                
               
                let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "indexView")
                self.present(vc, animated: true, completion: nil)
               
                
//                self.handleFaceIdTouchId()
                return
            }
        }else{
        }
        
    }
    
    func getEventOwnerName(){
        
        guard let uid = Auth.auth().currentUser?.uid else{ return }
        
        let db = Firestore.firestore()
        
        let docRef = db.collection("users").document(uid)
        
        
        docRef.getDocument { (document, error) in
            if let document = document, document.exists {
                let dataDescription = document.data().map(String.init(describing:)) ?? "nil"
                print("Document data: \(dataDescription)")
                
                
                
                self.eventOwnerTextField.text = (document.get("firstname") as! String)
                
                self.eventOwnerTextField.isUserInteractionEnabled = false
                
            } else {
                print("Document does not exist")
            }
    }

    }
    
    
    func redirectToHomeController(){
        
        let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "tabBarControllerIdentifier")
        self.present(vc, animated: true, completion: nil)
    }
    
    
    func setDate(){
        
        datePicker = UIDatePicker()
        datePicker?.datePickerMode = .date
        
        datePicker?.addTarget(self, action: #selector(AddEventViewController.dateChanged(datePicker:)), for: .valueChanged)
        
        let tapGenture = UITapGestureRecognizer(target: self , action: #selector(AddEventViewController.viewTapped(gestureRecognizer:)))
        
        
        view.addGestureRecognizer(tapGenture)
        
        eventDateTextField.inputView = datePicker
        
        
    }
    
    @objc func viewTapped(gestureRecognizer: UITapGestureRecognizer){
        
        
        view.endEditing(true)
        
    }
    
    @objc func dateChanged(datePicker: UIDatePicker)
    {
        let dateFormatter = DateFormatter()
        
        dateFormatter.dateFormat = "MM/dd/yyy"
        
        eventDateTextField.text = dateFormatter.string(from:  datePicker.date)
        view.endEditing(true)
    }
    
    

    
    
   

}


//
//extension AddEventViewController: UITableViewDelegate, UITableViewDataSource{
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) ->
//        Int {
//
//        return arrayAddress.count
//    }
//
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        var cell = tableView.dequeueReusableCell(withIdentifier: "cell")
//
//        if cell == nil {
//
//            cell = UITableViewCell(style: .default, reuseIdentifier: "cell")
//        }
//
//        cell?.textLabel?.attributedText = arrayAddress[indexPath.row].attributedFullText
//        cell?.textLabel?.font = UIFont.systemFont(ofSize: 14)
//
//        return cell!
//    }
//
//
//}

//extension AddEventViewController: UITextFieldDelegate{
//
//    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
//
//
//        let searchStr = (textField.text! as NSString).replacingCharacters(in: range, with: string)
//
//        if searchStr == "" {
//
//            self.arrayAddress = [GMSAutocompletePrediction]()
//
//        }else{
//
//            GMSPlacesClient.shared().autocompleteQuery(searchStr, bounds: nil, filter: filter, callback: {(result, error) in
//
//                if error == nil && result != nil {
//
//
//                    self.arrayAddress =  result!
//
//                }
//
//            })
//        }
//        self.tableView.reloadData()
//        return true
//
//    }
//
//
//}
//extension AddEventViewController: GooglePlacesAutocompleteViewControllerDelegate {
//    func viewController(didAutocompleteWith place: PlaceDetails) {
//        print(place.description)
//
//    }
//}

