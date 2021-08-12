//
//  MovieStorageStub.swift
//  Popcorn AppTests
//
//  Created by Lucas Pereira on 10.08.21.
//

import Foundation
import Combine
@testable import Popcorn_App

final class MovieStorageStub: SearchTextStorageProvider {
    private var storage = [String]()
    
    func store(_ searchText: String) {
        storage.append(searchText)
    }
    
    func retrieve() -> [String] {
        storage
    }
}
