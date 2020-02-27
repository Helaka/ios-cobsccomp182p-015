//
//  EventCell.swift
//  Helaka-Cobscomp182p-015
//
//  Created by Minu Jayakody on 2/26/20.
//  Copyright © 2020 Minu Jayakody. All rights reserved.
//

import UIKit

class EventCell: UITableViewCell {

    @IBOutlet weak var EventImageView: UIImageView!
    @IBOutlet weak var eventName: UILabel!
    // Configure the view for the selected state
    @IBOutlet weak var eventDescription: UILabel!
    
    @IBOutlet weak var eventDate: UILabel!
    
//    func setEvent(event: Event){
//        
//        EventImageView.image = event.image
//        eventName.text = event.eventname
//    }
    

}
