//
//  AuthService.swift
//  Cohance
//
//  Created by Cons Bulaqueña on 15/02/2018.
//  Copyright © 2018 consios. All rights reserved.
//

import Foundation
class AuthService {
    FIRAuth.auth()?.signIn(withEmail: emailTextField.text!, password: passwordTextfield.text!, completion: { (user, error) in
    if error != nil {
    print(error!.localizedDescription)
    return
    }
    //ask VC to perform a segue to switch tab bar contorller -perform seg.
    self.performSegue(withIdentifier: "SignInToTabBarVC", sender: nil)
    })
}
