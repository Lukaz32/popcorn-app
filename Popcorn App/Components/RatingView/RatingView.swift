//
//  RatingView.swift
//  Popcorn App
//
//  Created by Lucas Pereira on 12.08.21.
//

import UIKit

final class RatingView: UIView {
    
    private let iconImageView: UIImageView = {
        let view = UIImageView(image: #imageLiteral(resourceName: "Yellow Star"))
        view.translatesAutoresizingMaskIntoConstraints = false
        view.contentMode = .scaleAspectFit
        return view
    }()
    
    private let ratingValueLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = Theme.Font.appFont(ofSize: 16, weight: .bold)
        label.textColor = Theme.Color.black
        return label
    }()
    
    private let ratingTotalLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = Theme.Font.appFont(ofSize: 12, weight: .light)
        label.textColor = Theme.Color.lightGray
        return label
    }()
    
    private let ratingCountLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = Theme.Font.appFont(ofSize: 8, weight: .light)
        label.textColor = Theme.Color.lightGray
        return label
    }()
    
    init(ratingValue: Double, totalCount: Int) {
        super.init(frame: .zero)
        setupUI(ratingValue: ratingValue, totalCount: totalCount)
        setupConstraints()
    }
    
    @available(*, unavailable)
    required init?(coder aDecoder: NSCoder) { return nil }
    
    private func setupUI(ratingValue: Double, totalCount: Int) {
        addSubview(iconImageView)
        addSubview(ratingValueLabel)
        addSubview(ratingTotalLabel)
        addSubview(ratingCountLabel)
        ratingValueLabel.text = String(ratingValue)
        ratingTotalLabel.text = "/10"
        ratingCountLabel.text = String(totalCount)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            iconImageView.topAnchor.constraint(equalTo: topAnchor, constant: 4),
            iconImageView.leadingAnchor.constraint(equalTo: leadingAnchor),
            iconImageView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -4),
            iconImageView.widthAnchor.constraint(equalToConstant: 22),
            iconImageView.heightAnchor.constraint(equalToConstant: 21),
            
            ratingValueLabel.leadingAnchor.constraint(equalTo: iconImageView.trailingAnchor, constant: 4),
            ratingValueLabel.topAnchor.constraint(equalTo: topAnchor,constant: 1),
            ratingValueLabel.bottomAnchor.constraint(equalTo: ratingCountLabel.topAnchor, constant: 2),
            ratingValueLabel.trailingAnchor.constraint(equalTo: ratingTotalLabel.leadingAnchor, constant: -2),
            
            ratingTotalLabel.topAnchor.constraint(equalTo: topAnchor, constant: 2),
            ratingTotalLabel.trailingAnchor.constraint(equalTo: trailingAnchor),
            
            ratingCountLabel.leadingAnchor.constraint(equalTo: ratingValueLabel.leadingAnchor),
            ratingCountLabel.trailingAnchor.constraint(equalTo: trailingAnchor),
            ratingCountLabel.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
}
