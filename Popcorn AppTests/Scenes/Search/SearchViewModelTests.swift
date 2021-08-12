//
//  SearchViewModelTests.swift
//  Popcorn AppTests
//
//  Created by Lucas Pereira on 10.08.21.
//

import XCTest
import Combine
@testable import Popcorn_App

class SearchViewModelTests: XCTestCase {
    
    private var sut: SearchViewModel!
    private var searchAPIStub: SearchAPIStub!
    private var movieStorageStub: SearchTextStorageProvider!
    private var coordinatorSpy: SearchFlowCoordinatorSpy!
    private var disposeBag = Set<AnyCancellable>()

    override func setUpWithError() throws {
        movieStorageStub = MovieStorageStub()
        searchAPIStub = SearchAPIStub()
        coordinatorSpy = SearchFlowCoordinatorSpy(navigationController: nil)
        sut = SearchViewModel(searchAPI: searchAPIStub,
                              storage: movieStorageStub,
                              coordinator: coordinatorSpy)
    }
    
    func test_searching_for_a_valid_movie() {
        given("a successful response") { _ in
            searchAPIStub.result = .mockStarWars
            
            when("A \"star wars\" search input is submitted") { _ in
                var isFetchingDataSetTrue = false
                var isFetchingDataSetFalse = false
                var showSuggestionList = true
                
                sut.$isFetchingData.sink { isFetchingData in
                    if isFetchingData { isFetchingDataSetTrue = true }
                    else { isFetchingDataSetFalse = true }
                }.store(in: &disposeBag)
                
                sut.$showSuggestionList.sink { showList in
                    showSuggestionList = showList
                }.store(in: &disposeBag)
                
                sut.submitSearchInput("star wars")
                
                then("it handles data fetching and navigation to Detail") { _ in
                    XCTAssertTrue(isFetchingDataSetTrue)
                    XCTAssertTrue(isFetchingDataSetFalse)
                    XCTAssertFalse(showSuggestionList)
                    XCTAssertEqual(coordinatorSpy.result, SearchResultsDTO.mockStarWars)
                }
            }
        }
    }
    
    func test_searching_for_an_invalid_movie() {
        given("a failure response") { _ in
            searchAPIStub.result = nil
            
            when("A \"star wars\" search input is submitted") { _ in
                var isFetchingDataSetTrue = false
                var isFetchingDataSetFalse = false
                var showSuggestionList = true
                var errorMessage: String?
                
                sut.$isFetchingData.sink { isFetchingData in
                    if isFetchingData { isFetchingDataSetTrue = true }
                    else { isFetchingDataSetFalse = true }
                }.store(in: &disposeBag)
                
                sut.$showSuggestionList.sink { showList in
                    showSuggestionList = showList
                }.store(in: &disposeBag)
                
                sut.$fetchingErrorMessage.sink { message in
                    errorMessage = message
                }.store(in: &disposeBag)
                
                sut.submitSearchInput("star wars")
                
                then("it handles data fetching") { _ in
                    XCTAssertTrue(isFetchingDataSetTrue)
                    XCTAssertTrue(isFetchingDataSetFalse)
                    XCTAssertFalse(showSuggestionList)
                }
                
                then("is sets an error message") { _ in
                    XCTAssertEqual(errorMessage!, "Movie not found")
                }
            }
        }
    }

    func test_changing_the_search_input_text() throws {
        given("Some existing stored movies") { _ in
            movieStorageStub.store(SearchResultsDTO.mockStarWars.results[0].title)
            movieStorageStub.store(SearchResultsDTO.mockStarWars.results[1].title)
            
            when("focusing the search field") { _ in
                sut.searchInputFieldFocused()
                
                then("it shows the suggestion list") { _ in
                    XCTAssertTrue(sut.showSuggestionList)
                }
            }
            
            when("A \"star wars\" search input is typed") { _ in
                sut.searchInputTextChanged("star wars")
                
                then("it returns the recently searched matching movies") { _ in
                    XCTAssertEqual(sut.recentlySearchedMovies[0], "Star Wars")
                    XCTAssertEqual(sut.recentlySearchedMovies[1], "Star Wars: The Rise of Skywalker")
                }
            }
        }
    }
}
