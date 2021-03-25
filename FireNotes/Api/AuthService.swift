//
//  AuthService.swift
//  FireNotes
//
//  Created by malakoipechyva on 25.03.21.
//

import Foundation
import Firebase

struct AuthCredentials {
    
    let email: String
    let password: String
    let username: String
    
}

struct AuthService {
    
    static let shared = AuthService()
    
    func registerUser(credentials: AuthCredentials, completion: @escaping(Error?, DatabaseReference) -> Void) {
        
        let email = credentials.email
        let password = credentials.password
        let username = credentials.username
        
        Auth.auth().createUser(withEmail: email, password: password) { (result, error) in
            if let error = error {
                print("DEBUG: Error is \(error.localizedDescription)")
                return
            }
            
            guard let uid = result?.user.uid else { return }
            let values = ["email": email,
                          "username": username]
            
            REF_USERS.child(uid).updateChildValues(values, withCompletionBlock: completion)
        }
    }
}