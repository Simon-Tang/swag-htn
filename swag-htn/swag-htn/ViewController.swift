//
//  ViewController.swift
//  swag-htn
//
//  Created by Jasvin Baweja on 2017-09-16.
//
//

import UIKit
import Firebase
import FirebaseAuth
import GoogleSignIn

class ViewController: UIViewController {
    
    @IBOutlet weak var collaborateButton: UIButton!
    @IBOutlet weak var continueButton: UIButton!
    @IBOutlet weak var museumButton: UIButton!
    @IBOutlet weak var galleryButton: UIButton!
    @IBOutlet weak var artistsButton: UIButton!
    
    // Database root reference for any operation on database
    let rootRef = Database.database().reference()
    
    /*
    func createUser(email: String, password: String){
        Auth.auth().createUser(withEmail: email, password: password) { (user, error) in
        // Handle registering
        }
    }
    
    func signIn(email: String, password: String){
        Auth.auth().signIn(withEmail: email, password: password) { (user, error) in
        // Handle sign in
        }
    }
    
    func signOutUser(){
        do {
            try Auth.auth().signOut()
        } catch let signOutError as NSError {
            print ("Error signing out: %@", signOutError)
        }
    }
 */
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        collaborateButton.layer.cornerRadius = 10
        continueButton.layer.cornerRadius = 10
        museumButton.layer.cornerRadius = 10
        galleryButton.layer.cornerRadius = 10
        artistsButton.layer.cornerRadius = 10
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
 
    
}

