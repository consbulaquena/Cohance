//
//  SignUpViewController.swift
//  Cohance
//
//  Created by Cons Bulaqueña on 28/01/2018.
//  Copyright © 2018 consios. All rights reserved.
//

import UIKit

class SignUpViewController: UIViewController {
    @IBOutlet var profileImage: UIImageView!
    

    
    override func viewDidLoad() {
        super.viewDidLoad()

        
    profileImage.layer.cornerRadius = 50
    profileImage.clipsToBounds = true
        
        // Do any additional setup after loading the view.
    }
    
}
