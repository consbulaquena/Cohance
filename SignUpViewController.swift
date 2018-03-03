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
        
        //diasble button when view is launched
        signUpButton.isEnabled = false
        //validating step, method of sign up VC
        
        handleTextField()
    }
    func handleTextField() {
        usernameTextField.addTarget(self, action: #selector(SignUpViewController.textFieldDidChange), for: UIControlEvents.editingChanged)
        emailTextField.addTarget(self, action: #selector(SignUpViewController.textFieldDidChange), for: UIControlEvents.editingChanged)
        passwordTextfield.addTarget(self, action: #selector(SignUpViewController.textFieldDidChange), for: UIControlEvents.editingChanged)
    }
    
    
    
    
    //Turns light color when textfield is complete
    @objc func textFieldDidChange() {
        guard let username = usernameTextField.text, !username.isEmpty, let email = emailTextField.text, !email.isEmpty,
            let password = passwordTextfield.text, !password.isEmpty else {
            signUpButton.setTitleColor(UIColor.lightText, for: UIControlState.normal)
            signUpButton.isEnabled = false
            return
                
        }
        
        
        signUpButton.setTitleColor(UIColor.white, for: UIControlState.normal)
        signUpButton.isEnabled = true
    }
    
    @objc func handleSelectProfileImageView() {
       let pickerController = UIImagePickerController()
        pickerController.delegate = self
        present(pickerController, animated: true, completion: nil)
    }
    
    @IBAction func SignUpButton_TouchUpInside(_ sender: Any) {

            if let profileImg = self.selectedImage, let imageData = UIImageJPEGRepresentation(profileImg, 0.1) {

                ProgressHUD.show("Please wait...", interaction: false)
                AuthService.signUp(username: usernameTextField.text!, email: emailTextField.text!, password: passwordTextfield.text!, imageData: imageData, onSuccess: {
                    ProgressHUD.showSuccess("Success!")
                    //switch view
                    self.performSegue(withIdentifier: "SignUpToTabBarVC", sender: nil)
                }, onError: { (errorString) in
                ProgressHUD.showError(errorString!)
                })
            } else {
                ProgressHUD.showError("Please upload your photo.")
        }
    }
}
    //clean code



extension SignUpViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    @objc func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
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
