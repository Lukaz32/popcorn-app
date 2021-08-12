//
//  SearchViewModel.swift
//  Popcorn App
//
//  Created by Lucas Pereira on 10.08.21.
//

import Foundation
import Combine

final class SearchViewModel {
    
    enum Constants { // TODO: Add localisation
        static let movieNotFound = "Movie not found"
    }
    
    @Published private(set) var isFetchingData: Bool = false
    @Published private(set) var fetchingErrorMessage: String?
    @Published private(set) var recentlySearchedMovies: [String] = []
    @Published private(set) var showSuggestionList: Bool = false
    private let searchAPI: TheMovieDBSearchAPI
    private let storage: SearchTextStorageProvider
    private weak var coordinator: SearchFlowCoordinator?
    private var disposeBag = Set<AnyCancellable>()
    
    init(searchAPI: TheMovieDBSearchAPI = TheMovieDBAPI(),
         storage: SearchTextStorageProvider = MovieStorage(),
         coordinator: SearchFlowCoordinator) {
        self.searchAPI = searchAPI
        self.storage = storage
        self.coordinator = coordinator
    }
    
    // MARK: Internal methods
    
    func searchInputFieldFocused() {
        showSuggestionList = true
        recentlySearchedMovies = storage.retrieve()
    }
    
    func searchInputTextChanged(_ text: String?) {
        // TODO: Update recent searches that match the input text
    }
    
    func submitSearchInput(_ text: String?) {
        guard let text = text else { return }
        showSuggestionList = false
        isFetchingData = true
        searchAPI
            .fetchMovies(with: text)
            .sink { [weak self] completion in
                self?.isFetchingData = false
                switch completion {
                case .failure:
                    self?.fetchingErrorMessage = Constants.movieNotFound
                default: break
                }
            } receiveValue: { [weak self] result in
                self?.handleFetchedMovies(searchText: text, result: result)
            }.store(in: &disposeBag)

    }
    
    // MARK: Private methods
    
    private func handleFetchedMovies(searchText: String, result: SearchResultsDTO) {
        guard !result.results.isEmpty else {
            fetchingErrorMessage = Constants.movieNotFound
            return
        }
        storage.store(searchText)
        coordinator?.navigateToListScene(with: searchText, result: result)
    }
}
