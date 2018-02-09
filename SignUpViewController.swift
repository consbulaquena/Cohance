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
        
        
        // Do any additional setup after loading the view.
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
            
            if let profileImg = self.selectedImage, let imageData = UIImageJPEGRepresentation(profileImage, 0.1) {
        
                storageRef.put(imageData, metadata: nil, completion: { (metadata, error) in
                    <#code#>
                })
            }
        //store photo in firebase
            
            let ref = FIRDatabase.database().reference()
            let usersReference = ref.child("users")
        //print(usersReference.description())
         
            let newUserReference = usersReference.child(uid!)
            newUserReference.setValue(["username": self.usernameTextField.text!, "email": self.emailTextField.text!])
            print("description: \(newUserReference.description())")
            
            
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
