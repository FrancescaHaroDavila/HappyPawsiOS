//
//  NetworkingManager.swift
//  HappyPaws
//
//  Created by Francesca Haro on 6/8/19.
//  Copyright © 2019 Francesca Haro. All rights reserved.
//
import Foundation

typealias SuccessHandler = ((_ json: [String: Any]?) -> Void)
typealias ErrorHandler = ((_ error: NetworkingError) -> Void)

/**
 A class to handle networking requests.
 
 The main implementation of this class just configures the necessary values for requests (i.e. Base URL)
 In order to see requests' implementations, just check its related extensions.
 */
class NetworkingManager: Networking {
    
    // MARK: - Properties
    
    static let shared = NetworkingManager()
    let baseUrl: String
    
    
    
    // MARK: - Methods
    
    /**
     Private initialization to ensure just one instance is created.
     */
    fileprivate init() {
        self.baseUrl = ""
    }
    
}
