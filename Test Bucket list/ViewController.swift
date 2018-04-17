//  ViewController.swift
//  Test Bucket list
//
//  Created by Malavikha Moneesh on 24/2/18.
//  Copyright © 2018 Malavikha Moneesh. All rights reserved.
//

import UIKit
import Firebase

var bucketList = [String]()
var bucketTitle = [String]()
let defaults = UserDefaults.standard
var myIndex = 0

class ViewController: UIViewController, UINavigationBarDelegate, UITableViewDelegate, UITableViewDataSource, UIViewControllerPreviewingDelegate {
    
    func previewingContext(_ previewingContext: UIViewControllerPreviewing, viewControllerForLocation location: CGPoint) -> UIViewController? {
        guard let previewView = storyboard?.instantiateViewController(withIdentifier: "DispViewController") as? DispViewController else {
            return nil
        }
        previewView.preferredContentSize = CGSize(width: 0, height: 200)
        
        guard let indexPath = tableViewTbl.indexPathForRow(at: location) else { return nil }
        guard let cell = tableViewTbl.cellForRow(at: indexPath) else { return nil }
        
        //previewingContext.sourceRect = tableViewTbl.rectForRow(at: indexPath)
        previewingContext.sourceRect = cell.frame
        
        return previewView
    }
    
    func previewingContext(_ previewingContext: UIViewControllerPreviewing, commit viewControllerToCommit: UIViewController) {
        show(viewControllerToCommit, sender: self)
    }
    
    @IBOutlet weak var navbar1: UINavigationBar!
    @IBOutlet weak var tableViewTbl: UITableView!
    var storageRef : StorageReference!
    
    var bucketList = [String]()
    var bucketTitle = [String]()
    let defaults = UserDefaults.standard
    
    func addToBucketList(newBucket: String) {
        if let listItems = defaults.array(forKey: "bucketListArray") as? [String] {
            bucketList = listItems
        }
        bucketList.append(newBucket)
        defaults.set(bucketList, forKey: "bucketListArray")
    }
    
    func addToBucketTitle(newTitle: String) {
        if let titleItems = defaults.array(forKey: "bucketTitleArray") as? [String] {
            bucketTitle = titleItems
        }
        bucketTitle.append(newTitle)
        defaults.set(bucketTitle, forKey: "bucketTitleArray")
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return bucketList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "tableCellId") as! CustomTableViewCell
        cell.cellTitleLbl.text = bucketTitle[indexPath.row]
        fetchFireBaseImage(imageURLLoc: bucketList[indexPath.row], imageView: cell.cellImage)
        cell.accessoryType = UITableViewCellAccessoryType.disclosureIndicator
        return cell
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
  
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        
        let deleteAction = UITableViewRowAction(style: .default, title: "Delete") { (action, indexPath) in
            self.bucketList.remove(at: indexPath.row)
            self.bucketTitle.remove(at: indexPath.row)
            self.defaults.set(self.bucketList, forKey: "bucketListArray")
            self.defaults.set(self.bucketTitle, forKey: "bucketTitleArray")
            tableView.beginUpdates()
            tableView.deleteRows(at: [indexPath], with: .fade)
            tableView.endUpdates()
        }

        deleteAction.backgroundColor = .red
        return [deleteAction]
    }
    
    func tableView(_ tableView: UITableView, didEndEditingRowAt indexPath: IndexPath?) {
        tableView.reloadData()
    }
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        print("viewDidLoad called!")
        storageRef = Storage.storage().reference()
        self.navigationItem.rightBarButtonItem = self.editButtonItem
        
        registerForPreviewing(with: self, sourceView: tableViewTbl)
        
        if let listItems = defaults.array(forKey: "bucketListArray") as? [String] {
            bucketList = listItems
        }
        if let titleItems = defaults.array(forKey: "bucketTitleArray") as? [String] {
            bucketTitle = titleItems
        }
        
        self.navbar1.delegate = self
        if bucketList.count == 0 {
            tableViewTbl.isHidden = true
            editButtonItem.isEnabled = false
        } else {
            tableViewTbl.isHidden = false
            editButtonItem.isEnabled = true
        }
    }

    func position(for bar: UIBarPositioning) -> UIBarPosition {
        return .topAttached
    }
    
    func fetchFireBaseImage(imageURLLoc: String, imageView: UIImageView) {
        let paths = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)
        let documentsDirectory = paths[0]
        let filePath = "file:\(documentsDirectory)/myimage_"
            + "\(Int(Date.timeIntervalSinceReferenceDate * 1000)).jpg"
        let fileURL = URL(string: filePath)
        let storagePath = imageURLLoc
        
        // [START downloadimage]
        storageRef.child(storagePath).write(toFile: fileURL!, completion: { (url, error) in
            if let error = error {
                print("Error downloading:\(error)")
                return
            } else if let imagePath = url?.path {
                print("Downloaded image successfully")
                imageView.image = UIImage(contentsOfFile: imagePath)
                return
            }
            self.tableViewTbl.reloadData()
        })
        
    }
    
    @IBAction func back(segue: UIStoryboardSegue) {
    }
    
    @IBAction func addOptionButton(_ sender: UIBarButtonItem) {
        performSegue(withIdentifier: "addOption", sender: self)
    }
}
