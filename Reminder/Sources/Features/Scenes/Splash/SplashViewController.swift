//
//  SplashViewController.swift
//  Reminder
//
//  Created by Milton Martins on 05/06/25.
//

import Foundation
import UIKit

class SplashViewController: UIViewController {
    let contentView: SplashView
    public weak var flowDelegate: SplashFlowDelegate?
    
    init(
        contentView: SplashView,
        flowDelegate: SplashFlowDelegate
    ) {
        self.contentView = contentView
        self.flowDelegate = flowDelegate
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupGesture()
        startBreathingAnimation()
        setup()
    }
    
    private func decideNavigationFlow() {
        if let user = UserDefaultsManager.getUser(), user.isUserSaved {
            flowDelegate?.openHome()
        } else {
            showLoginView()
        }
    }
    
    private func setup() {
        self.view.backgroundColor = Colors.Main.redBase
        self.view.addSubview(contentView)
        self.navigationController?.navigationBar.isHidden = true
        setupConstraints()
        setupGesture()
    }
    
    private func setupConstraints() {
        setupContentViewToBounds(contentView: contentView)
    }
    
    private func setupGesture() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(showLoginView))
        self.view.addGestureRecognizer(tapGesture)
    }
    
    @objc
    private func showLoginView() {
        flowDelegate?.openLoginBottomSheet()
        animateLogoUp()
    }
}

extension SplashViewController {
    private func startBreathingAnimation() {
        UIView.animate(
            withDuration: 1.5,
            delay: 0.0,
            animations: {
                self.contentView.logoImageView.transform = CGAffineTransform(scaleX: 1.1, y: 1.1)
            },
            completion: { _ in
                self.decideNavigationFlow()
            }
        )
    }
    
    private func animateLogoUp() {
        UIView.animate(
            withDuration: 0.7,
            delay: 0.0,
            options: [.curveEaseOut],
            animations: {
                self.contentView.logoImageView.transform = self.contentView.logoImageView.transform.translatedBy(x: 0, y: -150)
            }
        )
    }
}
