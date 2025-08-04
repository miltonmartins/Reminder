//
//  HomeView.swift
//  Reminder
//
//  Created by Milton Martins on 10/06/25.
//

import UIKit

class HomeView: UIView {
    weak public var delegate: HomeViewDelegate?
    
    let profileBackground: UIView = {
        let view = UIView()
        view.backgroundColor = Colors.GrayScale.gray600
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let contentBackground: UIView = {
        let view = UIView()
        view.backgroundColor = Colors.GrayScale.gray800
        view.layer.cornerRadius = Metrics.medium
        view.layer.masksToBounds = true
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let profileImage: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.isUserInteractionEnabled = true
        imageView.image = UIImage(systemName: "person.circle.fill")
        imageView.layer.cornerRadius = Metrics.avatarIcon / 2
        imageView.layer.masksToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    let welcomeLabel: UILabel = {
        let label = UILabel()
        label.font = Typography.input
        label.textColor = Colors.GrayScale.gray200
        label.text = "home.welcome".localized
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let nameTextField: UITextField = {
        let textField = UITextField()
        textField.font = Typography.heading
        textField.textColor = Colors.GrayScale.gray100
        textField.returnKeyType = .done
        textField.placeholder = "Insert your name"
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    let prescriptionsButton: ButtonHomeView = {
        let button = ButtonHomeView(
            icon: UIImage(named: "Paper"),
            title: "home.my.prescriptions".localized,
            description: "home.my.prescriptions.description".localized
        )
        return button
    }()
    
    let newPrescriptionButton: ButtonHomeView = {
        let button = ButtonHomeView(
            icon: UIImage(named: "Pills"),
            title: "home.new.prescription".localized,
            description: "home.new.prescription.description".localized
        )
        return button
    }()
    
    let feedbackButton: UIButton = {
        let button = UIButton()
        button.setTitle("home.feedback.button".localized, for: .normal)
        button.setTitleColor(Colors.GrayScale.gray800, for: .normal)
        button.titleLabel?.font = Typography.subHeading
        button.layer.cornerRadius = Metrics.medium
        button.backgroundColor = Colors.GrayScale.gray100
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
        setupTextField()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        addSubview(profileBackground)
        profileBackground.addSubview(profileImage)
        profileBackground.addSubview(welcomeLabel)
        profileBackground.addSubview(nameTextField)
        
        addSubview(contentBackground)
        contentBackground.addSubview(feedbackButton)
        contentBackground.addSubview(prescriptionsButton)
        contentBackground.addSubview(newPrescriptionButton)
        
        setupConstraints()
        setupImageGesture()
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            profileBackground.topAnchor.constraint(equalTo: topAnchor),
            profileBackground.leadingAnchor.constraint(equalTo: leadingAnchor),
            profileBackground.trailingAnchor.constraint(equalTo: trailingAnchor),
            profileBackground.heightAnchor.constraint(equalToConstant: Metrics.headingBackgroundHeight),
            
            profileImage.topAnchor.constraint(equalTo: profileBackground.safeAreaLayoutGuide.topAnchor),
            profileImage.leadingAnchor.constraint(equalTo: profileBackground.leadingAnchor, constant: Metrics.large),
            profileImage.heightAnchor.constraint(equalToConstant: Metrics.avatarIcon),
            profileImage.widthAnchor.constraint(equalToConstant: Metrics.avatarIcon),
            
            welcomeLabel.topAnchor.constraint(equalTo: profileImage.bottomAnchor, constant: Metrics.small),
            welcomeLabel.leadingAnchor.constraint(equalTo: profileImage.leadingAnchor),
            
            nameTextField.topAnchor.constraint(equalTo: welcomeLabel.bottomAnchor, constant: Metrics.litte),
            nameTextField.leadingAnchor.constraint(equalTo: profileImage.leadingAnchor),
            
            contentBackground.topAnchor.constraint(equalTo: profileBackground.bottomAnchor),
            contentBackground.bottomAnchor.constraint(equalTo: bottomAnchor),
            contentBackground.leadingAnchor.constraint(equalTo: leadingAnchor),
            contentBackground.trailingAnchor.constraint(equalTo: trailingAnchor),
            
            feedbackButton.bottomAnchor.constraint(equalTo: contentBackground.bottomAnchor, constant: -Metrics.medium),
            feedbackButton.leadingAnchor.constraint(equalTo: contentBackground.leadingAnchor, constant: Metrics.large),
            feedbackButton.trailingAnchor.constraint(equalTo: contentBackground.trailingAnchor, constant: -Metrics.large),
            feedbackButton.heightAnchor.constraint(equalToConstant: Metrics.buttonSize),
            
            prescriptionsButton.topAnchor.constraint(equalTo: contentBackground.topAnchor, constant: Metrics.huge),
            prescriptionsButton.leadingAnchor.constraint(equalTo: contentBackground.leadingAnchor, constant: Metrics.large),
            prescriptionsButton.trailingAnchor.constraint(equalTo: contentBackground.trailingAnchor, constant: -Metrics.large),
            
            newPrescriptionButton.topAnchor.constraint(equalTo: prescriptionsButton.bottomAnchor, constant: Metrics.small),
            newPrescriptionButton.leadingAnchor.constraint(equalTo: prescriptionsButton.leadingAnchor),
            newPrescriptionButton.trailingAnchor.constraint(equalTo: prescriptionsButton.trailingAnchor)
        ])
    }
    
    private func setupTextField() {
        nameTextField.addTarget(
            self,
            action: #selector(nameTextFieldDidEndEditing),
            for: .editingDidEnd
        )
        nameTextField.delegate = self
    }
    
    private func setupImageGesture() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(profileImageTapped))
        profileImage.addGestureRecognizer(tapGesture)
    }
    
    @objc
    private func profileImageTapped() {
        delegate?.didTapProfileImage()
    }
    
    @objc
    private func nameTextFieldDidEndEditing() {
        let username = nameTextField.text ?? ""
        UserDefaultsManager.saveUserName(userName: username)
    }
}

extension HomeView: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
