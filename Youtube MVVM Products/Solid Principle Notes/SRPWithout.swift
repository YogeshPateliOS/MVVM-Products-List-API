//
//  SRPWithout.swift
//  Single Responsibility
//
//  Created by Yogesh Patel on 27/04/23.
//

import Foundation

/*

                            Single Responsibility Principle

    It states that every module should have only one responsibility and reason to change.
    This principle helps you to keep your classes as clean as possible.

*/
/*

class Handler {

 // Hidden dependancy
    func handle() {
        let data = requestDataToAPI()
        let array = parseResponse(data: data)
        saveToDatabase(array: array)
    }

    private func requestDataToAPI() -> Data {
        // Network request and wait the response
        return Data()
    }

    private func parseResponse(data: Data) -> [String] {
        // Parse the network response into array
        return []
    }

    private func saveToDatabase(array: [String]) {
        // Save parsed response into database
    }
    
}
*/
/*
 from an above example, Handler class perform multiple responsibilities like making a network call, parsing the response and saving into the database.
 */

