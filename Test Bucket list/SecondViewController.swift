//
//  SecondViewController.swift
//  Test Bucket list
//
//  Created by Malavikha Moneesh on 24/2/18.
//  Copyright © 2018 Malavikha Moneesh. All rights reserved.
//

import UIKit
import Firebase
import FirebaseStorage

class SecondViewController: UIViewController, UINavigationBarDelegate, UITextFieldDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    

    @IBOutlet weak var whatsGoingOnTextField: UITextField!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var datePickerText: UITextField!
    
    @IBOutlet weak var addImage: UIButton!
    @IBOutlet weak var navbar2: UINavigationBar!
    let datePicker = UIDatePicker()
    var storageRef : StorageReference!
   
   
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if traitCollection.forceTouchCapability == UIForceTouchCapability.available {
            registerForPreviewing(with: self as! UIViewControllerPreviewingDelegate, sourceView: view)
        } else {
            print("Error!!!!!")
        }
        storageRef = Storage.storage().reference()
        whatsGoingOnTextField.delegate = self
        
        self.navbar2.delegate = self

        createDatePicker()
        // Do any additional setup after loading the view.
    }
    func createDatePicker() {
        //format for picker
        
        datePicker.datePickerMode = .date
        
        //toolbar
        
        let toolBar = UIToolbar()
        toolBar.sizeToFit()
        
        //bar button item
        
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: nil, action: #selector(doneIsPressed))
        toolBar.setItems([doneButton], animated: false)
        datePickerText.inputAccessoryView = toolBar
        datePickerText.inputView = datePicker
        
    }
    @objc func doneIsPressed() {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .short
        dateFormatter.timeStyle = .none
        
        datePickerText.text = dateFormatter.string(from: datePicker.date)
        self.view.endEditing(true)
    }
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == whatsGoingOnTextField {
            textField.resignFirstResponder()
        }
        return true
    }
    
    func position(for bar: UIBarPositioning) -> UIBarPosition {
        return .topAttached
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
 
    @IBAction func chooseToAddImage(_ sender: Any) {
        let imagePickerController = UIImagePickerController()
        imagePickerController.delegate = self
        
        let actionSheet = UIAlertController(title: "Add Image", message: "", preferredStyle: .actionSheet)
        
        actionSheet.addAction(UIAlertAction(title: "Take Photo", style: .default, handler: { (action:UIAlertAction) in
            imagePickerController.sourceType = .camera
            self.present(imagePickerController, animated: true, completion: nil)
        }))
        actionSheet.addAction(UIAlertAction(title: "Choose From Gallery", style: .default, handler: { (action:UIAlertAction) in
            imagePickerController.sourceType = .photoLibrary
            self.present(imagePickerController, animated: true, completion: nil)
        }))
        actionSheet.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil	))
        
        self.present(actionSheet, animated: true, completion: nil)
        
    }
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        let image = info[UIImagePickerControllerOriginalImage] as! UIImage
        imageView.image = image
        picker.dismiss(animated: true, completion: nil)
        self.addImage.isHidden = true
        
        //Upload to Firebase Storage - BEGIN
        guard let imageData = UIImageJPEGRepresentation(image, 0.8) else { return }
        let imagePath = "malavikha_" +
        "/\(Int(Date.timeIntervalSinceReferenceDate * 1000)).jpg"
        let metaData = StorageMetadata()
        metaData.contentType = "image/jpeg"
        self.storageRef.child(imagePath).putData(imageData, metadata: metaData) { (metadata, error) in
            if let error = error {
                print("Error uploading: \(error)")
                return
            }
            self.uploadSuccess(metadata!, storagePath: imagePath)
        }
        
    }
    
    func uploadSuccess(_ metadata: StorageMetadata, storagePath: String) {
        print("Upload Succeeded!")
        UserDefaults.standard.set(storagePath, forKey: "storagePath")
        UserDefaults.standard.synchronize()
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }

    
    @IBAction func saveButton(_ sender: Any) {
        performSegue(withIdentifier: "saveBucketSegue", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "saveBucketSegue" {
            let destinationVC = segue.destination as! ViewController
            destinationVC.addToBucketList(newBucket: (UserDefaults.standard.object(forKey: "storagePath") as? String)!)
            destinationVC.addToBucketTitle(newTitle: whatsGoingOnTextField.text!)
            print("from second view controller: ")
        }
    }
    
}
