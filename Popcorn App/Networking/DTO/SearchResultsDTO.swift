//
//  SearchResultsDTO.swift
//  Popcorn App
//
//  Created by Lucas Pereira on 10.08.21.
//

import Foundation

struct SearchResultsDTO: Decodable, Equatable {
    let page: Int
    let results: [MovieDTO]
    let totalPages, totalResults: Int

    enum CodingKeys: String, CodingKey {
        case page, results
        case totalPages = "total_pages"
        case totalResults = "total_results"
    }
}
