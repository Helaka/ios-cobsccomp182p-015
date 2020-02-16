//
//  Alerts.swift
//  Helaka-Cobscomp182p-015
//
//  Created by Minu Jayakody on 2/13/20.
//  Copyright © 2020 Minu Jayakody. All rights reserved.
//

import Foundation
import UIKit


class Alert{
    
    class func showBasics(title: String, msg: String , vc: UIViewController){
        
        let alert = UIAlertController(title: title, message: msg, preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
        vc.present(alert ,animated: true)
    }
}
