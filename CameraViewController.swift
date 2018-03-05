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
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        handlePost()
    }
    
    func handlePost() {
     //value only if not nil, or photo is uploaded, otherwise sharebtn always false.
        if selectedImage != nil{
            self.shareBtn.isEnabled = true
            self.shareBtn.backgroundColor = UIColor( red: CGFloat(92/255.0), green: CGFloat(203/255.0), blue: CGFloat(207/255.0), alpha: CGFloat(1.0) )
        } else {
            self.shareBtn.isEnabled = false
               self.shareBtn.backgroundColor = .lightGray
        }
        }
        
    
    //hide keyboard
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
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
 
    @IBAction func remove_TouchUpInside(_ sender: Any) {
        clean()
    }
    
    
    func sendDatatoDatabase(photoUrl: String) {
        let ref = FIRDatabase.database().reference()
        let postsReference = ref.child("posts")
        let newPostId = postsReference.childByAutoId().key
        //send pic and caption to database upon share button
        let newPostsReference = postsReference.child(newPostId)
        newPostsReference.setValue(["photoUrl": photoUrl, "caption": captionTextView.text!], withCompletionBlock: {
            (error, ref) in
            if error != nil {
                ProgressHUD.showError(error!.localizedDescription)
                return
            }
            ProgressHUD.showSuccess("Success")
            self.clean()
            
            //switch back to homeview after sharing post selectedindex of tab bar 0 = home
            self.tabBarController?.selectedIndex = 0
            })
}

func clean() {
    //clear caption view and photo
    self.captionTextView.text = ""
    self.photo.image = UIImage(named: "addimage_160")
    //deactivate share button after posts being shared, photo nil equates to button nil
    self.selectedImage = nil
    
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
