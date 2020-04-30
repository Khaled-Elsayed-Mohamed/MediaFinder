//
//  MovieCell.swift
//  UserDefault
//
//  Created by Khaled L Said on 3/28/20.
//  Copyright © 2020 Intake4. All rights reserved.
//
import UIKit
import SDWebImage
import MarqueeLabel

class CustomCell: UITableViewCell {
    
    @IBOutlet weak var artworkUrl100ImageView: UIImageView!

    
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        contentView.frame = contentView.frame.inset(by: UIEdgeInsets(top: 5, left: 3, bottom: 5, right: 3))
    }
    
    @IBOutlet weak var longDescription: UILabel!
    @IBOutlet weak var artistName: UILabel!
    
    func configureCellData(data: resultsData) {
        
    artistName.text = data.artistName
    longDescription.text = data.longDescription
    artworkUrl100ImageView.sd_setImage(with: URL(string: data.artworkUrl100), completed: nil)
    }
    
    @IBAction func shakeImage(_ sender: UIButton) {
        artworkUrl100ImageView.shake()
    }
}

