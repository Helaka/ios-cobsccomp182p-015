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
    
    @IBOutlet weak var ownerprofil: UIImageView!
    @IBOutlet weak var EventdetailsView: UIView!
    @IBOutlet weak var ownerName: UILabel!
    @IBOutlet weak var eventLocation: UILabel!
    
    @IBOutlet weak var ownerId: UILabel!
    @IBOutlet weak var eventDate: UILabel!
    
    @IBOutlet weak var ownerDescription: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        EventImageView.layer.cornerRadius = 9
        EventdetailsView.layer.cornerRadius = 12
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    

}
