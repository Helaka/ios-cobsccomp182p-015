//
//  MainTabViewController.swift
//  Helaka-Cobscomp182p-015
//
//  Created by Minu Jayakody on 2/15/20.
//  Copyright © 2020 Minu Jayakody. All rights reserved.
//

import UIKit
import FirebaseAuth


class MainTabViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        tabBar.barTintColor =  UIColor(red: 0/255, green: 204/255, blue: 255/255 , alpha: 1)
        setupTabBar()
        // Do any additional setup after loading the view.
       
    }
    

    func setupTabBar(){
        
        
        let eventController = UINavigationController(rootViewController: EventsViewController())
        eventController.tabBarItem.image = UIImage(named: "eventBalck")?.withRenderingMode(.alwaysOriginal)
        eventController.tabBarItem.selectedImage = UIImage(named: "eventwhite")
        
        let addEventController = UINavigationController(rootViewController: AddEventViewController())
        addEventController.tabBarItem.image = UIImage(named: "addwhite")
        addEventController.tabBarItem.selectedImage = UIImage(named: "addblack")
        
        let profileController = UINavigationController(rootViewController: ProfileViewController())
        profileController.tabBarItem.image = UIImage(named: "profilewhite")
        profileController.tabBarItem.selectedImage = UIImage(named: "profiteblack")
        
       
        
       
        
        
        
        viewControllers = [eventController , addEventController , profileController]
        
        
       
        
        guard let items = tabBar.items else{ return }
        
        for item in items{
            item.imageInsets = UIEdgeInsets(top: 4, left: 0, bottom: -4, right: 0)
        }
        
    }
    
    
 
    
    

}

extension UITabBarController{

    func createNavController(vc: UIViewController, selected: UIImage, unselected:
        UIImage ) -> UINavigationController {

        let viewController = vc
        let navController = UINavigationController(rootViewController: viewController)
        navController.tabBarItem.image = unselected
        navController.tabBarItem.selectedImage =  selected

        return navController
    }
}
