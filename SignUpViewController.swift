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

class SignUpViewController: UIViewController {
    @IBOutlet var profileImage: UIImageView!
    
    @IBOutlet var usernameTextField: UITextField!
    
    @IBOutlet var passwordTextfield: UITextField!
    @IBOutlet var emailTextField: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
    profileImage.layer.cornerRadius = 50
    profileImage.clipsToBounds = true
        
        // Do any additional setup after loading the view.
    }
    
    @IBAction func SignUpButton_TouchUpInside(_ sender: Any) {
    //create user when Firebase button is hit
        
        FIRAuth.auth()?.createUser(withEmail: emailTextField.text!, password: passwordTextfield.text!, completion: { (user: FIRUser?, error: Error?) in
            if error != nil{
    //localized desc. can tell us what's wrong
                print(error!.localizedDescription)
            return
            }
            let ref = FIRDatabase.database().reference()
            let usersReference = ref.child("users")
        //print(usersReference.description())
            let uid = user?.uid
            let newUserReference = usersReference.child(uid!)
            newUserReference.setValue(["username": self.usernameTextField.text!, "email": self.emailTextField.text! ])
            print("description: (newUserReference.description()")
            
            
        })
    }
}
