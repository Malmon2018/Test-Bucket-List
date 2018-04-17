//
//  DispViewController.swift
//  Test Bucket list
//
//  Created by Malavikha Moneesh on 11/4/18.
//  Copyright © 2018 Malavikha Moneesh. All rights reserved.
//

import UIKit

class DispViewController: UIViewController, UINavigationBarDelegate, UINavigationControllerDelegate {
    
    @IBOutlet weak var dispBgImage: UIImageView!
    @IBOutlet weak var dispLabel: UILabel!
    @IBOutlet weak var navbar3: UINavigationBar!
    
    var text: String?
    var img: UIImage?
    
    func position(for bar: UIBarPositioning) -> UIBarPosition {
        return .topAttached
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navbar3.delegate = self
        self.navbar3.setBackgroundImage(UIImage(), for: .default)
        self.navbar3.shadowImage = UIImage()
        self.navbar3.isTranslucent = true
        
        let size = CGSize(width: 414, height: 417)
//        dispLabel.text = "Soolavikha"
        if let text = text {
            dispLabel.text = text
        }
        dispBgImage.image = img?.crop(to: size)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}
