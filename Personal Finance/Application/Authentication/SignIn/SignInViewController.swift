//
//  SignInViewController.swift
//  Personal Finance
//
//  Created by Alfredo Villagomez on 1/30/19.
//  Copyright © 2019 Alfredo Villagomez. All rights reserved.
//

import UIKit

class SignInViewController: UIViewController {
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func signIn(_ sender: UIButton) {
        SignInViewModel.signInWith(email: emailTextField.text, password: passwordTextField.text) {[weak self] (success, error) in
            if let error = error {
                let alertController = UIAlertController(title: "Error", message: error.localizedDescription, preferredStyle: .alert)
                let acceptAction = UIAlertAction(title: "ok", style: .default, handler: nil)
                alertController.addAction(acceptAction)
                self?.present(alertController, animated: true, completion: nil)
                return
            }
            
            if success {
                self?.performSegue(withIdentifier: "goToMain", sender: self)
            }
        }
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}