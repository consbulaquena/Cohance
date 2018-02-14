//
//  HomeViewController.swift
//  Cohance
//
//  Created by Cons Bulaqueña on 31/01/2018.
//  Copyright © 2018 consios. All rights reserved.
//

import UIKit
import FirebaseAuth

class HomeViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    @IBAction func logout_TouchUpInside(_ sender: Any) {

    do {
        try FIRAuth.auth()?.signOut()
    } catch let logoutError {
        print(logoutError)
    }

    //comeback to SigninVC after logout
        let storyboard = UIStoryboard(name: "Start", bundle: nil)
        
        //The identiier is the storyBoard Id of the SignInVC - SignInViewController
        let signInVC = storyboard.instantiateViewController(withIdentifier: "SignInViewController")
       
        
        //Always display SignIn view after loging out
        self.present(signInVC, animated: true, completion: nil)
}
}
