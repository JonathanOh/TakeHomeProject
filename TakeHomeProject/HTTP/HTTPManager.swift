//
//  HTTPManager.swift
//  TakeHomeProject
//
//  Created by Jonathan Oh on 3/11/18.
//  Copyright © 2018 Jonathan Oh. All rights reserved.
//

import Foundation

class HTTPManager {
    static let shared = HTTPManager()
    private init() {}
    
    func getDataFromURLString(_ urlString: String, dataResponse: @escaping (Data) -> ()) {
        guard let url = URL(string: urlString) else { return }
        URLSession.shared.dataTask(with: url) { (data, urlResponse, error) in
            if let error = error {
                print("we have error with a request in HTTPManager: \(error)")
            }
            if let data = data {
                dataResponse(data)
            }
        }.resume()
    }
}
