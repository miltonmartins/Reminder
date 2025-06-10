//
//  LoginViewController.swift
//  Reminder
//
//  Created by Milton Martins on 05/06/25.
//

import Foundation
import UIKit

class LoginViewController: UIViewController {
    let loginView: LoginView
    let loginViewModel = LoginViewModel()
    var handleAreaHeight: CGFloat = 50.0
    public weak var flowDelegate: LoginFlowDelegate?
    
    init(
        contentView: LoginView,
        flowDelegate: LoginFlowDelegate
    ) {
        self.loginView = contentView
        self.flowDelegate = flowDelegate
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    open override func viewDidLoad() {
        super.viewDidLoad()
        
        loginView.delegate = self
        setupUI()
        setupGesture()
        bindViewModel()
    }
    
    private func setupUI() {
        self.view.addSubview(loginView)
        loginView.translatesAutoresizingMaskIntoConstraints = false
        setupConstraints()
    }
    
    private func setupGesture() {
        
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            loginView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            loginView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            loginView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor)
        ])
        
        let heightConstraint = loginView.heightAnchor.constraint(equalTo: self.view.heightAnchor, multiplier: 0.5)
        heightConstraint.isActive = true
    }
    
    private func bindViewModel() {
        loginViewModel.successResult = { [weak self] user in
            self?.presentSaveLoginAlert(userEmail: user)
        }
        
        loginViewModel.errorResult = { [weak self] error in
            self?.presentErrorAlert(error: error)
        }
    }
    
    private func presentSaveLoginAlert(userEmail: String) {
        let alertController = UIAlertController(
            title: "login.saveuser.title".localized,
            message: "login.saveuser.message".localized,
            preferredStyle: .alert
        )
        let saveAction = UIAlertAction(title: "action.yes".localized, style: .default) { _ in
            let user = User(email: userEmail, isUserSaved: true)
            UserDefaultsManager.saveUser(user: user)
            self.flowDelegate?.navigateToHome()
        }
        let cancelAction = UIAlertAction(title: "action.no".localized, style: .cancel) { _ in
            self.flowDelegate?.navigateToHome()
        }
        alertController.addAction(saveAction)
        alertController.addAction(cancelAction)
        self.present(alertController, animated: true)
    }
    
    private func presentErrorAlert(error: String) {
        let alertController = UIAlertController(
            title: "login.error.title".localized,
            message: error,
            preferredStyle: .alert
        )
        
        let retryAction = UIAlertAction(title: "action.retry".localized, style: .default)
        alertController.addAction(retryAction)
        self.present(alertController, animated: true)
    }
    
    private func handlePanGesture(_ gesture: UIPanGestureRecognizer) {
        
    }
    
    func animateShow(completion: (() -> Void)? = nil) {
        self.view.layoutIfNeeded()
        loginView.transform = CGAffineTransform(translationX: 0, y: loginView.frame.height)
        UIView.animate(withDuration: 0.3, animations: {
            self.loginView.transform = .identity
            self.view.layoutIfNeeded()
        }) { _ in
            completion?()
        }
    }
}

extension LoginViewController: LoginViewDelegate {
    func sendLoginData(user: String, password: String) {
        loginViewModel.doAuth(user: user, password: password)
    }
}
