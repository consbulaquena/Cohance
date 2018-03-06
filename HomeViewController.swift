//
//  HomeViewController.swift
//  Cohance
//
//  Created by Cons Bulaqueña on 31/01/2018.
//  Copyright © 2018 consios. All rights reserved.
//

import UIKit
import FirebaseAuth
import FirebaseDatabase

class HomeViewController: UIViewController {

    @IBOutlet var tableView: UITableView!
   
    var posts = [Post]()
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        loadPosts()
    
        
//        var post = Post(captionText: "test", photoUrlString: "urlstring")
//        print(post.caption)
//        print(post.photoUrl)
        
        
    }
    
    //child added can see Grab existing data in database
        func loadPosts() {
            FIRDatabase.database().reference().child("posts").observe(.childAdded) { (snapshot: FIRDataSnapshot) in
                print(Thread.isMainThread)
            if let dict = snapshot.value as? [String: Any] {
                let captionText = dict["caption"] as! String
                let photoUrlString = dict["photoUrl"] as! String
                let post = Post(captionText: captionText, photoUrlString: photoUrlString)
                self.posts.append(post)
                print(self.posts) //print array
                self.tableView.reloadData()
            }
        }
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

extension HomeViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return posts.count
    }
    //specificies how cells look
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PostCell", for: indexPath)
        cell.textLabel?.text = posts[indexPath.row].caption
        return cell
    }
    
}
