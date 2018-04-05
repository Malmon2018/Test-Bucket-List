//
//  CustomTableViewController.swift
//  Test Bucket list
//
//  Created by Malavikha Moneesh on 1/4/18.
//  Copyright © 2018 Malavikha Moneesh. All rights reserved.
//

import UIKit

class CustomTableViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    let bucketList = ["0" , "1" , "2"]
    
    @IBOutlet weak var tableCell: UIView!
 
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return bucketList.count
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let eachCell = tableView.dequeueReusableCell(withIdentifier: "tableViewId") as! customTableViewCell
        eachCell.cellTitleLbl.text = bucketList[indexPath.row]
        eachCell.cellImage.image = UIImage(named: "Christmas Tree")
        return eachCell
    }

}
