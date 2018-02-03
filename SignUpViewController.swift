//
//  SignUpViewController.swift
//  Cohance
//
//  Created by Cons Bulaqueña on 28/01/2018.
//  Copyright © 2018 consios. All rights reserved.
//

import UIKit
import FirebaseAuth

class SignUpViewController: UIViewController {
    @IBOutlet var profileImage: UIImageView!
    
    
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
                print(error?.localizedDescription)
            return
                
            }
            print(user)
        })
    }
}
