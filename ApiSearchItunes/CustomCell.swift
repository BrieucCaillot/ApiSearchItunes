//
//  CustomCell.swift
//  ApiSearchItunes
//
//  Created by Brieuc Caillot on 28/03/2019.
//  Copyright © 2019 Brieuc Caillot. All rights reserved.
//
import UIKit

class CustomCell: UITableViewCell {
    
    @IBOutlet weak var albumImg: UIImageView!
    @IBOutlet weak var albumArtist: UILabel!
    @IBOutlet weak var albumTrack: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}
