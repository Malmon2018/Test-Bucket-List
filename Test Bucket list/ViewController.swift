//
//  ViewController.swift
//  Test Bucket list
//
//  Created by Malavikha Moneesh on 24/2/18.
//  Copyright © 2018 Malavikha Moneesh. All rights reserved.
//

import UIKit
import Firebase



class ViewController: UIViewController, UINavigationBarDelegate, UITableViewDelegate, UITableViewDataSource, UIViewControllerPreviewingDelegate {
    func previewingContext(_ previewingContext: UIViewControllerPreviewing, viewControllerForLocation location: CGPoint) -> UIViewController? {
        let previewView = storyboard?.instantiateViewController(withIdentifier: "editIdentifier")
        return previewView
    }
    
    func previewingContext(_ previewingContext: UIViewControllerPreviewing, commit viewControllerToCommit: UIViewController) {
        let finalPreview = storyboard?.instantiateViewController(withIdentifier: "editIdentifier")
        show(finalPreview!, sender: self)
    }
    
    
    @IBOutlet weak var navbar1: UINavigationBar!
    @IBOutlet weak var tableViewTbl: UITableView!
    var storageRef : StorageReference!
    
    //Array for iteration
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
        return cell
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        tableView.cellForRow(at: indexPath)?.accessoryType = UITableViewCellAccessoryType.disclosureIndicator
    }
    
     func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            self.bucketList.remove(at: indexPath.row)
            tableView.beginUpdates()
            tableView.deleteRows(at: [indexPath], with: .fade)
            tableView.endUpdates()
        } else {
            
        }
    }
    
    func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableViewTbl.isUserInteractionEnabled = true
        let longPressGesture = UILongPressGestureRecognizer(target: self, action: #selector(self.longPress))
        tableViewTbl.addGestureRecognizer(longPressGesture)
        storageRef = Storage.storage().reference()
        self.navigationItem.rightBarButtonItem = self.editButtonItem
        if traitCollection.forceTouchCapability == UIForceTouchCapability.available {
            registerForPreviewing(with: self, sourceView: view)
            
        } else {
            print("Error!!!!!")
        }
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
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
    
    @objc func longPress() {
        
        if tableViewTbl.isExclusiveTouch == true {
            
        }
        
    }
}


