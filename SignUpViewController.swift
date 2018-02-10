//
//  SignUpViewController.swift
//  Cohance
//
//  Created by Cons Bulaqueña on 28/01/2018.
//  Copyright © 2018 consios. All rights reserved.
//

import UIKit
import FirebaseAuth
import FirebaseDatabase
import FirebaseStorage

class SignUpViewController: UIViewController {
    @IBOutlet var profileImage: UIImageView!
    
    @IBOutlet var usernameTextField: UITextField!
    
    @IBOutlet var passwordTextfield: UITextField!
    @IBOutlet var emailTextField: UITextField!
    @IBOutlet var signUpButton: UIButton!
    
    //instance variable to store selective
    
    var selectedImage: UIImage?
    
    
    
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
    profileImage.layer.cornerRadius = 50
    profileImage.clipsToBounds = true
    
    // tap UI photo
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(SignUpViewController.handleSelectProfileImageView))
       
        profileImage.addGestureRecognizer(tapGesture)
        profileImage.isUserInteractionEnabled = true
        
        //validating step, method of sign up VC
        
        
        handleTextField()
    }
    func handleTextField() {
            usernameTextField.addTarget(self, action: #selector(SignUpViewController.textFieldDidChange), for: UIControlEvents.editingChanged)
            emailTextField.addTarget(self, action: #selector(SignUpViewController.textFieldDidChange), for: UIControlEvents.editingChanged)
            passwordTextfield.addTarget(self, action: #selector(SignUpViewController.textFieldDidChange), for: UIControlEvents.editingChanged)
        }
        
    @objc func textFieldDidChange() {
        guard let username = usernameTextField.text, !username.isEmpty, let email = emailTextField.text, !email.isEmpty,
            let password = passwordTextfield.text, !password.isEmpty else {
             signUpButton.setTitleColor(UIColor.lightText, for: UIControlState.normal)
            return
        }
        
        
        signUpButton.setTitleColor(UIColor.white, for: UIControlState.normal)
    }
    
    @objc func handleSelectProfileImageView() {
       let pickerController = UIImagePickerController()
        pickerController.delegate = self
        present(pickerController, animated: true, completion: nil)
    }
    
    @IBAction func SignUpButton_TouchUpInside(_ sender: Any) {
    //create user when Firebase button is hit
        
        FIRAuth.auth()?.createUser(withEmail: emailTextField.text!, password: passwordTextfield.text!, completion: { (user: FIRUser?, error: Error?) in
            if error != nil{
    //localized desc. can tell us what's wrong
                print(error!.localizedDescription)
                return
            }
            
            
            
            
            //Store image to firebase to use firebase realtime feature
            //reference points to where the storage of image lives
            //store profile photos in this node
            let uid = user?.uid
            
            let storageRef = FIRStorage.storage().reference(forURL: "gs://cohance-ca490.appspot.com").child("profile_image").child((user?.uid)!)
            
            if let profileImg = self.selectedImage, let imageData = UIImageJPEGRepresentation(profileImg, 0.1) {
        
                storageRef.put(imageData, metadata: nil, completion: { (metadata, error) in
                    if error != nil {
                      return
                    }
                    let profileImageUrl = metadata?.downloadURL()?.absoluteString

                    let ref = FIRDatabase.database().reference()
                    let usersReference = ref.child("users")
                    //print(usersReference.description())
                    
                    let newUserReference = usersReference.child(uid!)
                    newUserReference.setValue(["username": self.usernameTextField.text!, "email": self.emailTextField.text!, "profileImageUrl": profileImageUrl ])
                })
            }
        //store photo in firebase
            

            
            
        })
    }
}

extension SignUpViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
    print("did Finish picking media")
        if let image = info[UIImagePickerControllerOriginalImage] as? UIImage {
        selectedImage = image
        profileImage.image = image
    }
        print(info)
    //    profileImage.image = infoPhoto
    dismiss(animated: true, completion: nil)
    }
}
