//
//  ViewControllersFactoryProtocol.swift
//  Reminder
//
//  Created by Milton Martins on 10/06/25.
//

protocol ViewControllersFactoryProtocol {
    func makeSplashViewController(flowDelegate: SplashFlowDelegate) -> SplashViewController
    func makeLoginViewController(flowDelegate: LoginFlowDelegate) -> LoginViewController
    func makeHomeViewController(flowDelegate: HomeFlowDelegate) -> HomeViewController
}
