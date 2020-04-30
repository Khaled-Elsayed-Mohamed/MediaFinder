//
//  TabBarVC.swift
//  MediaFinder
//
//  Created by Khaled L Said on 4/14/20.
//  Copyright © 2020 Intake4. All rights reserved.
//

import UIKit

class TabBarVC: UITabBarController, UITabBarControllerDelegate {
    
    
    
    func setupTabBar() {
        
        let profileVC = UIStoryboard(name: Storyboards.main, bundle: nil).instantiateViewController(withIdentifier: VCs.profileVC) as! ProfileVC
        let tableVC = UIStoryboard.init(name: Storyboards.main, bundle: nil).instantiateViewController(withIdentifier: VCs.moviesListVC) as! MoviesListVC
        let tableVcNav = UINavigationController(rootViewController: tableVC)
        let profileNav = UINavigationController(rootViewController: profileVC)
        
        let vc1 = tableVcNav
        let vc2 = profileNav
        
        let icon1 = UITabBarItem(title: "Media", image: UIImage(named: "someImage.png"), selectedImage: UIImage(named: "otherImage.png"))
        let icon2 = UITabBarItem(title: "Profile", image: UIImage(named: "someImage.png"), selectedImage: UIImage(named: "otherImage.png"))
        vc1.tabBarItem = icon1
        vc2.tabBarItem = icon2
        let controllers = [vc1, vc2]  //array of the root view controllers displayed by the tab bar interface
        self.viewControllers = controllers
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        delegate = self
        
        setupTabBar()
  

        
    }
    


}
