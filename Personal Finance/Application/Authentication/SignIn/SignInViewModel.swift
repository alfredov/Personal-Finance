//
//  SignInViewModel.swift
//  Personal Finance
//
//  Created by Alfredo Villagomez on 1/30/19.
//  Copyright © 2019 Alfredo Villagomez. All rights reserved.
//

import Foundation
import FirebaseAuth
import TwitterKit

typealias SignInHandler = ((_ success: Bool, _ error: Error?) -> Void)

class SignInViewModel: NSObject {
    static let emailPattern = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
    static let passwordPattern = "^(?=.*[a-z])(?=.*[A-Z])(?=.*\\d)(?=.*[#$^+=!*()@%&]).{8,}$"
    
    static private func validate(text: String, regex: String) -> Bool {
        let range = NSRange(location: 0, length: text.count)
        let regex = try? NSRegularExpression(pattern: regex, options: [])
        return regex?.firstMatch(in: text, options: [], range: range) != nil
    }
    
    static func signInWith(email: String?, password: String?, handler: SignInHandler?) {
        guard let email = email, validate(text: email, regex: emailPattern) else {
            return
        }

        guard let password = password, validate(text: password, regex: passwordPattern) else {
            return
        }
        
        Auth.auth().signIn(withEmail: email, password: password) { (result, error) in
            if let error = error {
                handler?(false, error)
            }
            
            if result != nil {
                handler?(true, nil)
            }
        }
    }
    
    static func authWithTwitter(handler: SignInHandler?) {
        TWTRTwitter.sharedInstance().logIn { (session, error) in
            guard let session = session else {
                handler?(false, nil)
                return
            }
            
            let authToken = session.authToken
            let authSecret = session.authTokenSecret
            
            let credentials = TwitterAuthProvider.credential(withToken: authToken, secret: authSecret)
            Auth.auth().signInAndRetrieveData(with: credentials, completion: { (result, error) in
                if let error = error {
                    handler?(false, error)
                    return
                }
                
                handler?(true, nil)
            })
        }
    }
}
