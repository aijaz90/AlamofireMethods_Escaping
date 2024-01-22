//
//  NetworkManager.swift
//  Phi Wallet App
//
//  Created by Aijaz Ali on 22/01/2024.
//


import Alamofire

class NetworkManager {
    
    static let shared = NetworkManager()
    
    func get<T: Decodable>(userName: String, url: String? = nil, modelType: T.Type, completion: @escaping (Result<T, Error>) -> Void) {
        performRequest(userName: userName,url: url, method: .get, modelType: modelType, completion: completion)
    }
    
    func post<T: Decodable>(url: String, modelType: T.Type, parameters: [String: Any]? = nil, encoding: ParameterEncoding = URLEncoding.default, headers: HTTPHeaders? = ["Content-Type": "application/json"], completion: @escaping (Result<T, Error>) -> Void) {
        performRequest(url: url, method: .post, modelType: modelType, parameters: parameters, encoding: encoding, headers: headers, completion: completion)
    }
    
    func put<T: Decodable>(url: String, modelType: T.Type, parameters: [String: Any]? = nil, encoding: ParameterEncoding = JSONEncoding.default, headers: HTTPHeaders? = nil, completion: @escaping (Result<T, Error>) -> Void) {
        performRequest(url: url, method: .put, modelType: modelType, parameters: parameters, encoding: encoding, headers: headers, completion: completion)
    }
    
    func delete<T: Decodable>(url: String, modelType: T.Type, headers: HTTPHeaders? = nil, completion: @escaping (Result<T, Error>) -> Void) {
        performRequest(url: url, method: .delete, modelType: modelType, headers: headers, completion: completion)
    }
    
    private func performRequest<T: Decodable>(userName: String? = nil, url: String? = nil, method: HTTPMethod, modelType: T.Type, parameters: [String: Any]? = nil, encoding: ParameterEncoding = URLEncoding.default, headers: HTTPHeaders? = ["Content-Type": "application/json"], completion: @escaping (Result<T, Error>) -> Void) {
        var customURL = URL(string: ".com")
        if  let url = url {
            customURL = URL(string: url)
        } else {
            customURL  = URL(string: "https://api.nationalize.io/?name=\(userName ?? "NA")")
        }
            
        var customHeaders = headers ?? [:]
        if let token = UserDefaults.standard.object(forKey: "userToken") as? String {
            // Get your authorization token from a secure source, e.g., keychain
            customHeaders["Authorization"] = "Bearer \(token)"
        }
        AF.request(customURL!, method: method, parameters: parameters, encoding: encoding, headers: customHeaders)
            .validate()//.cacheResponse(using: .useProtocolCachePolicy)
            .responseDecodable(of: modelType) { response in
                switch response.result {
                case .success(let value):
                    completion(.success(value))
                case .failure(let error):
                    completion(.failure(error))
                }
            }
    }
}


enum API: Error {
    case URLGenerationError
    case HTTPBadRequestError
}
