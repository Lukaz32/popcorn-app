//
//  SearchFlowCoordinatorSpy.swift
//  Popcorn AppTests
//
//  Created by Lucas Pereira on 10.08.21.
//

import Foundation
import XCTest
import Combine
@testable import Popcorn_App

class SearchFlowCoordinatorSpy: SearchFlowCoordinator {
    
    var result: SearchResultsDTO?
    var detailMovie: MovieDTO?
    var navigateBackCalled = false
    
    override func navigateToListScene(with searchText: String, result: SearchResultsDTO) {
        self.result = result
    }
    
    override func navigateToDetailScene(with movie: MovieDTO) {
        detailMovie = movie
    }
    
    override func navigateBack() {
        navigateBackCalled = true
    }
}
