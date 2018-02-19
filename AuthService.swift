//
//  AuthService.swift
//  Cohance
//
//  Created by Cons Bulaqueña on 15/02/2018.
//  Copyright © 2018 consios. All rights reserved.
//

import Foundation
import FirebaseAuth
import FirebaseStorage
import FirebaseDatabase

class AuthService {
    
    //we can call it directly without needing instance
    
    static func signIn(email: String, password: String, onSuccess: @escaping () -> Void, onError: @escaping (_ errorMessage: String?) -> Void) {
        
        
        FIRAuth.auth()?.signIn(withEmail: email, password: password, completion: { (user, error) in
        if error != nil {
        onError(error!.localizedDescription)
            return
        }
        //let sign in method know about auth process - using callbacks
        onSuccess() //@escaping is used to allow onSuccess called after returned
        
    })
}

static func signUp(username: String, email: String, password: String, imageData: Data, onSuccess: @escaping () -> Void, onError: @escaping (_ errorMessage: String?) -> Void) {
    
FIRAuth.auth()?.createUser(withEmail: email, password: password, completion: { (user: FIRUser?, error: Error?) in
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
    

        
        storageRef.put(imageData, metadata: nil, completion: { (metadata, error) in
            if error != nil {
                return
            }
            
            let profileImageUrl = metadata?.downloadURL()?.absoluteString
            
            self.setUserInformation(profileImageUrl: profileImageUrl!, username: username, email: email, uid: uid!)
           })
        })
    //store photo in firebase

    }

static func setUserInformation(profileImageUrl: String, username: String, email: String, uid: String) {
    
    
    let ref = FIRDatabase.database().reference()
    let usersReference = ref.child("users")
    //print(usersReference.description())
    let newUserReference = usersReference.child(uid)
    newUserReference.setValue(["username": username, "email": email, "profileImageUrl": profileImageUrl])
    

    }
}
