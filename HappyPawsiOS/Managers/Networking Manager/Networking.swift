//
//  Networking.swift
//  HappyPaws
//
//  Created by Francesca Haro on 6/8/19.
//  Copyright © 2019 Francesca Haro. All rights reserved.
//
import Foundation
import Alamofire

/**
 Enum to be used when an error was found while networking.
 ````
 case unableToParseResponse
 case badRequest
 ````
 */
enum NetworkingError: Error {
    
    /// Indicates that the response object couldn't be parsed because it is not from the expected type or it doesn't have the expected values or keys.
    case unableToParseResponse
    
    /// Indicates that the server cannot or won't process the request because of some client error (e.g., malformed request syntax, invalid request message framing, or deceptive request routing).
    case badRequest
    
    /// Indicates that the request has been cancelled.
    case cancelled
}

/**
 A set of methods with default implementations for performing networking requests.
 */
protocol Networking {
    
    /**
     Performs a networking request.
     
     - Note: This method has a default implementation on its related extension in order to be used for every request for the entire application.
     - Parameters:
     - url: The URL.
     - method: The HTTP method.
     - parameters: The parameters for the request.
     - headers: The request's headers values.
     - successHandler: A closure to be executed in case of success.
     - errorHandler: A closure to be executed in case of failure.
     - Returns: The request object.
     */
    func performRequest(url: URLConvertible, method: HTTPMethod, parameters: Parameters?, headers: HTTPHeaders?, successHandler: SuccessHandler?, errorHandler: ErrorHandler?) -> DataRequest
    
}

/**
 A extension to provide a default implementation for the methods of the Networking protocol.
 Default implementations make these methods as optionals automatically.
 */
extension Networking {
    
    @discardableResult
    func performRequest(url: URLConvertible, method: HTTPMethod, parameters: Parameters?, headers: HTTPHeaders?, successHandler: SuccessHandler?, errorHandler: ErrorHandler?) -> DataRequest {
        
        let request = Alamofire.request(url, method: method, parameters: parameters, encoding: JSONEncoding.default, headers: headers).validate().responseData { (response) in
            
            if let error = response.error {
                if (error as NSError).code == NSURLErrorCancelled {
                    print("Request for \(try! url.asURL().absoluteString) has been cancelled.")
                    errorHandler?(NetworkingError.cancelled)
                }
                else {
                    print("Unable to complete the request for \(try! url.asURL().absoluteString): \(response.error!)")
                    errorHandler?(NetworkingError.badRequest)
                }
                
                /**
                 To check status code for erros user the following:
                 (error as! AFError).responseCode
                 */
            }
            else {
                
                /**
                 There are some responses where their content is empty. For those scenarios, just send `nil` as the result.
                 For example, the endpoint for resetting a password returns nothings.
                 */
                if response.data!.count == 0 {
                    successHandler?(nil)
                }
                else if response.data!.count > 0 {
                    do {
                        let json = try JSONSerialization.jsonObject(with: response.data!, options: []) as? [String: Any]
                        successHandler?(json)
                        
                        print("Successfully result value for URL \(try! url.asURL().absoluteString): \(String(describing: json))")
                    }
                    catch {
                        print("Unable to parse the response: JSON is null or empty.")
                        errorHandler?(NetworkingError.unableToParseResponse)
                    }
                }
            }
            
        }
        
        return request
    }
    
}
