//
//  RemindeFlowController.swift
//  Reminder
//
//  Created by Milton Martins on 10/06/25.
//

import Foundation
import UIKit

class RemindeFlowController {
    private var navigationController: UINavigationController?
    private let viewControllerFactory: ViewControllersFactoryProtocol
    
    public init() {
        self.viewControllerFactory = ViewControllersFactory()
    }
    
    func start() -> UINavigationController? {
        let startViewController = viewControllerFactory.makeSplashViewController(flowDelegate: self)
        navigationController = UINavigationController(rootViewController: startViewController)
        return navigationController
    }
}


extension RemindeFlowController: LoginFlowDelegate {
    func navigateToHome() {
        self.navigationController?.dismiss(animated: true)
        let viewController = viewControllerFactory.makeHomeViewController(flowDelegate: self)
        navigationController?.pushViewController(viewController, animated: true)
    }
}

extension RemindeFlowController: SplashFlowDelegate {
    func openLoginBottomSheet() {
        let loginView = viewControllerFactory.makeLoginViewController(flowDelegate: self)
        loginView.modalPresentationStyle = .overCurrentContext
        loginView.modalTransitionStyle = .crossDissolve
        
        navigationController?.present(loginView, animated: false) {
            loginView.animateShow()
        }
    }
    
    func openHome() {
        self.navigationController?.dismiss(animated: true)
        let viewController = viewControllerFactory.makeHomeViewController(flowDelegate: self)
        navigationController?.pushViewController(viewController, animated: true)
    }
}

extension RemindeFlowController: HomeFlowDelegate {
    func openNewPrescrition() {
        self.navigationController?.navigationBar.isHidden = true
        let viewController = viewControllerFactory.makeNewReceiptViewController(flowDelegate: self)
        navigationController?.pushViewController(viewController, animated: true)
    }
    
    func openPrescriptions() {
        self.navigationController?.navigationBar.isHidden = true
        let viewController = viewControllerFactory.makePrescriptionsViewController(flowDelegate: self)
        navigationController?.pushViewController(viewController, animated: true)
    }
    
    func logout() {
        self.navigationController?.popViewController(animated: true)
        self.openLoginBottomSheet()
    }
}

extension RemindeFlowController: NewReceiptFlowDelegate { }

extension RemindeFlowController: PrescriptionsFlowDelegate { }
