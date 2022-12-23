//
//  APIManager.swift
//  Youtube MVVM Products
//
//  Created by Yogesh Patel on 23/12/22.
//

import UIKit

// Singleton Design Pattern
// final - inheritance nahi hoga theek hai final ho gya

enum DataError: Error {
    case invalidResponse
    case invalidURL
    case invalidData
    case network(Error?)
}

typealias Handler = (Result<[Product], DataError>) -> Void

final class APIManager {

    static let shared = APIManager()
    private init() {}

    func fetchProducts(completion: @escaping Handler) {
        guard let url = URL(string: Constant.API.productURL) else {
            return
        }
        // Background task
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data, error == nil else {
                completion(.failure(.invalidData))
                return
            }

            guard let response = response as? HTTPURLResponse,
                  200 ... 299 ~= response.statusCode else {
                completion(.failure(.invalidResponse))
                return
            }
            // JSONDecoder() - Data ka Model(Array) mai convert karega
            do {
                let products = try JSONDecoder().decode([Product].self, from: data)
                completion(.success(products))
            }catch {
                completion(.failure(.network(error)))
            }

        }.resume()
        print("Ended")
    }
    
}

/*
class A: APIManager {

    override func temp() {
        <#code#>
    }

    func configuration() {
        let manager = APIManager()
        manager.temp()

        // APIManager.temp()
        APIManager.shared.temp()
    }

}
*/

// singleton - singleton class ka object create hoga outside of the class
// Singleton - singleton class ka object create nahi hoga outside of the class
