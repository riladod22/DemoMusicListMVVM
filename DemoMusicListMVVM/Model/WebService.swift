//
//  WebService.swift
//  DemoMusicListMVVM
//
//  Created by PujieLee on 2023/1/12.
//

import Foundation
import Alamofire

class WebService {
    
    static let sharedInstance = WebService()
    
    func sendHttpRequest<T: Codable>(_ endPoint: String, method: HTTPMethod, paramaters: [String:String]?, needValidate: Bool = false, completion: @escaping (Result<T>) -> Void){
        
        let url = Domain.URL_API + endPoint
        
        AF.request(url, method: .get, parameters: paramaters, encoding:URLEncoding.queryString, headers:nil)
            .response { response in
                
                if response.error != nil {
                    completion(.failure("網路連線出現異常"))
                    return
                }
                
                let statusCode = self.getStatusCode(response.response)
                switch statusCode {
                case 200...299:
                    //success
                    guard let data = response.data else {
                        completion(.failure(NetworkResponse.noData.rawValue))
                        return
                    }
                    
                    do {
                        let jsonDecoder = JSONDecoder()
                        let response = try jsonDecoder.decode(T.self, from: data)
                        completion(.success(response))
                    } catch {
                        completion(.failure(NetworkResponse.unableToDecode.rawValue))
                    }
                default:
                    //failure
                    let errorMsg = self.handleNetworkResponseMessage(statusCode)
                    completion(.failure(errorMsg))
                }
            }
    }
    
    private func handleNetworkResponseMessage(_ statusCode: Int)-> String{
        
        switch statusCode {
        case 200...299: return ""
        case 401...500: return NetworkResponse.authenticationError.rawValue
        case 500...599: return NetworkResponse.badRequest.rawValue
        case 600: return NetworkResponse.outdated.rawValue
        default: return NetworkResponse.failed.rawValue
        }
    }
    
    private func getStatusCode(_ response: HTTPURLResponse?) -> Int {
        return response?.statusCode ?? -1
    }
}
