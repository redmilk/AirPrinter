//
//  
//  ResultPreviewViewController.swift
//  AirPrint
//
//  Created by Danyl Timofeyev on 26.11.2021.
//
//

import UIKit
import Combine


// MARK: - ResultPreviewViewController

final class ResultPreviewViewController: UIViewController {
    enum State {
        case dummyState
    }
        
    private let viewModel: ResultPreviewViewModel
    private var bag = Set<AnyCancellable>()
    
    init(viewModel: ResultPreviewViewModel) {
        self.viewModel = viewModel
        super.init(nibName: String(describing: ResultPreviewViewController.self), bundle: nil)
        /**
         CONNECT FILE'S OWNER TO SUPERVIEW IN XIB FILE
         CONNECT FILE'S OWNER TO SUPERVIEW IN XIB FILE
         CONNECT FILE'S OWNER TO SUPERVIEW IN XIB FILE
         */
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    deinit {
        Logger.log(String(describing: self), type: .deinited)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        handleStates()
    }
}

// MARK: - Internal

private extension ResultPreviewViewController {
    
    /// Handle ViewModel's states
    func handleStates() {
        viewModel.output.sink(receiveValue: { [weak self] state in
            switch state {
            case .dummyState:
                break
            }
        })
        .store(in: &bag)
    }
}
