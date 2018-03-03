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
    var selectedImage: UIImage?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        //tap UI photo
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(self.handleSelectPhoto))
        
        //used var photo above in IBoutlet
        photo.addGestureRecognizer(tapGesture)
        photo.isUserInteractionEnabled = true
    }
    
    @objc func handleSelectPhoto() {
        let pickerController = UIImagePickerController()
        pickerController.delegate = self
        present(pickerController, animated: true, completion: nil)
    }
    
    @IBAction func signUpBtn_TouchUpInside(_ sender: Any) {
    
    }
}
extension CameraViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    @objc func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        print("did Finish picking media")
        if let image = info[UIImagePickerControllerOriginalImage] as? UIImage {
            selectedImage = image
            photo.image = image
        }
        print(info)
        //    profileImage.image = infoPhoto
        dismiss(animated: true, completion: nil)
    }
}

