//
//  MovieDetailViewController.swift
//  Popcorn App
//
//  Created by Lucas Pereira on 11.08.21.
//

import UIKit

final class MovieDetailViewController: CustomNavigationViewController {
    
    private let viewModel: MovieDetailViewModel
    private let headerStackView: UIStackView = {
       let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        return stackView
    }()
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = true
        label.font = Theme.Font.appFont(ofSize: 48, weight: .bold)
        label.minimumScaleFactor = 0.5
        label.textColor = Theme.Color.white
        label.numberOfLines = 2
        return label
    }()
    private let subtitleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = true
        label.font = Theme.Font.appFont(ofSize: 33, weight: .light)
        label.numberOfLines = 2
        label.textColor = Theme.Color.white
        return label
    }()
    private let movieImageView: MovieImageView = {
        let posterImage = MovieImageView(size: .large)
        posterImage.translatesAutoresizingMaskIntoConstraints = false
        posterImage.contentMode = .scaleAspectFill
        return posterImage
    }()
    private lazy var infoCardView: MovieInfoCardView = {
        let view = MovieInfoCardView(viewModel: .init(movie: viewModel.movie))
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    // MARK: Initialization
    
    init(viewModel: MovieDetailViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
        setupUI()
        setupConstraints()
    }
    
    // MARK: Private API
    
    private func setupUI() {
        showsBackButton = true
        view.backgroundColor = Theme.Color.blue
        view.addSubview(headerStackView)
        view.addSubview(movieImageView)
        view.addSubview(infoCardView)
        headerStackView.addArrangedSubview(titleLabel)
        headerStackView.addArrangedSubview(subtitleLabel)
        titleLabel.text = viewModel.title
        subtitleLabel.text = viewModel.subtitle
        movieImageView.loadImage(with: viewModel.backdropPath)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            headerStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 33),
            headerStackView.topAnchor.constraint(equalTo: backButton.bottomAnchor, constant: 40),
            headerStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -33)
        ])
        
        NSLayoutConstraint.activate([
            movieImageView.topAnchor.constraint(equalTo: headerStackView.bottomAnchor, constant: 40),
            movieImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 33),
            movieImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 66),
            movieImageView.heightAnchor.constraint(equalToConstant: 300)
        ])
        
        NSLayoutConstraint.activate([
            infoCardView.topAnchor.constraint(equalTo: movieImageView.bottomAnchor, constant: 40),
            infoCardView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 33),
            infoCardView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            infoCardView.bottomAnchor.constraint(lessThanOrEqualTo: view.bottomAnchor)
        ])
    }
    
    @objc override func backButtonTouched() {
        viewModel.didSelectGoBack()
    }
}
