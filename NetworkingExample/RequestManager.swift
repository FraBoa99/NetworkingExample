//
//  RequestManager.swift
//  NetworkingExample
//
//  Created by Josh on 18/11/2019.
//  Copyright © 2019 Dstech. All rights reserved.
//

import Foundation
import UIKit

enum HttpMethods: String {
    case GET = "GET"
    case POST = "POST"
    case PUT = "PUT"
    case DELETE = "DELETE"
}

enum RequestError: Error {
    case urlFailed
    case noData
    case requestError
    case parsingFailed
}

class RequestManager {
    
    static let instance = RequestManager()
    
    func requestUserList(completion: @escaping ((Result<PageUser, RequestError>) -> Void)) {

        
        /// 1. Creare l'url
        let getUserListUrl = "https://reqres.in/api/users"
        guard let url = URL(string: getUserListUrl) else {
            print("Non riesco a convertire l'url")
            completion(.failure(.urlFailed))
            return
        }

        /// 2. Creare la richiesta HTTP
        var request = URLRequest(url: url)
        request.httpMethod = HttpMethods.GET.rawValue

        /// 3. Creare e avviare la sessione
        let session = URLSession.shared.dataTask(with: request) { (dt, resp, err) in

            /// 4. Controllare se ci sono errori
            if let _ = err {
                completion(.failure(.requestError))
            }

            /// 5. Controllare se contiene una risposta
            guard let data = dt else {
                completion(.failure(.noData))
                return
            }

            /// 6. Parsare la risposta
            if let obj = try? JSONDecoder().decode(PageUser.self, from: data) {
                completion(.success(obj))
            } else {
                completion(.failure(.parsingFailed))
            }
        }
        session.resume()
    }

    
}
