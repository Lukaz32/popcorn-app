//
//  TheMovieDbAPI.swift
//  Popcorn App
//
//  Created by Lucas Pereira on 10.08.21.
//

import Foundation
import Combine

final class TheMovieDBAPI {
    
    enum RequestError: Error {
        case unauthorized
        case invalidResponse
        case invalidRequest
        case httpError(statusCode: Int)
    }
    
    private let baseURL = "https://api.themoviedb.org/3"
    private let apiKey = "2696829a81b1b5827d515ff121700838"
    
    func makeGETRequest(path: String, parameters: [String: String] = [:]) throws -> URLRequest {
        var components = URLComponents(string: baseURL + path)
        var queryParameters = parameters
        queryParameters["api_key"] = apiKey
        
        components?.queryItems = queryParameters.map { .init(name: $0.key, value: $0.value) }
        
        guard let url = components?.url else {
            throw RequestError.invalidRequest
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        return request
    }
    
    func validateResponse(_ response: URLResponse?, data: Data, error: Error? = nil) throws -> Data {
        if let error = error {
            throw error
        }
        
        guard let httpResponse = response as? HTTPURLResponse else {
            throw RequestError.invalidResponse
        }
        
        if httpResponse.statusCode == 401 {
            throw RequestError.unauthorized
        }
        
        if !(200...299).contains(httpResponse.statusCode) {
            throw RequestError.httpError(statusCode: httpResponse.statusCode)
        }
        
        return data
    }

    
    func publishCodable<Output: Decodable>(request: URLRequest) -> AnyPublisher<Output, Error> {
        URLSession.shared.dataTaskPublisher(for: request)
            .tryMap { try self.validateResponse($0.response, data: $0.data) }
            .decode(type: Output.self, decoder: JSONDecoder())
            .receive(on: RunLoop.main)
            .eraseToAnyPublisher()
    }
}
