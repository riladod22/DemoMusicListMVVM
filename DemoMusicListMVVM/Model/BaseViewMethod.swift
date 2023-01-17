//
//  BaseViewMethod.swift
//  DemoMusicListMVVM
//
//  Created by PujieLee on 2023/1/12.
//

import Foundation

enum EventResult<T> {
    case success
    case failure(T?)
}
