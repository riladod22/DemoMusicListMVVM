//
//  HTTPMethod.swift
//  DemoMusicListMVVM
//
//  Created by PujieLee on 2023/1/12.
//

import Foundation

//回傳
enum Result<Success> {
    //成功(夾帶資料)
    case success(Success)
    //失敗(夾帶error敘述)
    case failure(String?)
}

//
enum HTTPMethod: String {
    case get = "GET"
    case post = "POST"
    case put = "PUT"
    case delete = "DELETE"
}

//
enum NetworkResponse: String {
    case success
    case authenticationError = "驗證錯誤"
    case badRequest = "請求發生錯誤"
    case outdated = "你的網路請求已經過期"
    case failed = "網路請求失敗"
    case noData = "網路請求沒有返回資料"
    case unableToDecode = "無法轉碼返回的資料"
}
