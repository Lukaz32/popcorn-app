//
//  SearchFlowCoordinator.swift
//  Popcorn App
//
//  Created by Lucas Pereira on 10.08.21.
//

import UIKit

class SearchFlowCoordinator {
    
    weak var navigationController: UINavigationController?
    
    init(navigationController: UINavigationController?) {
        self.navigationController = navigationController
    }
    
    func start() {
        let searchViewController = SearchViewController(viewModel: SearchViewModel(coordinator: self))
        navigationController?.pushViewController(searchViewController, animated: true)
    }
    
    func navigateToListScene(with searchText: String, result: SearchResultsDTO) {
        let input = MovieListViewModel.Input(searchText: searchText, searchResult: result)
        let listViewController = MovieListViewController(viewModel: MovieListViewModel(input: input, coordinator: self))
        navigationController?.pushViewController(listViewController, animated: true)
    }
    
    func navigateToDetailScene(with movie: MovieDTO) {
        let viewModel = MovieDetailViewModel(input: .init(movie: movie), coordinator: self)
        let detailViewController = MovieDetailViewController(viewModel: viewModel)
        navigationController?.pushViewController(detailViewController, animated: true)
    }
    
    func navigateBack() {
        navigationController?.popViewController(animated: true)
    }
}
