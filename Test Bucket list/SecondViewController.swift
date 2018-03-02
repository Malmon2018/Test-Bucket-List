//
//  SecondViewController.swift
//  Test Bucket list
//
//  Created by Malavikha Moneesh on 24/2/18.
//  Copyright © 2018 Malavikha Moneesh. All rights reserved.
//

import UIKit

class SecondViewController: UIViewController, UINavigationBarDelegate, UITextFieldDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet weak var whatsGoingOnTextField: UITextField!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var datePickerText: UITextField!
    
    @IBOutlet weak var addImage: UIButton!
    @IBOutlet weak var navbar2: UINavigationBar!
    let datePicker = UIDatePicker()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        whatsGoingOnTextField.delegate = self
        
        self.navbar2.delegate = self
        addImage.layer.borderWidth = 1
        addImage.layer.borderColor = UIColor.gray.cgColor

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
        actionSheet.addAction(UIAlertAction(title: "Choose from gallery", style: .default, handler: { (action:UIAlertAction) in
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
        
    }
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
    @IBAction func done(segue: UIStoryboardSegue) {
        
    }
    
}
