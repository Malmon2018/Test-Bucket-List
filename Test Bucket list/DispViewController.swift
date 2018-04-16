//
//  DispViewController.swift
//  Test Bucket list
//
//  Created by Malavikha Moneesh on 11/4/18.
//  Copyright © 2018 Malavikha Moneesh. All rights reserved.
//

import UIKit

class DispViewController: UIViewController {
    
    @IBOutlet weak var dispImage: UIImageView!
    @IBOutlet weak var dispLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        dispLabel.text = "Soolavikha"
        dispImage.image = UIImage(named: "Christmas Tree.png")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
