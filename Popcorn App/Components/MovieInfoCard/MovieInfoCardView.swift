//
//  MovieInfoCardView.swift
//  Popcorn App
//
//  Created by Lucas Pereira on 11.08.21.
//

import UIKit

final class MovieInfoCardView: UIView {
    
    private let viewModel: MovieInfoCardViewModel
    private let headerInfoLabel: UILabel = {
       let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = Theme.Font.appFont(ofSize: 12, weight: .regular)
        label.textColor = Theme.Color.gray
        return label
    }()
    private let headerStackView: UIStackView = {
       let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.alignment = .trailing
        stackView.spacing = 19
        return stackView
    }()
    private let divLine: UIView = {
        let div = UIView()
        div.translatesAutoresizingMaskIntoConstraints = false
        div.backgroundColor = Theme.Color.gray
        return div
    }()
    private let contentStackView: UIStackView = {
       let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        return stackView
    }()
    private let overviewLabel: UILabel = {
       let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = Theme.Font.appFont(ofSize: 18, weight: .regular)
        label.numberOfLines = 5
        label.textColor = Theme.Color.gray
        return label
    }()
    private lazy var ratingView = RatingView(ratingValue: viewModel.ratingValue, totalCount: viewModel.ratingTotalCount)
    
    init(viewModel: MovieInfoCardViewModel) {
        self.viewModel = viewModel
        super.init(frame: .zero)
        setupUI()
        setupConstraints()
    }
    
    @available(*, unavailable)
    required init?(coder aDecoder: NSCoder) { return nil }
    
    // MARK: Private API
    
    private func setupUI() {
        backgroundColor = .white
        headerInfoLabel.text = viewModel.headerText
        headerStackView.addArrangedSubview(ratingView)
        headerStackView.addArrangedSubview(headerInfoLabel)
        addSubview(headerStackView)
        addSubview(divLine)
        addSubview(contentStackView)
        contentStackView.addArrangedSubview(overviewLabel)
        overviewLabel.text = viewModel.overview
        
        let rolesStackView = UIStackView()
        rolesStackView.translatesAutoresizingMaskIntoConstraints = false
        rolesStackView.axis = .vertical
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            headerStackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 18),
            headerStackView.topAnchor.constraint(equalTo: topAnchor, constant: 18),
            headerStackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -18),
        ])
        NSLayoutConstraint.activate([
            divLine.topAnchor.constraint(equalTo: headerStackView.bottomAnchor, constant: 8),
            divLine.heightAnchor.constraint(equalToConstant: 1),
            divLine.leadingAnchor.constraint(equalTo: leadingAnchor),
            divLine.trailingAnchor.constraint(equalTo: trailingAnchor)
        ])
        NSLayoutConstraint.activate([
            contentStackView.topAnchor.constraint(equalTo: divLine.bottomAnchor, constant: 8),
            contentStackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 18),
            contentStackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -18),
            contentStackView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -40)
        ])
    }
}
