//
//  MovieSearchField.swift
//  Popcorn App
//
//  Created by Lucas Pereira on 11.08.21.
//

import UIKit

protocol MovieSearchFieldDelegate: AnyObject {
    func textFieldDidBeginEditing(_ textField: UITextField)
    func textFieldDidChangeSelection(_ textField: UITextField)
    func textFieldShouldReturn(_ textField: UITextField) -> Bool
}

final class MovieSearchField: UIView {
    
    private lazy var searchField: UITextField = {
        let field = UITextField()
        field.translatesAutoresizingMaskIntoConstraints = false
        field.returnKeyType = .search
        field.font = Theme.Font.appFont(ofSize: 48, weight: .bold)
        field.placeholder = "the movie"
        field.delegate = self
        field.autocorrectionType = .no
        return field
    }()
    
    private let prefixLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = Theme.Font.appFont(ofSize: 48, weight: .bold)
        label.text = "Find"
        return label
    }()
    
    private let divLine: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = Theme.Color.black
        return view
    }()
    
    private lazy var searchButton: UIButton = {
        let button = UIButton(type: .custom)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(#imageLiteral(resourceName: "search"), for: .normal)
        button.tintColor = Theme.Color.gray
        button.addTarget(self, action: #selector(searchButtonTouched), for: .touchUpInside)
        return button
    }()
    
    weak var delegate: MovieSearchFieldDelegate?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
        setupContraints()
    }
    
    @available(*, unavailable)
    required init?(coder aDecoder: NSCoder) { return nil }
    
    // MARK: Private API
    
    private func setupUI() {
        addSubview(prefixLabel)
        addSubview(searchField)
        addSubview(divLine)
        addSubview(searchButton)
    }
    
    private func setupContraints() {
        NSLayoutConstraint.activate([
            prefixLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
            prefixLabel.topAnchor.constraint(equalTo: topAnchor),
            prefixLabel.bottomAnchor.constraint(equalTo: divLine.topAnchor, constant: -6)
        ])
        
        NSLayoutConstraint.activate([
            divLine.leadingAnchor.constraint(equalTo: leadingAnchor),
            divLine.trailingAnchor.constraint(equalTo: trailingAnchor),
            divLine.bottomAnchor.constraint(equalTo: bottomAnchor),
            divLine.heightAnchor.constraint(equalToConstant: 1)
        ])
        
        NSLayoutConstraint.activate([
            searchField.leadingAnchor.constraint(equalTo: prefixLabel.trailingAnchor, constant: 8),
            searchField.bottomAnchor.constraint(equalTo: prefixLabel.bottomAnchor),
            searchField.trailingAnchor.constraint(lessThanOrEqualTo: searchButton.leadingAnchor)
        ])
        
        NSLayoutConstraint.activate([
            searchButton.widthAnchor.constraint(equalToConstant: 34),
            searchButton.heightAnchor.constraint(equalToConstant: 36),
            searchButton.trailingAnchor.constraint(equalTo: trailingAnchor),
            searchButton.centerYAnchor.constraint(equalTo: searchField.centerYAnchor, constant: 6)
        ])
    }
    
    @objc private func searchButtonTouched() {
        _ = delegate?.textFieldShouldReturn(searchField)
        searchField.resignFirstResponder()
    }
}

// MARK: UITextFieldDelegate

extension MovieSearchField: UITextFieldDelegate {
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        delegate?.textFieldDidBeginEditing(textField)
    }
    
    func textFieldDidChangeSelection(_ textField: UITextField) {
        delegate?.textFieldDidChangeSelection(textField)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        _ = delegate?.textFieldShouldReturn(textField)
        textField.resignFirstResponder()
        return true
    }
}
