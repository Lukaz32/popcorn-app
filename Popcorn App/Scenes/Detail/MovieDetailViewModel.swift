//
//  MovieDetailViewModel.swift
//  Popcorn App
//
//  Created by Lucas Pereira on 11.08.21.
//

import Foundation

final class MovieDetailViewModel {
    
    struct Input {
        let movie: MovieDTO
    }
    
    private let input: Input
    
    private weak var coordinator: SearchFlowCoordinator?
    
    init(input: Input, coordinator: SearchFlowCoordinator) {
        self.input = input
        self.coordinator = coordinator
    }
    
    // MARK: Public API
    
    var title: String {
        input.movie.title.uppercased()
    }
    
    var subtitle: String? {
        DateFormatter.yearString(from: input.movie.releaseDate)
    }
    
    var backdropPath: String? {
        input.movie.backdropPath
    }
    
    var movie: MovieDTO {
        input.movie
    }
    
    func didSelectGoBack() {
        coordinator?.navigateBack()
    }
}
