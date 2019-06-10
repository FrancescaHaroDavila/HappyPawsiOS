//
//  SessionManager.swift
//  HappyPaws
//
//  Created by Francesca Haro on 6/8/19.
//  Copyright © 2019 Francesca Haro. All rights reserved.
//
import UIKit

/// Key to be used when saving user data in `NSUserDefaults`.
private let UserDataKey = "UserDataKey"

/**
 A class to handle user persistence into the application.
 */
class SessionManager {
    
    // MARK: - Properties
    
    static let shared = SessionManager()
    
    
    
    // MARK: - Methods
    
    /**
     Private initialization to ensure just one instance is created.
     */
    fileprivate init() { }
    
    /**
     Save the logged in user locally into the application.
     
     This method uses the `NSUserDefault` storage.
     
     - Parameters:
     - user: The user who has logged in.
     - additionalImplementation: An optional closure to be executed after the user has been saved.
     - Returns: `true` if the user has been saved successfully; otherwise, `false`.
     */
    @discardableResult
    func save(user: User?, _ additionalImplementation: (() -> Void)?) -> Bool {
        var userDataSaved = false
        
        if user != nil {
            
            /// Delete the last user who has logged in.
            let userDefaults = UserDefaults.standard
            userDefaults.removeObject(forKey: UserDataKey)
            
            /// Save the new user.
            if let userData = try? PropertyListEncoder().encode(user) {
                userDefaults.set(userData, forKey: UserDataKey)
                userDataSaved = userDefaults.synchronize()
                
                /// Execute the closure for additional implementations if exists.
                additionalImplementation?()
            }
        }
        
        return userDataSaved
    }
    
    /**
     Returns the local logged in user.
     - Returns: The user who has logged in or `nil` if it doesn't exist.
     */
    func getUser() -> Any? {
        var user: Any?
        
        let userDefaults = UserDefaults.standard
        let data = userDefaults.object(forKey: UserDataKey) as? Data
        if data != nil, let userSaved = try? PropertyListDecoder().decode(User.self, from: data!) {
            user = userSaved
        }
        
        return user
    }
    
    /**
     Deletes the logged in user locally from the application.
     
     - Parameter additionalImplementation: An optional closure to be executed after the user has been deleted.
     - Returns: `true` if the user has been deleted successfully; otherwise, `false`.
     */
    @discardableResult
    func deleteUser(_ additionalImplementation: (() -> Void)?) -> Bool {
        var userDeleted = false
        
        /// Delete the logged in user.
        let userDefaults = UserDefaults.standard
        userDefaults.removeObject(forKey: UserDataKey)
        userDeleted = userDefaults.synchronize()
        
        /// Execute the closure for additional implementations if exists.
        additionalImplementation?()
        
        return userDeleted
    }
    
}
