//
//  SearchViewController.swift
//  Popcorn App
//
//  Created by Lucas Pereira on 10.08.21.
//

import UIKit
import Combine

final class SearchViewController: UIViewController {
    
    enum Constants {
        static let focusedFieldValue: CGFloat = 0
        static let notFocusedFieldValue: CGFloat = 235
    }
    
    // MARK: Properties
    
    private let viewModel: SearchViewModel
    private lazy var searchField: MovieSearchField = {
        let field = MovieSearchField()
        field.translatesAutoresizingMaskIntoConstraints = false
        field.delegate = self
        return field
    }()
    private let iconImageView: UIImageView = {
        let view = UIImageView(image: #imageLiteral(resourceName: "App logo Large"))
        view.translatesAutoresizingMaskIntoConstraints = false
        view.contentMode = .scaleAspectFit
        return view
    }()
    private let recentSearchesStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.isHidden = true
        return stackView
    }()
    private lazy var topConstraint = iconImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor,
                                                                        constant: Constants.notFocusedFieldValue)
    private var disposeBag = Set<AnyCancellable>()
    
    // MARK: Initialization
    
    init(viewModel: SearchViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
        setupUI()
        setupContraints()
        setupBindings()
    }
    
    @available(*, unavailable)
    required init?(coder aDecoder: NSCoder) { return nil }
    
    // MARK: Life cycle
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        navigationController?.setNavigationBarHidden(true, animated: false)
    }
    
    // MARK: Private API
    
    private func setupUI() {
        view.backgroundColor = Theme.Color.white
        view.addSubview(searchField)
        view.addSubview(iconImageView)
        view.addSubview(recentSearchesStackView)
    }
    
    private func setupBindings() {
        viewModel.$recentlySearchedMovies.sink { [weak self] items in
            self?.handleRecentlySearchedItems(items)
        }.store(in: &disposeBag)
        
        viewModel.$fetchingErrorMessage.sink { [weak self] message in
            self?.showErrorAlert(with: message)
        }.store(in: &disposeBag)
    }
    
    private func handleRecentlySearchedItems(_ items: [String]) {
        recentSearchesStackView.isHidden = items.isEmpty
        recentSearchesStackView.arrangedSubviews.forEach { $0.removeFromSuperview() }
        items.reversed().forEach { item in
            recentSearchesStackView.addArrangedSubview(
                RecentSearchItemView(searchItem: item,
                                     onSelection: viewModel.submitSearchInput)
            )
        }
    }
    
    private func setupContraints() {
        NSLayoutConstraint.activate([
            iconImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 28),
            topConstraint,
            iconImageView.widthAnchor.constraint(equalToConstant: 93),
            iconImageView.heightAnchor.constraint(equalToConstant: 124),
            
            searchField.topAnchor.constraint(equalTo: iconImageView.bottomAnchor, constant: 44),
            searchField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 23),
            searchField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -23),
            
            recentSearchesStackView.leadingAnchor.constraint(equalTo: searchField.leadingAnchor),
            recentSearchesStackView.trailingAnchor.constraint(equalTo: searchField.trailingAnchor),
            recentSearchesStackView.topAnchor.constraint(equalTo: searchField.bottomAnchor)
        ])
    }
}

// MARK: MovieSearchFieldDelegate

extension SearchViewController: MovieSearchFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        viewModel.searchInputFieldFocused()
        topConstraint.constant = Constants.focusedFieldValue
    }
    
    func textFieldDidChangeSelection(_ textField: UITextField) {
        viewModel.searchInputTextChanged(textField.text)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        guard !viewModel.isFetchingData else { return true }
        recentSearchesStackView.isHidden = true
        viewModel.submitSearchInput(textField.text)
        topConstraint.constant = Constants.notFocusedFieldValue
        return true
    }
}
