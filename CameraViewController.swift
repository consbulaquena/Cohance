//
//  CameraViewController.swift
//  Cohance
//
//  Created by Cons Bulaqueña on 31/01/2018.
//  Copyright © 2018 consios. All rights reserved.
//

import UIKit
import FirebaseStorage
import FirebaseDatabase

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
    
    @IBAction func sharebutton_TouchUpInside(_ sender: Any) {
        ProgressHUD.show("Please wait...", interaction: false)
         if let profileImg = self.selectedImage, let imageData = UIImageJPEGRepresentation(profileImg, 0.1) {
            let photoIdString = NSUUID().uuidString
            let storageRef = FIRStorage.storage().reference(forURL: Config.STORAGE_ROOF_REF).child("posts").child(photoIdString)
            storageRef.put(imageData, metadata: nil, completion: { (metadata, error) in
                if error != nil {
                    return
                }
                
                let photoUrl = metadata?.downloadURL()?.absoluteString
                self.sendDatatoDatabase(photoUrl: photoUrl!)
                
            })
            
    } else {
    ProgressHUD.showError("Please upload your photo.")
        }
    }
    
    func sendDatatoDatabase(photoUrl: String) {
        let ref = FIRDatabase.database().reference()
        let postsReference = ref.child("posts")
        let newPostId = postsReference.childByAutoId().key
        //print(usersReference.description())
        let newPostsReference = postsReference.child(newPostId)
        newPostsReference.setValue(["photoUrl": photoUrl], withCompletionBlock: {
            (error, ref) in
            if error != nil {
                ProgressHUD.showError(error!.localizedDescription)
                return
            }
            ProgressHUD.showSuccess("Success")
            })

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
