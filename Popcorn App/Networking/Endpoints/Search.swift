//
//  Search.swift
//  Popcorn App
//
//  Created by Lucas Pereira on 10.08.21.
//

import Foundation
import Combine

protocol TheMovieDBSearchAPI {
    func fetchMovies(with keyword: String) -> AnyPublisher<SearchResultsDTO, Error>
}

extension TheMovieDBAPI: TheMovieDBSearchAPI {

    func fetchMovies(with keyword: String) -> AnyPublisher<SearchResultsDTO, Error> {
        guard let encodedInput = keyword.replacingOccurrences(of: " ", with: "+")
                .addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed),
              let request = try? makeGETRequest(path: "/search/movie", parameters: ["query": encodedInput])
        else {
            return Fail(error: RequestError.invalidRequest).eraseToAnyPublisher()
        }
        return publishCodable(request: request)
    }
}
