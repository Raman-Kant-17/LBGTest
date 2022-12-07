//
//  AppDelegate.swift
//  LBG Test
//
//  Created by Raman Kant on 07/12/22.
//

import Foundation

extension URLRequest {
    
    public static func createRequest(url: URL, method: String, data: Data? , parameters: [String: Any]?) -> URLRequest {
        var request = URLRequest(url: url)
        request.httpMethod = method
        request.timeoutInterval = 60
        request.setValue("application/json, text/plain, */*", forHTTPHeaderField: "accept")
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        if let _parameters = parameters {
            var jsonData: Data!
            do {
                jsonData = try JSONSerialization.data(withJSONObject: _parameters, options: JSONSerialization.WritingOptions.prettyPrinted)
            }
            catch let error as NSError {
                print(error.description)
            }
            request.httpBody = jsonData
        }
        if let _data = data {
            request.httpBody = _data
        }
        print("URL : \(url.absoluteString)")
        return request
    }
    
    public static func createMultipartRequest(url: URL, method: String, boundary: String?, data: Data? , parameters: [String: Any]?) -> URLRequest {
        var request = URLRequest(url: url)
        request.httpMethod = method
        request.timeoutInterval = 60
        request.setValue("multipart/form-data; boundary=\(boundary!)", forHTTPHeaderField: "Content-Type")

        if let _parameters = parameters {
            var jsonData: Data!
            do {
                jsonData = try JSONSerialization.data(withJSONObject: _parameters, options: JSONSerialization.WritingOptions.prettyPrinted)
            }
            catch let error as NSError {
                print(error.description)
            }
            request.httpBody = jsonData
        }
        if let _data = data {
            request.httpBody = _data
        }
        print("URL : \(url.absoluteString)")
        return request
    }
}
