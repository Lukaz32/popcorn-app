//
//  MovieCell.swift
//  Popcorn App
//
//  Created by Lucas Pereira on 10.08.21.
//

import UIKit

final class MovieCell: UITableViewCell {
    
    static let identifier = "MovieCell"
    
    private var viewModel: MovieCellViewModel?
    private let containerView: UIView = {
       let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = Theme.Color.white
        return view
    }()
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = Theme.Color.gray
        label.font = Theme.Font.appFont(ofSize: 24, weight: .regular)
        return label
    }()
    private let subtitleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = Theme.Color.lightGray
        label.font = Theme.Font.appFont(ofSize: 24, weight: .light)
        return label
    }()
    private let footerLabel: UILabel = {
        let label = UILabel()
        label.textColor = Theme.Color.gray
        label.font = Theme.Font.appFont(ofSize: 8, weight: .light)
        return label
    }()
    private let ratingLabel = UILabel()
    private let ratingValueLabel = UILabel()
    private let posterImageView: MovieImageView = {
       let view = MovieImageView(size: .small)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    private var ratingView: RatingView?
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }
    
    @available(*, unavailable)
    required init?(coder aDecoder: NSCoder) { return nil }
    
    func setup(with viewModel: MovieCellViewModel) {
        self.viewModel = viewModel
        selectionStyle = .none
        titleLabel.text = viewModel.title
        subtitleLabel.text = viewModel.subtitle
        footerLabel.text = viewModel.footer
        posterImageView.loadImage(with: viewModel.posterPath)
        setupRatingView(with: viewModel)
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        posterImageView.clearImage()
        ratingView?.removeFromSuperview()
    }
    
    private func setupRatingView(with viewModel: MovieCellViewModel) {
        ratingView = RatingView(ratingValue: viewModel.ratingValue, totalCount: viewModel.ratingTotalCount)
        if let ratingView = ratingView {
            ratingView.translatesAutoresizingMaskIntoConstraints = false
            containerView.addSubview(ratingView)
            NSLayoutConstraint.activate([
                ratingView.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 13),
                ratingView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -13),
            ])
        }
    }
    
    private func setupUI() {
        backgroundColor = .clear
        addSubview(containerView)
        containerView.addSubview(posterImageView)
        
        NSLayoutConstraint.activate([
            containerView.topAnchor.constraint(equalTo: topAnchor, constant: 12),
            containerView.leadingAnchor.constraint(equalTo: leadingAnchor),
            containerView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -12),
            containerView.trailingAnchor.constraint(equalTo: trailingAnchor)
        ])
        
        NSLayoutConstraint.activate([
            posterImageView.heightAnchor.constraint(equalToConstant: 130),
            posterImageView.widthAnchor.constraint(equalToConstant: 90),
            posterImageView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
            posterImageView.topAnchor.constraint(equalTo: containerView.topAnchor),
            posterImageView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor)
        ])
        
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.translatesAutoresizingMaskIntoConstraints = false
        containerView.addSubview(stackView)
        
        NSLayoutConstraint.activate([
            stackView.leadingAnchor.constraint(equalTo: posterImageView.trailingAnchor, constant: 16),
            stackView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -8),
            stackView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -8)
        ])
        
        stackView.addArrangedSubview(titleLabel)
        stackView.addArrangedSubview(subtitleLabel)
        stackView.addArrangedSubview(footerLabel)
    }
}
