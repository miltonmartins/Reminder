//
//  LoginView.swift
//  Reminder
//
//  Created by Milton Martins on 05/06/25.
//

import Foundation
import UIKit

class LoginView: UIView {
    public weak var delegate: LoginViewDelegate?
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "login.welcome.title".localized
        label.font = Typography.subHeading
        label.textColor = Colors.GrayScale.gray100
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let emailLabel: UILabel = {
        let label = UILabel()
        label.text = "login.email.label".localized
        label.font = Typography.label
        label.textColor = Colors.GrayScale.gray100
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let emailTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "login.email.placeholder".localized
        textField.borderStyle = .roundedRect
        textField.layer.cornerRadius = Metrics.tiny
        textField.textColor = Colors.GrayScale.gray200
        textField.font = Typography.input
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    private let passwordLabel: UILabel = {
        let label = UILabel()
        label.text = "login.password.label".localized
        label.font = Typography.label
        label.textColor = Colors.GrayScale.gray100
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let passwordTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "login.password.placeholder".localized
        textField.borderStyle = .roundedRect
        textField.textColor = Colors.GrayScale.gray200
        textField.font = Typography.input
        textField.layer.cornerRadius = Metrics.tiny
        textField.isSecureTextEntry = true
        textField.translatesAutoresizingMaskIntoConstraints = false
        
        let toggleButton = UIButton(type: .custom)
        toggleButton.setImage(UIImage(systemName: "eye.fill"), for: .normal)
        toggleButton.setImage(UIImage(systemName: "eye.slash.fill"), for: .selected)
        toggleButton.frame = CGRect(x: 0, y: 0, width: Metrics.icon, height: Metrics.icon)
        toggleButton.tintColor = Colors.Main.blueBase
        toggleButton.addTarget(self, action: #selector(togglePasswordVisibility), for: .touchUpInside)
        
        let containerView = UIView(frame: CGRect(x: 0, y: 0, width: Metrics.icon + Metrics.medium, height: Metrics.icon))
        toggleButton.center = containerView.center
        containerView.addSubview(toggleButton)

        textField.rightView = containerView
        textField.rightViewMode = .always
        return textField
    }()
    
    private let loginButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("login.button".localized, for: .normal)
        button.setTitleColor(Colors.GrayScale.gray800, for: .normal)
        button.backgroundColor = Colors.Main.redBase
        button.titleLabel?.font = Typography.subHeading
        button.layer.cornerRadius = Metrics.medium
        button.addTarget(self, action: #selector(loginButtonDidTapped), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        self.backgroundColor = Colors.GrayScale.gray800
        self.layer.cornerRadius = Metrics.medium
        addSubview(titleLabel)
        addSubview(emailLabel)
        addSubview(emailTextField)
        addSubview(passwordLabel)
        addSubview(passwordTextField)
        addSubview(loginButton)
        
        setupConstraints()
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: topAnchor, constant: Metrics.huge),
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Metrics.large),
            
            emailLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: Metrics.large),
            emailLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Metrics.large),
            emailTextField.topAnchor.constraint(equalTo: emailLabel.bottomAnchor, constant: Metrics.small),
            emailTextField.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Metrics.large),
            emailTextField.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -Metrics.large),
            emailTextField.heightAnchor.constraint(equalToConstant: Metrics.inputSize),
            
            passwordLabel.topAnchor.constraint(equalTo: emailTextField.bottomAnchor, constant: Metrics.medium),
            passwordLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Metrics.large),
            passwordTextField.topAnchor.constraint(equalTo: passwordLabel.bottomAnchor, constant: Metrics.small),
            passwordTextField.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Metrics.large),
            passwordTextField.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -Metrics.large),
            passwordTextField.heightAnchor.constraint(equalToConstant: Metrics.inputSize),
            
            loginButton.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -Metrics.huge),
            loginButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Metrics.large),
            loginButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -Metrics.large),
            loginButton.heightAnchor.constraint(equalToConstant: Metrics.buttonSize)
        ])
    }
    
    @objc
    private func togglePasswordVisibility(_ sender: UIButton) {
        sender.isSelected.toggle()
        passwordTextField.isSecureTextEntry.toggle()
    }
    
    @objc
    private func loginButtonDidTapped() {
        let user = emailTextField.text ?? ""
        let password = passwordTextField.text ?? ""
        delegate?.sendLoginData(user: user, password: password)
    }
}
