//
//  SignInViewController.swift
//  Personal Finance
//
//  Created by Alfredo Villagomez on 1/30/19.
//  Copyright © 2019 Alfredo Villagomez. All rights reserved.
//

import UIKit
import GoogleSignIn

class SignInViewController: UIViewController, GIDSignInUIDelegate {
    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    private var viewModel = SignInViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        GIDSignIn.sharedInstance()?.uiDelegate = self
    }
        
    @IBAction func signInWithSMS(_ sender: UIButton) {
        viewModel.authWithAccountKit(sender: self) {[weak self] (success, error) in
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
    
    @IBAction func signInWithTwitter(_ sender: UIButton) {
        SignInViewModel.authWithTwitter {[weak self] (success, error) in
            if let error = error {
                let alertController = UIAlertController(title: "Error", message: error.localizedDescription, preferredStyle: .alert)
                let ok = UIAlertAction(title: "ok", style: .default, handler: nil)
                alertController.addAction(ok)
                self?.present(alertController, animated: true, completion: nil)
                return
            }
            
            if success {
                self?.performSegue(withIdentifier: "goToMain", sender: self)
            }
        }
    }
    
    @IBAction func signInWithFacebook(_ sender: UIButton) {
        SignInViewModel.authWithFacebook(viewController: self) {[weak self] (success, error) in
            if let error = error {
                let alertController = UIAlertController(title: "Error", message: error.localizedDescription, preferredStyle: .alert)
                let okAction = UIAlertAction(title: "ok", style: .default, handler: nil)
                alertController.addAction(okAction)
                self?.present(alertController, animated: true, completion: nil)
            }
            if success {
                self?.performSegue(withIdentifier: "goToMain", sender: self)
            }
        }
    }
    
    @IBAction func signInWithGooGle(_ sender: UIButton) {
        GIDSignIn.sharedInstance()?.signIn()
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
