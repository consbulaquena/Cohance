//
//  SignInViewController.swift
//  Cohance
//
//  Created by Cons Bulaqueña on 26/01/2018.
//  Copyright © 2018 consios. All rights reserved.
//

import UIKit
import FirebaseAuth

class SignInViewController: UIViewController {
    
    @IBOutlet var emailTextField: UITextField!
    
    @IBOutlet var passwordTextfield: UITextField!
    @IBOutlet var signInButton: UIButton!
    
    
    @IBAction func signInButton_TouchUpInside(_ sender: Any) {
        FIRAuth.auth()?.signIn(withEmail: emailTextField.text!, password: passwordTextfield.text!, completion: { (user, error) in
            if error != nil {
            print(error!.localizedDescription)
            return
            }
            
        })
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
   
    handleTextField()
    }
    //handletextfield method
    func handleTextField() {
        emailTextField.addTarget(self, action: #selector(SignInViewController.textFieldDidChange), for: UIControlEvents.editingChanged)
    passwordTextfield.addTarget(self, action: #selector(SignInViewController.textFieldDidChange), for: UIControlEvents.editingChanged)
    }
    
    
    @objc func textFieldDidChange() {
        guard let email = emailTextField.text, !email.isEmpty,
            let password = passwordTextfield.text, !password.isEmpty else {
                signInButton.setTitleColor(UIColor.lightText, for: UIControlState.normal)
                signInButton.isEnabled = false
                return
                
        }
        
        signInButton.setTitleColor(UIColor.white, for: UIControlState.normal)
        signInButton.isEnabled = true
        }
        
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
  
//keyboard hides when touches begun
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
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
