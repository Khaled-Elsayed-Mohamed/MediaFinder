//
//  Instances.swift
//  UserDefault
//
//  Created by Khaled L Said on 2/15/20.
//  Copyright © 2020 Intake4. All rights reserved.
//

import Foundation
import UIKit


let signInVC = UIStoryboard(name: Storyboards.main, bundle: nil).instantiateViewController(withIdentifier: VCs.signInVC) as! SignInVC
let signInNav = UINavigationController(rootViewController: signInVC)
let signUpVC = UIStoryboard(name: Storyboards.main, bundle: nil).instantiateViewController(withIdentifier: VCs.signUpVC) as! SignUpVC
let signUpNav = UINavigationController(rootViewController: signUpVC)
let profile = UIStoryboard(name: Storyboards.main, bundle: nil).instantiateViewController(withIdentifier: VCs.profileVC) as! ProfileVC
let profileNav = UINavigationController(rootViewController: profile)
let MapKitVC = UIStoryboard(name: Storyboards.main, bundle: nil).instantiateViewController(withIdentifier: VCs.mapVC) as! MapKit
let MapKitNav = UINavigationController(rootViewController: MapKitVC)
let tableViewVC = UIStoryboard(name: Storyboards.main, bundle: nil).instantiateViewController(withIdentifier: VCs.moviesListVC) as! MovieListVC
let TableViewNav = UINavigationController(rootViewController: tableViewVC)
