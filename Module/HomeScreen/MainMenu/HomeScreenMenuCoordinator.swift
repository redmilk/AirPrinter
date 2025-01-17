//
//  
//  HomeScreenMenuCoordinator.swift
//  AirPrint
//
//  Created by Danyl Timofeyev on 29.11.2021.
//
//

import Foundation
import UIKit.UINavigationController
import Combine

protocol HomeScreenMenuCoordinatorProtocol {
    func endWithSelectedAction(_ action: HomeScreenMenuViewModel.Action)
    func end()
}

final class HomeScreenMenuCoordinator: CoordinatorProtocol, HomeScreenMenuCoordinatorProtocol {
    weak var navigationController: UINavigationController?
    var output = PassthroughSubject<HomeScreenMenuViewModel.Action, Never>()
    
    init(navigationController: UINavigationController?) {
        self.navigationController = navigationController
    }
    deinit {
        Logger.log(String(describing: self), type: .deinited)
    }
    
    func start() {
        let viewModel = HomeScreenMenuViewModel(coordinator: self)
        let controller = HomeScreenMenuViewController(viewModel: viewModel)
        controller.modalPresentationStyle = .custom
        navigationController?.topViewController?.present(controller, animated: false, completion: nil)
    }
    
    func endWithSelectedAction(_ action: HomeScreenMenuViewModel.Action) {
        navigationController?.topViewController?.dismiss(animated: false, completion: { [weak self] in
            self?.output.send(action)
        })
    }
    
    func end() {
        navigationController?.topViewController?.dismiss(animated: true)
    }
}
