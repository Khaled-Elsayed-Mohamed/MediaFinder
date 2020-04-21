//
//  MovieCell.swift
//  UserDefault
//
//  Created by Khaled L Said on 3/28/20.
//  Copyright © 2020 Intake4. All rights reserved.
//
import UIKit

class CustomCell: UITableViewCell {
    
    @IBOutlet weak var cellImageView: UIImageView!
    @IBOutlet weak var cellLabelField: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    func configureCellData(data: MoviesData) {
        cellLabelField.text = data.title
        cellImageView.image = UIImage(named: data.image ?? "")
    }
}
