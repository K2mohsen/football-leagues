//
//  competitionsTableViewCell.swift
//  football-leagues
//
//  Created by Innovitics on 03/10/2023.
//

import UIKit

class competitionsTableViewCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        self.layer.cornerRadius = 10
        self.clipsToBounds = true
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
