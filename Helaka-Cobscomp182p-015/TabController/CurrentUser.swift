//
//  CurrentUser.swift
//  Helaka-Cobscomp182p-015
//
//  Created by Minu Jayakody on 2/19/20.
//  Copyright © 2020 Minu Jayakody. All rights reserved.
//

import Foundation


struct CurrentUser {
    
    let uid : String
    let name : String
    let email : String
    let profileimageurl : String
    
    init(uid : String, dictionary: [String: Any]) {
        
        self.uid = uid
        self.name = dictionary["firstname"] as? String ?? "no name"
        self.email = dictionary["email"] as? String ?? ""
        self.profileimageurl = dictionary["profileimageurl"] as? String ?? ""
    }
}
