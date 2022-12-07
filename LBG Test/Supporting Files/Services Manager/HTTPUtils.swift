//
//  AppDelegate.swift
//  LBG Test
//
//  Created by Raman Kant on 07/12/22.
//

import Foundation

enum HTTPMethod: String {
    case _get = "GET"
    case _post = "POST"
    case _put = "PUT"
    case _delete = "DELETE"
    case _update = "UPDATE"
    case _patch = "PATCH"
}

final class HTTPUtils {
    
    static let shared = HTTPUtils()
    private init() {}
    
    func requestGet<T: Codable>(url: URL, method: HTTPMethod, type:T.Type, completion: @escaping(_ result: T?, _ error: Error?) -> Void) {
        
        let request = URLRequest.createRequest(url: url, method: method.rawValue, data: nil, parameters: nil)
        URLSession.shared.dataTask(with: request) { data, response, error in
            guard (error == nil) else {
                completion(nil, error)
                return
            }
            do {
                self.printResponse(data: data, response: response, error: error)
                let jsonDecoder = JSONDecoder()
                let result = try jsonDecoder.decode(T.self, from: data!)
                completion(result, nil)
            }
            catch let _error {
                debugPrint("ERROR IN DECODER: \(_error)")
                completion(nil, error)
            }
        }
        .resume()
    }
    
    func printResponse(data: Data?, response: URLResponse?, error: Error?) {
        if let httpResponse = response as? HTTPURLResponse {
            print("HTTP RESPONSE CODE = \(httpResponse.statusCode)")
        }
        if let stringJSON = String(data: data ?? Data() , encoding: String.Encoding.utf8) {
            print("RESPONSE AS JSON = \(stringJSON)")
        }
        if let _error = error {
            print("HTTP RESPONSE CODE = \(_error.localizedDescription)")
        }
    }
}
