//
//  customTableViewCell.swift
//  Test Bucket list
//
//  Created by Malavikha Moneesh on 1/4/18.
//  Copyright © 2018 Malavikha Moneesh. All rights reserved.
//

import UIKit

class customTableViewCell: UITableViewCell {
    
    @IBOutlet weak var tableCellView: UIView!
    @IBOutlet weak var cellTitleLbl: UILabel!
    @IBOutlet weak var cellImage: UIImageView!
    

    
    override func awakeFromNib() {
        super.awakeFromNib()
       tableCellView.reloadInputViews()
        
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
