//
//  AuthService.swift
//  Cohance
//
//  Created by Cons Bulaqueña on 15/02/2018.
//  Copyright © 2018 consios. All rights reserved.
//

import Foundation
import FirebaseAuth
class AuthService {
    
    //we can call it directly without needing instance
    
    static func signIn(email: String, password: String) {
        
        
    FIRAuth.auth()?.signIn(withEmail: email, password: password, completion: { (user, error) in
    if error != nil {
    print(error!.localizedDescription)
    return
    }
        //let sign in method know about auth process - using callbacks
        
    })
}

}
