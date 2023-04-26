//
//  UserProfileErrorView.swift
//  UseSkeleton
//
//  Created by JeongminKim on 2023/04/26.
//

import UIKit
import Combine

class UserProfileErrorView: UIView {
    private let retryButtonTapSubject = PassthroughSubject<Void, Never>()
    
    var retryButtonTapPublisher: AnyPublisher<Void, Never> {
        return retryButtonTapSubject.eraseToAnyPublisher()
    }
    
    private let imageView: UIImageView = {
        let image: UIImage? = UIImage(systemName: "ladybug")
        let imageView = UIImageView(image: image)
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private let label: UILabel = {
        let label = UILabel()
        label.text = "Oops! Something went wrong!"
        label.font = .systemFont(ofSize: 16, weight: .medium)
        label.textAlignment = .center
        return label
    }()
    
    private lazy var tryAgainButton: UIButton = {
        let button = UIButton(configuration: .plain())
        button.setTitle("Try again", for: .normal)
        button.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
        return button
    }()
    
    private lazy var stackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [UIView(), imageView, label, tryAgainButton, UIView()])
        stackView.spacing = 12
        stackView.axis = .vertical
        return stackView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func layout() {
        stackView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(stackView)
        
        NSLayoutConstraint.activate([
            stackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 40),
            stackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -40),
            stackView.centerYAnchor.constraint(equalTo: centerYAnchor),
            
            imageView.heightAnchor.constraint(equalToConstant: 40),
            tryAgainButton.heightAnchor.constraint(equalToConstant: 24)
        ])
    }
    
    @objc private func buttonTapped() {
        retryButtonTapSubject.send()
    }
}
