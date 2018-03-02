//
//  ThirdViewController.swift
//  Test Bucket list
//
//  Created by Malavikha Moneesh on 24/2/18.
//  Copyright © 2018 Malavikha Moneesh. All rights reserved.
//

import UIKit

class ThirdViewController: UIViewController, UINavigationBarDelegate {

    @IBOutlet weak var navbar3: UINavigationBar!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navbar3.delegate = self
        // Do any additional setup after loading the view.
    }
    
    func position(for bar: UIBarPositioning) -> UIBarPosition {
        return .topAttached
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
}
