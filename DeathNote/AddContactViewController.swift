//
//  AddContactViewController.swift
//  DeathNote
//
//  Created by Soto Yanis on 01/07/2016.
//  Copyright © 2016 Soto Yanis. All rights reserved.
//

import UIKit
import RealmSwift

class AddContactViewController: UIViewController, UITextViewDelegate, UITextFieldDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    //IBOutlet
    @IBOutlet var imageProfil: UIImageView!
    @IBOutlet var lastNameTextField: UITextField!
    @IBOutlet var firstNameTextField: UITextField!
    @IBOutlet var datePicker: UIDatePicker!
    @IBOutlet var descriptionTextField: UITextView!
    
    //System version
    let systemVersion = UIDevice.currentDevice().systemVersion
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Notification to get object keyboard
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(AddContactViewController.keyboardWillShow(_:)), name:UIKeyboardWillShowNotification, object: nil);
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(AddContactViewController.keyboardWillHide(_:)), name:UIKeyboardWillHideNotification, object: nil);
        descriptionTextField.textColor = UIColor.lightGrayColor()
        
        /*To know the location of the DB uncomment the line
       print(Realm.Configuration.defaultConfiguration.fileURL!) */
        
        
        if (systemVersion.characters.first == "8") {
            /* print(systemVersion) */
            datePicker.hidden = true
        }
        
        
    }
    
    //MARK: - UITextVieDelegate Protocol -
    func textViewDidBeginEditing(textView: UITextView) {
        if textView.textColor == UIColor.lightGrayColor() {
            textView.text = nil
            textView.textColor = UIColor.blackColor()
        }
    }
    
    func textViewDidEndEditing(textView: UITextView) {
        if textView.text.isEmpty {
            textView.text = "Enter your description here"
            textView.textColor = UIColor.lightGrayColor()
        }
    }
    
    func textView(textView: UITextView, shouldChangeTextInRange range: NSRange, replacementText text: String) -> Bool {
        if text == "\n" {
            textView.resignFirstResponder()
            return false
        }
        return true
    }
   
    //MARK: - UITextFieldDelegate Protocol -
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return false
    }
    
    //MARK: - Keyboard Protocol -
    func keyboardWillShow(sender: NSNotification) {
        if (systemVersion.characters.first == "8") {
            self.view.frame.origin.y = -140
        } else {
            self.view.frame.origin.y = -200
        }
    }
    
    func keyboardWillHide(sender: NSNotification) {
        self.view.frame.origin.y = 0
    }
    
    //MARK: - Add contact action on Done button -
    @IBAction func doneAction(sender: UIBarButtonItem) {
        trimString()
        if ( (lastNameTextField.text == "") || (firstNameTextField.text == "") || (descriptionTextField.text == "" || descriptionTextField.text == "Enter your description here")) {
            let alertError = showAlertWithTitle("Error", message: "Empty field")
            self.presentViewController(alertError, animated: true, completion: nil)
        } else {
            let contact = Contact()
            if self.imageProfil.image != nil {
                let imageData: NSData = UIImagePNGRepresentation(self.imageProfil.image!)!
                contact.imageProfil = imageData
            }
            contact.descriptions = descriptionTextField.text
            contact.firstName = firstNameTextField.text!
            contact.lastName = lastNameTextField.text!
            contact.timeDeath = datePicker.date
            // Write in the DB
            do { try uiRealm.write() {
                uiRealm.add(contact)
                }
            } catch { print("Can't add the contact") }
            performSegueWithIdentifier("saveSegue", sender: self)
        }
    }
    
    
    //MARK: - Trim string /whiteSpace removed -
    func trimString() {
        lastNameTextField.text = lastNameTextField.text!.stringByTrimmingCharactersInSet(
            NSCharacterSet.whitespaceAndNewlineCharacterSet()
        )
        firstNameTextField.text = firstNameTextField.text!.stringByTrimmingCharactersInSet(
            NSCharacterSet.whitespaceAndNewlineCharacterSet()
        )
        descriptionTextField.text = descriptionTextField.text!.stringByTrimmingCharactersInSet(
            NSCharacterSet.whitespaceAndNewlineCharacterSet()
        )
    }
    
    //MARK: - PickerController protocol to get image from the library of the iPhone
    func imagePickerController(picker: UIImagePickerController, didFinishPickingImage image: UIImage!, editingInfo: [NSObject : AnyObject]!) {
        
        if let data = UIImagePNGRepresentation(image) {
            let filename = getDocumentsDirectory().stringByAppendingPathComponent("copy.png")
            data.writeToFile(filename, atomically: true)
        }
        
        self.imageProfil.image = image.circleMask
        self.dismissViewControllerAnimated(true, completion: nil);
    }
    
    @IBAction func addImage(sender: AnyObject) {
        if UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.PhotoLibrary) {
            let imagePicker = UIImagePickerController()
            imagePicker.delegate = self
            imagePicker.sourceType = UIImagePickerControllerSourceType.PhotoLibrary;
            imagePicker.allowsEditing = true
            self.presentViewController(imagePicker, animated: true, completion: nil)
        }
    }
}
