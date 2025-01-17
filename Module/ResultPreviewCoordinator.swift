//
//  
//  ResultPreviewCoordinator.swift
//  AirPrint
//
//  Created by Danyl Timofeyev on 26.11.2021.
//
//

import Foundation
import UIKit.UINavigationController
import Combine

protocol ResultPreviewCoordinatorProtocol {
   
}

final class ResultPreviewCoordinator: CoordinatorProtocol, ResultPreviewCoordinatorProtocol {
    var navigationController: UINavigationController?
    
    init() {

    }
    deinit {
        Logger.log(String(describing: self), type: .deinited)
    }
    
    func start() {
        let viewModel = ResultPreviewViewModel(coordinator: self)
        let controller = ResultPreviewViewController(viewModel: viewModel)

    }
    
    func end() {

    }
}
