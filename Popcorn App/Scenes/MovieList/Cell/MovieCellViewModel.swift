//
//  MovieCellViewModel.swift
//  Popcorn App
//
//  Created by Lucas Pereira on 11.08.21.
//

import Foundation

final class MovieCellViewModel {
    
    private let movie: MovieDTO
    
    init(movie: MovieDTO) {
        self.movie = movie
    }
    
    var title: String {
        movie.title
    }
    
    var subtitle: String? {
        DateFormatter.yearString(from: movie.releaseDate)
    }
    
    var footer: String {
        "Sample text | 1h 20min | Placeholder | 12 August 2021"
    }
    
    var posterPath: String? {
        movie.posterPath
    }
    
    var ratingValue: Double {
        movie.voteAverage
    }
    
    var ratingTotalCount: Int {
        movie.voteCount
    }
}
