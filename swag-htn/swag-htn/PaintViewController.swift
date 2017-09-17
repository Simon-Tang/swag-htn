//
//  PaintViewController.swift
//  swag-htn
//
//  Created by Amy on 2017-09-16.
//
//

import UIKit
import Foundation
import Firebase
import FirebaseAuth
import GoogleSignIn



class PaintViewController: UIViewController {
    
    @IBOutlet weak var penButton: UIButton!
    

    override func viewDidLoad() {
        super.viewDidLoad()
  
        penButton.setBackgroundImage(UIImage(named: "fountain-pen-close-up (2).png"), for: UIControlState.normal)

    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
    }
}

