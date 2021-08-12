//
//  MovieDetailViewModelTests.swift
//  Popcorn AppTests
//
//  Created by Lucas Pereira on 12.08.21.
//

import XCTest
import Combine
@testable import Popcorn_App

class MovieDetailViewModelTests: XCTestCase {
    
    private var sut: MovieDetailViewModel!
    private var input: MovieDetailViewModel.Input!
    private var coordinatorSpy: SearchFlowCoordinatorSpy!
    private var disposeBag = Set<AnyCancellable>()
    private let movie = SearchResultsDTO.mockInterstellar.results.first!
    
    override func setUpWithError() throws {
        input = .init(movie: movie)
        coordinatorSpy = SearchFlowCoordinatorSpy(navigationController: nil)
        sut = MovieDetailViewModel(input: input,
                                 coordinator: coordinatorSpy)
    }

    func test_initialisation() {
        when("scene initialises") { _ in
            
            then("it sets the correct movie info") { _ in
                XCTAssertEqual(sut.title, "INTERSTELLAR")
                XCTAssertEqual(sut.subtitle!, "2014")
                XCTAssertEqual(sut.backdropPath, "/rAiYTfKGqDCRIIqo664sY9XZIvQ.jpg")
            }
            
            then("it sets the correct movie") { _ in
                XCTAssertEqual(sut.movie, movie)
            }
        }
    }
    
    func test_back_navigation() {
        when("the back button is selected") { _ in
            sut.didSelectGoBack()
            
            then("it delegates the navigation correctly") { _ in
                XCTAssertTrue(coordinatorSpy.navigateBackCalled)
            }
        }
    }
}
