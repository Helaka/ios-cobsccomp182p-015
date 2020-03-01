//
//  Event.swift
//  Helaka-Cobscomp182p-015
//
//  Created by Minu Jayakody on 2/26/20.
//  Copyright © 2020 Minu Jayakody. All rights reserved.
//

import Foundation
import  UIKit

class Event {
    
    
    var image: UIImage
    var eventname: String
    var eventdescription: String
    var eventdate: String
    var eventlocation: String
    var ownername : String
    var ownerid: String
    var ownerprofile : UIImage
    
    init(image: UIImage , eventname:String , eventdescription:String , eventdate:String , eventlocation:String, ownername:String , ownerid: String,ownerprofile:UIImage) {
        
        self.image = image
        self.eventname = eventname
        self.eventdescription = eventdescription
        self.eventdate = eventdate
        self.eventdescription = eventdescription
        self.eventlocation = eventlocation
        self.ownername = ownername
        self.ownerid = ownerid
        self.ownerprofile = ownerprofile
    }
    
}
