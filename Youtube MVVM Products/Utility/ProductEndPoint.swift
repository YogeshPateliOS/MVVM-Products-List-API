//
//  ProductEndPoint.swift
//  Youtube MVVM Products
//
//  Created by Yogesh Patel on 15/01/23.
//

import Foundation

enum ProductEndPoint {
    case products // Module - GET
    case addProduct(product: AddProduct) // POST
}

// https://fakestoreapi.com/products
extension ProductEndPoint: EndPointType {

    var path: String {
        switch self {
        case .products:
            return "products"
        case .addProduct:
            return "products/add"
        }
    }

    var baseURL: String {
        switch self {
        case .products:
            return "https://fakestoreapi.com/"
        case .addProduct:
            return "https://dummyjson.com/"
        }
    }

    var url: URL? {
        return URL(string: "\(baseURL)\(path)")
    }

    var method: HTTPMethods {
        switch self {
        case .products:
            return .get
        case .addProduct:
            return .post
        }
    }

    var body: Encodable? {
        switch self {
        case .products:
            return nil
        case .addProduct(let product):
            return product
        }
    }

    var headers: [String : String]? {
        APIManager.commonHeaders
    }
}
