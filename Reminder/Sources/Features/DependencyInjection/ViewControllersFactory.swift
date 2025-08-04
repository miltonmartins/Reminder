//
//  ViewControllersFactory.swift
//  Reminder
//
//  Created by Milton Martins on 10/06/25.
//

import UIKit

final class ViewControllersFactory: ViewControllersFactoryProtocol {
    func makeSplashViewController(flowDelegate: SplashFlowDelegate) -> SplashViewController {
        let splashView = SplashView()
        return SplashViewController(
            contentView: splashView,
            flowDelegate: flowDelegate
        )
    }
    
    func makeLoginViewController(flowDelegate: LoginFlowDelegate) -> LoginViewController {
        let loginView = LoginView()
        return LoginViewController(
            contentView: loginView,
            flowDelegate: flowDelegate
        )
    }
    
    func makeHomeViewController(flowDelegate: HomeFlowDelegate) -> HomeViewController {
        let homeView = HomeView()
        return HomeViewController(
            contentView: homeView,
            flowDelegate: flowDelegate
        )
    }
    
    func makeNewReceiptViewController(flowDelegate: NewReceiptFlowDelegate) -> NewReceiptViewController {
        let newReceiptView = NewReceiptView()
        return NewReceiptViewController(
            contentView: newReceiptView,
            flowDelegate: flowDelegate
        )
    }
    
    func makePrescriptionsViewController(flowDelegate: any PrescriptionsFlowDelegate) -> PrescriptionsViewController {
        let prescriptionsView = PrescriptionsView()
        return PrescriptionsViewController(
            contentView: prescriptionsView,
            flowDelegate: flowDelegate
        )
    }
}
