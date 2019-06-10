//
//  User.swift
//  HappyPaws
//
//  Created by Francesca Haro on 6/8/19.
//  Copyright © 2019 Francesca Haro. All rights reserved.
//

import Foundation

/**
 The application's user.
 */
class User: Codable {
    
    // MARK: - Properties
    
    var id: Int?
    var name: String?
    var email: String?
    var token: String?
    var password: String?
    
    
    // MARK: - Methods
    
    /**
     Instantiates a user from a JSON dictionary.
     
     - Parameter json: The dictionary with the values to be parsed.
     - Returns: A `User` instance or `nil` if an error came up.
     */
    init?(fromJson json: [String: Any]?) {
        
        guard let _ = json else {
            return nil
        }
        
        self.id = json!["user_id"] as? Int
        self.name = json!["full_name"] as? String
        self.email = json!["email"] as? String
        self.token = json!["token"] as? String
    }
    
}
