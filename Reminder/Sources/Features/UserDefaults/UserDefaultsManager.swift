//
//  UserDefaultManager.swift
//  Reminder
//
//  Created by Milton Martins on 10/06/25.
//

import Foundation

class UserDefaultsManager {
    private static let userKey = "user"
    
    static func saveUser(user: User) {
        let encoder = JSONEncoder()
        if let data = try? encoder.encode(user) {
            UserDefaults.standard.set(data, forKey: userKey)
            UserDefaults.standard.synchronize()
        }
    }
    
    static func getUser() -> User? {
        guard let user = UserDefaults.standard.data(forKey: userKey) else {
            return nil
        }
        
        return try? JSONDecoder().decode(User.self, from: user)
    }
    
    static func removeUser() {
        UserDefaults.standard.removeObject(forKey: userKey)
        UserDefaults.standard.synchronize()
    }
}
