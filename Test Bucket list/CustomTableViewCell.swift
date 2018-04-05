//
//  CustomTableViewCell.swift
//  Test Bucket list
//
//  Created by Moneesh Prathap on 5/4/18.
//  Copyright © 2018 Malavikha Moneesh. All rights reserved.
//

import UIKit

class CustomTableViewCell: UITableViewCell {

    @IBOutlet weak var cellTitleLbl: UILabel!
    @IBOutlet weak var cellImage: UIImageView!
    @IBOutlet weak var tableCellView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }

}
