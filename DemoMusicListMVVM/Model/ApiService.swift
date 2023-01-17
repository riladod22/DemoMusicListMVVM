//
//  ApiService.swift
//  DemoMusicListMVVM
//
//  Created by PujieLee on 2023/1/12.
//

import Foundation

class ApiService: NSObject {
    
    static let sharedInstance = ApiService()
    
    //MARK: Search
    func getSearch(term: String, completion: @escaping (Result<SearchRepo>) -> Void){
        
        let paramaters = ["term": term]
        
        WebService.sharedInstance.sendHttpRequest("search", method: .get, paramaters: paramaters) { result in
            completion(result)
        }
    }
}
