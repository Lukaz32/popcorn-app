//
//  SearchResultsDTOMock.swift
//  Popcorn AppTests
//
//  Created by Lucas Pereira on 11.08.21.
//
import XCTest
import Combine
@testable import Popcorn_App

extension SearchResultsDTO {
    static var mockStarWars: SearchResultsDTO {
        let url = Bundle(for: SearchViewModelTests.self).url(forResource: "SearchResultsDTO_star_wars", withExtension: "json")!
        let jsonData = try! Data(contentsOf: url)
        return try! JSONDecoder().decode(SearchResultsDTO.self, from: jsonData)
    }
    
    static var mockInterstellar: SearchResultsDTO {
        let url = Bundle(for: SearchViewModelTests.self).url(forResource: "SearchResultsDTO_interstellar", withExtension: "json")!
        let jsonData = try! Data(contentsOf: url)
        return try! JSONDecoder().decode(SearchResultsDTO.self, from: jsonData)
    }
}
