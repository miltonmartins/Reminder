//
//  UserDefaultManager.swift
//  Reminder
//
//  Created by Milton Martins on 10/06/25.
//

import Foundation
import UIKit

class UserDefaultsManager {
    private static let userKey = "user"
    private static let userNameKey = "userName"
    private static let profileImageKey = "profileImage"
    
    static func saveUser(user: User) {
        let encoder = JSONEncoder()
        if let data = try? encoder.encode(user) {
            UserDefaults.standard.set(data, forKey: userKey)
            UserDefaults.standard.synchronize()
        }
    }
    
    static func saveUserName(userName: String) {
        UserDefaults.standard.set(userName, forKey: userNameKey)
        UserDefaults.standard.synchronize()
    }
    
    static func saveProfileImage(image: UIImage) {
        if let imageData = image.jpegData(compressionQuality: 1.0) {
            UserDefaults.standard.set(imageData, forKey: profileImageKey)
        }
    }
    
    static func getUser() -> User? {
        guard let user = UserDefaults.standard.data(forKey: userKey) else {
            return nil
        }
        
        return try? JSONDecoder().decode(User.self, from: user)
    }
    
    static func getUserName() -> String? {
        return UserDefaults.standard.string(forKey: userNameKey)
    }
    
    static func getProfileImage() -> UIImage? {
        guard let imageData = UserDefaults.standard.data(forKey: profileImageKey) else {
            return nil
        }
        
        return UIImage(data: imageData)
    }
    
    static func removeUser() {
        UserDefaults.standard.removeObject(forKey: userKey)
        UserDefaults.standard.removeObject(forKey: userNameKey)
        UserDefaults.standard.removeObject(forKey: profileImageKey)
        UserDefaults.standard.synchronize()
    }
}
