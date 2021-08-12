//
//  MovieListViewController.swift
//  Popcorn App
//
//  Created by Lucas Pereira on 10.08.21.
//

import UIKit

final class MovieListViewController: CustomNavigationViewController {
    
    // MARK: Properties
    
    private let viewModel: MovieListViewModel
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = Theme.Font.appFont(ofSize: 48, weight: .light)
        label.textColor = Theme.Color.white
        return label
    }()
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(MovieCell.self, forCellReuseIdentifier: MovieCell.identifier)
        tableView.separatorStyle = .none
        tableView.rowHeight = UITableView.automaticDimension
        tableView.showsVerticalScrollIndicator = false
        tableView.estimatedRowHeight = 100.0
        tableView.backgroundColor = .clear
        return tableView
    }()
    
    // MARK: Initialization
    
    init(viewModel: MovieListViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
        setupUI()
        setupConstraints()
    }
    
    // MARK: Private API
    
    private func setupUI() {
        showsBackButton = true
        view.backgroundColor = Theme.Color.blue
        view.addSubview(titleLabel)
        view.addSubview(tableView)
        
        titleLabel.text = viewModel.title.uppercased()
    }
    
    private func setupConstraints() {
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: backButton.bottomAnchor, constant: 33),
            titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 40),
            titleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -40),
            titleLabel.heightAnchor.constraint(equalToConstant: 54)
        ])
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 24),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 67),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -29),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    @objc override func backButtonTouched() {
        viewModel.didSelectGoBack()
    }
}

// MARK: UITableViewDataSource

extension MovieListViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.movies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: MovieCell.identifier, for: indexPath)
        let movie = viewModel.movies[indexPath.row]
        (cell as? MovieCell)?.setup(with: .init(movie: movie))
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        viewModel.didSelectMovie(at: indexPath.row)
    }
}
