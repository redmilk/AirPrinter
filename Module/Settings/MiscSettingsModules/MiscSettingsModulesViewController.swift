//
//  
//  MiscSettingsModulesViewController.swift
//  AirPrint
//
//  Created by Danyl Timofeyev on 16.12.2021.
//
//

import UIKit
import Combine
import WebKit


// MARK: - MiscSettingsModulesViewController

final class MiscSettingsModulesViewController: UIViewController {
    enum State {
        case configure(isPrivacyPolicy: Bool)
    }
        
    @IBOutlet weak var navigationBarExtender: UIView!
    @IBOutlet weak var termsOfUseContainer: UIView!
    @IBOutlet weak var privacyPolicyContainer: UIView!
    @IBOutlet weak var webView: WKWebView!

    private let viewModel: MiscSettingsModulesViewModel
    private var bag = Set<AnyCancellable>()
    
    init(viewModel: MiscSettingsModulesViewModel) {
        self.viewModel = viewModel
        super.init(nibName: String(describing: MiscSettingsModulesViewController.self), bundle: nil)
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    deinit {
        Logger.log(String(describing: self), type: .deinited)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        handleActions()
        configureView()
        viewModel.input.send(.requestState)
    }
}

// MARK: - Internal

private extension MiscSettingsModulesViewController {
    
    func handleActions() {
        viewModel.output.sink(receiveValue: { [weak self] state in
            switch state {
            case .configure(let isPrivacyPolicy):
                self?.privacyPolicyContainer.isHidden = !isPrivacyPolicy
                self?.termsOfUseContainer.isHidden = isPrivacyPolicy
                if isPrivacyPolicy {
                    let req = URLRequest(url: URL(string: "https://google.com")!)
                    self?.webView.load(req)
                    self?.title = "Privacy Policy"
                } else {
                    self?.title = "Terms of Use"
                }
            }
        })
        .store(in: &bag)
    }
    
    func configureView() {
        let textAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        navigationController?.navigationBar.titleTextAttributes = textAttributes
        navigationController?.navigationBar.tintColor = .white
        navigationBarExtender.addCornerRadius(30)
        navigationBarExtender.dropShadow(color: .black, opacity: 0.6, offSet: .zero, radius: 30, scale: true)
        webView.navigationDelegate = self
    }
}

extension MiscSettingsModulesViewController: WKNavigationDelegate, WKUIDelegate {
    
    func webView(_ webView: WKWebView, decidePolicyFor navigationResponse: WKNavigationResponse,
                 decisionHandler: @escaping (WKNavigationResponsePolicy) -> Void) {
        decisionHandler(.allow)
    }
}