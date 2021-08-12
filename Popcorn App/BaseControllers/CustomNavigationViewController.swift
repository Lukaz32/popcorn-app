//
//  UIViewExtensions.swift
//  Popcorn App
//
//  Created by Lucas Pereira on 12.08.21.
//

import UIKit

class CustomNavigationViewController: UIViewController {
    
    lazy var backButton: UIButton = {
        let button = UIButton(type: .custom)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(#imageLiteral(resourceName: "back"), for: .normal)
        button.addTarget(self, action: #selector(backButtonTouched), for: .touchUpInside)
        button.isHidden = true
        return button
    }()
    
    private let iconImageView: UIImageView = {
        let view = UIImageView(image: #imageLiteral(resourceName: "App logo medium"))
        view.translatesAutoresizingMaskIntoConstraints = false
        view.contentMode = .scaleAspectFit
        return view
    }()
    
    var showsBackButton: Bool = false {
        didSet { backButton.isHidden = !showsBackButton }
    }
    
    var showsIcon: Bool = true {
        didSet { iconImageView.isHidden = !showsIcon }
    }
    
    // MARK: Initialization
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nil, bundle: nil)
        setupUI()
        setupConstraints()
    }
    
    @available(*, unavailable)
    required init?(coder aDecoder: NSCoder) { return nil }
    
    // MARK: Private API
    
    private func setupUI() {
        view.backgroundColor = Theme.Color.blue
        view.addSubview(backButton)
        view.addSubview(iconImageView)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            backButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 33),
            backButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 38),
            backButton.widthAnchor.constraint(equalToConstant: 50),
            backButton.heightAnchor.constraint(equalToConstant: 40),
            
            iconImageView.widthAnchor.constraint(equalToConstant: 48),
            iconImageView.heightAnchor.constraint(equalToConstant: 60),
            iconImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 29),
            iconImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -29)
        ])
    }
    
    // To be overridden
    @objc func backButtonTouched() { }
}
