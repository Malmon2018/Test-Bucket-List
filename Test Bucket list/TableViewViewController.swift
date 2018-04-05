//
//  TableViewViewController.swift
//  Test Bucket list
//
//  Created by Malavikha Moneesh on 27/3/18.
//  Copyright © 2018 Malavikha Moneesh. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth
import FirebaseDatabase


class TableViewViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    var list = [""]
    var storageRef : StorageReference!
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return(list.count)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Pcell", for: indexPath)
        let pictureName = list[indexPath.row]
        let imageRef = (UIApplication.shared.delegate as! AppDelegate).firebaseStorage?.reference().child("malavikha_")
        storageRef.getData(maxSize: 10 * 1024 * 1024) { (data, error) -> Void in
           
            }
        return cell
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        storageRef = Storage.storage().reference()
        loadPosts()
    }
    
    /*func loadPosts() {
        Database.database().reference().child("malavikha_").observe(.childAdded) { (snapshot: DataSnapshot) in
            print(snapshot.value as Any)
        }
    }*/
 
    func loadPosts() {
        let paths = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)
        let documentDirectory = paths[0]
        let filePath = "file:\(documentDirectory)/myimage.jpg"
        guard let fileURL = URL(string: filePath) else { return }
        guard let storagePath = UserDefaults.standard.object(forKey: "storagePath") as? String else { return }
        
        // Start Downloading
        storageRef.child(storagePath).write(toFile: fileURL, completion: { (url, error) in
            if let error = error {
                print("Error downloading:\(error)")
                return
            } else if let imagePath = url?.path {
                print("Download successful!")
                print("imagePath:\(imagePath)")
                //imageView.image = UIImage(contentsOfFile: imagePath)
            }
        })
        // End Downloading
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
