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
    
    init(image: UIImage , eventname:String , eventdescription:String , eventdate:String) {
        
        self.image = image
        self.eventname = eventname
        self.eventdescription = eventdescription
        self.eventdate = eventdate
    }
    
}
