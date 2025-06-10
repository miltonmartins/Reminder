//
//  LoginViewModel.swift
//  Reminder
//
//  Created by Milton Martins on 09/06/25.
//

import FirebaseAuth

class LoginViewModel {
    var successResult: ((String) -> Void)?
    var errorResult: ((String) -> Void)?
    
    func doAuth(user: String, password: String) {
        Auth.auth().signIn(withEmail: user, password: password) { [weak self] authResult, error in
            if let error = error {
                self?.errorResult?(error.localizedDescription)
            } else {
                self?.successResult?(user)
            }
        }
    }
}
