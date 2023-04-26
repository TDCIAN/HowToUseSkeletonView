//
//  UserProfileLoadingView.swift
//  UseSkeleton
//
//  Created by JeongminKim on 2023/04/26.
//

import UIKit
import SkeletonView

class UserProfileLoadingView: UIView {
    private lazy var profileView = buildAnimatedViews()
    private lazy var nameView = buildAnimatedViews()
    private lazy var emailView = buildAnimatedViews()
    
    private lazy var stackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [
            buildAnimatedViews(),
            buildAnimatedViews(),
            buildAnimatedViews()
        ])
        stackView.distribution = .fillEqually
        stackView.spacing = 12
        stackView.axis = .horizontal
        stackView.isSkeletonable = true
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
        [profileView, nameView, emailView, stackView].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            addSubview($0)
        }
        
        NSLayoutConstraint.activate([
            profileView.topAnchor.constraint(equalTo: topAnchor, constant: 100),
            profileView.centerXAnchor.constraint(equalTo: centerXAnchor),
            profileView.heightAnchor.constraint(equalToConstant: 80),
            profileView.widthAnchor.constraint(equalToConstant: 80),
            
            nameView.heightAnchor.constraint(equalToConstant: 24),
            nameView.widthAnchor.constraint(equalToConstant: 200),
            nameView.centerXAnchor.constraint(equalTo: centerXAnchor),
            nameView.topAnchor.constraint(equalTo: profileView.bottomAnchor, constant: 24),
            
            emailView.heightAnchor.constraint(equalToConstant: 24),
            emailView.widthAnchor.constraint(equalToConstant: 200),
            emailView.centerXAnchor.constraint(equalTo: centerXAnchor),
            emailView.topAnchor.constraint(equalTo: nameView.bottomAnchor, constant: 8),
            
            stackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 24),
            stackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -24),
            stackView.topAnchor.constraint(equalTo: emailView.bottomAnchor, constant: 40),
            stackView.heightAnchor.constraint(equalToConstant: 100)
        ])
        
        profileView.layer.cornerRadius = 40
        profileView.layer.masksToBounds = true
    }
    
    func startAnimating() {
        stackView.showAnimatedGradientSkeleton()
        
        [profileView, nameView, emailView].forEach {
            $0.showAnimatedGradientSkeleton()
        }
    }
    
    private func buildAnimatedViews() -> UIView {
        let view = UIView()
        view.backgroundColor = .systemGray6
        view.isSkeletonable = true
        return view
    }
}

