//
//  ProfileViewController.swift
//  Personal Finance
//
//  Created by Alfredo Villagomez on 2/19/19.
//  Copyright © 2019 Alfredo Villagomez. All rights reserved.
//

import UIKit
import Firebase

class ProfileViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func logout(_ sender: UIButton) {
        do {
            try Auth.auth().signOut()
            let signInStoryBoard = UIStoryboard(name: "SignIn", bundle: Bundle.main)
            let signInPage = signInStoryBoard.instantiateViewController(withIdentifier: "SignIn")
            let appDelegate = UIApplication.shared.delegate
            appDelegate?.window??.rootViewController = signInPage
            
        } catch let signOutError as NSError {
            print("Error signing out: \(signOutError)")
        }
    }
}
