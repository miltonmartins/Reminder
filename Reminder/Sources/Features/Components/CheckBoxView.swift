//
//  CheckBoxView.swift
//  Reminder
//
//  Created by Milton Martins on 11/06/25.
//

import UIKit

class CheckBoxView: UIView {
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = Typography.input
        label.textColor = Colors.GrayScale.gray200
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let checkBox: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "square"), for: .normal)
        button.tintColor = Colors.GrayScale.gray400
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    init(title: String) {
        super.init(frame: .zero)
        translatesAutoresizingMaskIntoConstraints = false
        titleLabel.text = title
        
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView() {
        addSubview(titleLabel)
        addSubview(checkBox)
        setupConstraints()
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            checkBox.leadingAnchor.constraint(equalTo: leadingAnchor),
            checkBox.centerYAnchor.constraint(equalTo: centerYAnchor),
            checkBox.widthAnchor.constraint(equalToConstant: Metrics.icon),
            checkBox.heightAnchor.constraint(equalToConstant: Metrics.icon),
            titleLabel.leadingAnchor.constraint(equalTo: checkBox.trailingAnchor, constant: Metrics.small),
            titleLabel.centerYAnchor.constraint(equalTo: checkBox.centerYAnchor)
        ])
    }
}
