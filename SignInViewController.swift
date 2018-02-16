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
        //called the shared signin instance
        AuthService.signIn(email: emailTextField.text!, password: passwordTextfield.text!)
        
        //ask VC to perform a segue to switch tab bar contorller -perform seg.
        self.performSegue(withIdentifier: "SignInToTabBarVC", sender: nil)
    
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
   
        //diasble button when view is launched
        signInButton.isEnabled = false
        
    handleTextField()
        //do not reauntiticate user

        func viewDidAppear(_ animated: Bool) {
            super .viewDidAppear(animated)
            
        if FIRAuth.auth()?.currentUser != nil{
                   self.performSegue(withIdentifier: "SignInToTabBarVC", sender: nil)
            }
         
        }
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
