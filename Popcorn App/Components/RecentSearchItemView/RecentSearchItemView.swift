//
//  RecentSearchItemView.swift
//  Popcorn App
//
//  Created by Lucas Pereira on 12.08.21.
//

import UIKit

final class RecentSearchItemView: UIView {
    
    private let searchItem: String
    private let onSelection: (_ searchItem: String) -> Void
    private let itemLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = Theme.Font.appFont(ofSize: 12, weight: .regular)
        return label
    }()
    private lazy var button: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(buttonTouched), for: .touchUpInside)
        return button
    }()
    
    init(searchItem: String, onSelection: @escaping (_ searchItem: String) -> Void) {
        self.searchItem = searchItem
        self.onSelection = onSelection
        super.init(frame: .zero)
        setupUI()
        setupConstraints()
    }
    
    @available(*, unavailable)
    required init?(coder aDecoder: NSCoder) { return nil }
    
    private func setupUI() {
        addSubview(itemLabel)
        addSubview(button)
        itemLabel.text = searchItem
        itemLabel.sizeToFit()
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            itemLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
            itemLabel.topAnchor.constraint(equalTo: topAnchor),
            itemLabel.trailingAnchor.constraint(equalTo: trailingAnchor),
            itemLabel.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            button.leadingAnchor.constraint(equalTo: leadingAnchor),
            button.topAnchor.constraint(equalTo: topAnchor),
            button.trailingAnchor.constraint(equalTo: trailingAnchor),
            button.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
    
    @objc private func buttonTouched() {
        onSelection(searchItem)
    }
}
