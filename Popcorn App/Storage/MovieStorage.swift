//
//  StorageProvider.swift
//  Popcorn App
//
//  Created by Lucas Pereira on 10.08.21.
//

import Foundation

protocol SearchTextStorageProvider {
    func store(_ searchText: String)
    func retrieve() -> [String]
}

enum MovieStorageError: Error {
    case encodingError
}

final class MovieStorage: SearchTextStorageProvider {
    
    @UserDefault("recentlySearchedMovies", defaultValue: [String]())
    private var recentlySearchedMovies: [String]
    
    func store(_ searchText: String) {
        let cleanText = searchText.trimmingCharacters(in: .whitespacesAndNewlines)
        if !recentlySearchedMovies.contains(cleanText) {
            recentlySearchedMovies.append(searchText)
            recentlySearchedMovies = recentlySearchedMovies.suffix(10)
        }
    }
    
    func retrieve() -> [String] {
        recentlySearchedMovies
    }
}
