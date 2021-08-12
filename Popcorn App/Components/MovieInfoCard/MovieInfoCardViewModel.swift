//
//  MovieInfoCardViewModel.swift
//  Popcorn App
//
//  Created by Lucas Pereira on 11.08.21.
//

import Foundation

struct MovieInfoCardViewModel {
    let movie: MovieDTO
    
    var headerText: String {
        "Sample text | 1h 20min | Placeholder | 12 August 2021"
    }
    
    var overview: String {
        movie.overview
    }
    
    var ratingValue: Double {
        movie.voteAverage
    }
    
    var ratingTotalCount: Int {
        movie.voteCount
    }
}
