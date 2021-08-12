//
//  MovieListViewModelTests.swift
//  Popcorn AppTests
//
//  Created by Lucas Pereira on 11.08.21.
//

import XCTest
import Combine
@testable import Popcorn_App

class MovieListViewModelTests: XCTestCase {
    
    private var sut: MovieListViewModel!
    private var searchAPIStub: SearchAPIStub!
    private var input: MovieListViewModel.Input!
    private var coordinatorSpy: SearchFlowCoordinatorSpy!
    private var disposeBag = Set<AnyCancellable>()
    
    override func setUpWithError() throws {
        input = .init(searchText: "interstellar", searchResult: .mockInterstellar)
        coordinatorSpy = SearchFlowCoordinatorSpy(navigationController: nil)
        sut = MovieListViewModel(input: input,
                                 coordinator: coordinatorSpy)
    }

    func test_correct_search_data_is_displayed() {
        when("scene is initialised") { _ in
            
            then("it sets the correct title") { _ in
                XCTAssertEqual(sut.title, "interstellar")
            }
            
            then("the first movie is correct") { _ in
                XCTAssertEqual(sut.movies[0].title, "Interstellar")
                XCTAssertEqual(sut.movies[0].releaseDate, "2014-11-05")
                XCTAssertEqual(sut.movies[0].voteAverage, 8.3)
            }
            
            then("the second movie is correct") { _ in
                XCTAssertEqual(sut.movies[1].title, "Interstellar: Nolan's Odyssey")
                XCTAssertEqual(sut.movies[1].releaseDate, "2014-11-05")
                XCTAssertEqual(sut.movies[1].voteAverage, 7.7)
            }
        }
    }
    
    func test_movie_selection() {
        when("a movie is selected") { _ in
            sut.didSelectMovie(at: 0)
            
            then("it delegates the navigation with the right movie data") { _ in
                XCTAssertEqual(coordinatorSpy.detailMovie!.title, "Interstellar")
                XCTAssertEqual(coordinatorSpy.detailMovie!.releaseDate, "2014-11-05")
                XCTAssertEqual(coordinatorSpy.detailMovie!.voteAverage, 8.3)
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
