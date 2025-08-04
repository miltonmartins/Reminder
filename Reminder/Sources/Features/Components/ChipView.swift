//
//  ChipView.swift
//  Reminder
//
//  Created by Milton Martins on 04/08/25.
//

import UIKit

class ChipView: UIView {
    private lazy var icon: UIImageView = {
        let imageView = UIImageView()
        imageView.tintColor = Colors.GrayScale.gray300
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private lazy var label: UILabel = {
        let label = UILabel()
        label.font = Typography.tag
        label.textColor = Colors.GrayScale.gray100
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    init(icon: String) {
        super.init(frame: .zero)
        translatesAutoresizingMaskIntoConstraints = false
        self.icon.image = UIImage(systemName: icon)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureLabel(label: String) {
        self.label.text = label
    }
    
    private func setupView() {
        backgroundColor = Colors.GrayScale.gray500
        layer.cornerRadius = Metrics.small
        translatesAutoresizingMaskIntoConstraints = false
        addSubview(label)
        addSubview(icon)
        setupConstraints()
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            heightAnchor.constraint(equalToConstant: 28),
            icon.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Metrics.normal),
            icon.heightAnchor.constraint(equalToConstant: Metrics.iconSmall),
            icon.widthAnchor.constraint(equalToConstant: Metrics.iconSmall),
            label.leadingAnchor.constraint(equalTo: icon.trailingAnchor, constant: Metrics.tiny),
            label.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -Metrics.normal),
            icon.centerYAnchor.constraint(equalTo: centerYAnchor),
            label.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])
    }
}
