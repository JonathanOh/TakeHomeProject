//
//  CatRequest.swift
//  TakeHomeProject
//
//  Created by Jonathan Oh on 3/11/18.
//  Copyright © 2018 Jonathan Oh. All rights reserved.
//

import Foundation

class CatRequest {
    let endpoint = "https://chex-triplebyte.herokuapp.com/api/cats?page="
    let pageNumber: Int
    private var url: String {
        return "\(endpoint)" + "\(pageNumber)"
    }
    
    init(pageNumber: Int) {
        self.pageNumber = pageNumber
    }
    
    func send(_ cats: @escaping([Cat]) -> ()) {
        HTTPManager.shared.getDataFromURLString(url) { (catData) in
            do {
                let arrayOfCats = try JSONDecoder().decode([Cat].self, from: catData)
                cats(arrayOfCats)
            } catch let error {
                print("we have an error with cats: \(error)")
            }
        }
    }
    
}
