//
//  AddProductViewController.swift
//  Youtube MVVM Products
//
//  Created by Yogesh Patel on 15/01/23.
//

import UIKit

class AddProductViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        addProduct()
    }

    func addProduct() {
        guard let url = URL(string: "https://dummyjson.com/products/add") else { return }

        let parameters = AddProduct(title: "Yogesh Patel")

        var request = URLRequest(url: url)
        request.httpMethod = "POST"

        // Model to Data Convert (JSONEncoder() + Encodable)
        request.httpBody = try? JSONEncoder().encode(parameters)

        request.allHTTPHeaderFields = [
            "Content-Type": "application/json"
        ]

        URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data else { return }
            do {
                // Data to Model convert - JSONDecoder() + Decodable
                let productResponse = try JSONDecoder().decode(AddProduct.self, from: data)
                print(productResponse)
            }catch {
                print(error)
            }
        }.resume()
    }


}
