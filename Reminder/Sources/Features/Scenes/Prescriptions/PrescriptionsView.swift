//
//  PrescriptionsView.swift
//  Reminder
//
//  Created by Milton Martins on 30/06/25.
//
import UIKit

class PrescriptionsView: UIView {
    lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = .clear
        tableView.separatorStyle = .none
        tableView.scrollIndicatorInsets = .zero
        tableView.allowsSelection = false
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    lazy var backButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "arrow.left"), for: .normal)
        button.tintColor = Colors.GrayScale.gray100
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private lazy var headerBackground: UIView = {
        let view = UIView()
        view.backgroundColor = Colors.GrayScale.gray600
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var addButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "AddButton"), for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = "my.prescriptions.title".localized
        label.font = Typography.heading
        label.textColor = Colors.Main.blueBase
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var descriptionLabel: UILabel = {
        let label = UILabel()
        label.text = "my.prescriptions.description".localized
        label.font = Typography.body
        label.textColor = Colors.GrayScale.gray200
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var contentBackground: UIView = {
        let view = UIView()
        view.backgroundColor = Colors.GrayScale.gray800
        view.layer.cornerRadius = Metrics.medium
        view.layer.masksToBounds = true
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView() {
        backgroundColor = Colors.GrayScale.gray600
        addSubview(contentBackground)
        addSubview(headerBackground)
        headerBackground.addSubview(backButton)
        headerBackground.addSubview(titleLabel)
        headerBackground.addSubview(descriptionLabel)
        headerBackground.addSubview(addButton)
        contentBackground.addSubview(tableView)
        setupConstraints()
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            headerBackground.topAnchor.constraint(equalTo: topAnchor),
            headerBackground.leadingAnchor.constraint(equalTo: leadingAnchor),
            headerBackground.trailingAnchor.constraint(equalTo: trailingAnchor),
            headerBackground.heightAnchor.constraint(equalToConstant: Metrics.headingBackgroundHeight),
            
            backButton.topAnchor.constraint(equalTo: headerBackground.safeAreaLayoutGuide.topAnchor, constant: Metrics.small),
            backButton.leadingAnchor.constraint(equalTo: headerBackground.leadingAnchor, constant: Metrics.medium),
            backButton.heightAnchor.constraint(equalToConstant: Metrics.icon),
            backButton.widthAnchor.constraint(equalToConstant: Metrics.icon),
            
            addButton.topAnchor.constraint(equalTo: headerBackground.safeAreaLayoutGuide.topAnchor, constant: Metrics.small),
            addButton.trailingAnchor.constraint(equalTo: headerBackground.trailingAnchor, constant: -Metrics.medium),
            addButton.heightAnchor.constraint(equalToConstant: Metrics.iconFab),
            addButton.widthAnchor.constraint(equalToConstant: Metrics.iconFab),
            
            titleLabel.topAnchor.constraint(equalTo: backButton.bottomAnchor, constant: Metrics.medium),
            titleLabel.leadingAnchor.constraint(equalTo: headerBackground.leadingAnchor,constant: Metrics.large),
            
            descriptionLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: Metrics.tiny),
            descriptionLabel.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor),
            descriptionLabel.trailingAnchor.constraint(equalTo: headerBackground.trailingAnchor, constant: -Metrics.large),
            
            contentBackground.topAnchor.constraint(equalTo: headerBackground.bottomAnchor, constant: Metrics.medium),
            contentBackground.leadingAnchor.constraint(equalTo: leadingAnchor),
            contentBackground.trailingAnchor.constraint(equalTo: trailingAnchor),
            contentBackground.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            tableView.topAnchor.constraint(equalTo: contentBackground.topAnchor, constant: Metrics.large),
            tableView.bottomAnchor.constraint(equalTo: contentBackground.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: contentBackground.leadingAnchor, constant: Metrics.large),
            tableView.trailingAnchor.constraint(equalTo: contentBackground.trailingAnchor, constant: -Metrics.large)
        ])
    }
}
