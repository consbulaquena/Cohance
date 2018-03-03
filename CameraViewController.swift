//
//  CameraViewController.swift
//  Cohance
//
//  Created by Cons Bulaqueña on 31/01/2018.
//  Copyright © 2018 consios. All rights reserved.
//

import UIKit

class CameraViewController: UIViewController {
    @IBOutlet var photo: UIImageView!
    @IBOutlet var captionTextView: UITextView!
    @IBOutlet var shareBtn: UIButton!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        //tap UI photo
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(SignUpViewController.handleSelectProfileImageView))
        
        //used var photo above in IBoutlet
        photo.addGestureRecognizer(tapGesture)
        photo.isUserInteractionEnabled = true
    }
    @IBAction func signUpBtn_TouchUpInside(_ sender: Any) {
    
    
    
    
    }
}
