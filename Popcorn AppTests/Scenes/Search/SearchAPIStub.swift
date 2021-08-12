//
//  File.swift
//  Popcorn AppTests
//
//  Created by Lucas Pereira on 10.08.21.
//

import Foundation
import Combine
@testable import Popcorn_App

final class SearchAPIStub: TheMovieDBSearchAPI {
    
    var result: SearchResultsDTO?
    
    func fetchMovies(with keyword: String) -> AnyPublisher<SearchResultsDTO, Error> {
        if let result = result {
            return Just(result)
                .setFailureType(to: Error.self)
                .eraseToAnyPublisher()
        } else {
            return Fail(error: TestError.generic)
                .eraseToAnyPublisher()
        }
    }
}
