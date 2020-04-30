//
//  UIImageView+CircularImage.swift
//  MediaFinder
//
//  Created by Khaled L Said on 4/30/20.
//  Copyright © 2020 Intake4. All rights reserved.
//

import Foundation
import UIKit

extension UIImageView {
    func circularImage() {
        self.layer.cornerRadius = self.frame.size.height/2
        self.clipsToBounds = true
    }
}
