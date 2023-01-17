//
//  SearchRepo.swift
//  DemoMusicListMVVM
//
//  Created by PujieLee on 2023/1/12.
//

import Foundation

struct SearchRepo: Codable {
    var resultCount: Int = 0
    var results: [SearchResult] = []
}

struct SearchResult: Codable {
    var artworkUrl100: String? = ""
    var previewUrl: String? = ""
    var longDescription: String? = ""
}
