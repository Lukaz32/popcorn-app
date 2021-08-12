//
//  PosterImageView.swift
//  Popcorn App
//
//  Created by Lucas Pereira on 11.08.21.
//
import Combine
import UIKit

private let cache = NSCache<NSString, NSData>()

final class MovieImageView: UIView {
    
    enum ImageSize: String {
        case small = "w92"
        case medium = "w185"
        case large = "w500"
        case huge = "w780"
    }
    
    private let activityIndicator = UIActivityIndicatorView()
    private let imageView = UIImageView()
    private var disposeBag = Set<AnyCancellable>()
    private let imageSize: ImageSize
    
    init(size: ImageSize) {
        self.imageSize = size
        super.init(frame: .zero)
        setupUI()
        setupConstraints()
    }
    
    @available(*, unavailable)
    required init?(coder aDecoder: NSCoder) { return nil }
    
    // MARK: Internal API
    
    func loadImage(with path: String?) { // TODO: Extract into VM and add caching support
        guard let posterPath = path else {
            return
        }
        let url = URL(string: "https://image.tmdb.org/t/p/\(imageSize.rawValue)/" + posterPath)!
        if let imageData = cache.object(forKey: url.absoluteString as NSString) as Data? {
            imageView.image = UIImage(data: imageData)
        } else {
            activityIndicator.startAnimating()
            URLSession.shared
                .dataTaskPublisher(for: url)
                .receive(on: RunLoop.main)
                .sink(receiveCompletion: { [weak self] completion in
                    self?.activityIndicator.stopAnimating()
                    switch completion {
                    case .failure:
                        break
                    default: break
                    }
                }, receiveValue: { [weak self] data, _ in
                    self?.imageView.image = UIImage(data: data)
                    cache.setObject(data as NSData, forKey: url.absoluteString as NSString)
                })
                .store(in: &disposeBag)
        }
    }
    
    func clearImage() {
        imageView.image = nil
    }
    
    // MARK: Private API
    
    private func setupUI() {
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        clipsToBounds = true
        addSubview(imageView)
        
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        activityIndicator.hidesWhenStopped = true
        addSubview(activityIndicator)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            imageView.leadingAnchor.constraint(equalTo: leadingAnchor),
            imageView.topAnchor.constraint(equalTo: topAnchor),
            imageView.trailingAnchor.constraint(equalTo: trailingAnchor),
            imageView.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            activityIndicator.centerYAnchor.constraint(equalTo: centerYAnchor),
            activityIndicator.centerXAnchor.constraint(equalTo: centerXAnchor)
        ])
    }
}
