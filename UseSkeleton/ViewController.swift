//
//  ViewController.swift
//  UseSkeleton
//
//  Created by JeongminKim on 2023/04/26.
//

import UIKit
import Combine
import SkeletonView

enum ViewState {
    case loading
    case content(user: Any?)
    case error
}

protocol ViewStatable where Self: UIViewController {
    var stateSubject: PassthroughSubject<ViewState, Never> { get }
}

class ViewController: UIViewController, ViewStatable {
    
    var cancellables = Set<AnyCancellable>()
    let stateSubject: PassthroughSubject<ViewState, Never> = .init()
    
    private var apiShouldSucceed: Bool = false

    override func viewDidLoad() {
        super.viewDidLoad()
        observe()
        fetchUserProfile()
    }

    private func fetchUserProfile() {
        stateSubject.send(.loading)
        DispatchQueue.main.asyncAfter(deadline: .now() + 3.0) { [unowned self] in
            if apiShouldSucceed {
                stateSubject.send(.content(user: User.mock))
            } else {
                stateSubject.send(.error)
            }
        }
    }
    
    private func observe() {
        stateSubject
            .receive(on: RunLoop.main)
            .sink { [weak self] state in
            self?.updateView(state: state)
        }.store(in: &cancellables)
    }
    
    private func updateView(state: ViewState) {
        view.removeAllSubviews()
        switch state {
        case .loading:
            let loadingView = UserProfileLoadingView()
            loadingView.pinToParent(parent: view)
            loadingView.startAnimating()
        case .content(let value):
            guard let user = value as? User else { fatalError() }
            let contentView = UserProfileContentView()
            contentView.configure(user: user)
            contentView.pinToParent(parent: view)
        case .error:
            let errorView = UserProfileErrorView()
            errorView.pinToParent(parent: view)
            errorView.retryButtonTapPublisher.sink { [weak self] _ in
                self?.apiShouldSucceed = true
                self?.fetchUserProfile()
            }.store(in: &cancellables)
        }
    }
}

