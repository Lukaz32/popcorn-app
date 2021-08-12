//
//  MovieListViewModel.swift
//  Popcorn App
//
//  Created by Lucas Pereira on 10.08.21.
//

import Foundation

final class MovieListViewModel {
    
    struct Input {
        let searchText: String
        let searchResult: SearchResultsDTO
    }
    
    private let input: Input
    private weak var coordinator: SearchFlowCoordinator?
    
    init(input: Input, coordinator: SearchFlowCoordinator) {
        self.input = input
        self.coordinator = coordinator
    }
    
    // MARK: Internal API
    
    var title: String {
        input.searchText
    }
    
    var movies: [MovieDTO] {
        input.searchResult.results
    }
    
    func didSelectMovie(at index: Int) {
        coordinator?.navigateToDetailScene(with: movies[index])
    }
    
    func didSelectGoBack() {
        coordinator?.navigateBack()
    }
}
