//
//  InputView.swift
//  Reminder
//
//  Created by Milton Martins on 11/06/25.
//
import UIKit

public class InputView: UIView {
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = Typography.label
        label.textColor = Colors.GrayScale.gray100
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
     let textField: UITextField = {
        let textField = UITextField()
        textField.font = Typography.input
        textField.textColor = Colors.GrayScale.gray100
        textField.borderStyle = .roundedRect
        textField.backgroundColor = Colors.GrayScale.gray800
        textField.layer.borderWidth = Metrics.strokeWidth
        textField.layer.borderColor = Colors.GrayScale.gray400.cgColor
        textField.layer.cornerRadius = Metrics.tiny
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    init(title: String, placeholder: String) {
        super.init(frame: .zero)
        translatesAutoresizingMaskIntoConstraints = false
        titleLabel.text = title
        configurePlaceholder(placeholder: placeholder)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configurePlaceholder(placeholder: String) {
        textField.attributedPlaceholder = NSAttributedString(
            string: placeholder,
            attributes: [
                .foregroundColor: Colors.GrayScale.gray200
            ]
        )
    }
    
    private func setupView() {
        addSubview(titleLabel)
        addSubview(textField)
        
        setupConstraints()
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            heightAnchor.constraint(equalToConstant: 85),
            titleLabel.topAnchor.constraint(equalTo: topAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
            textField.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: Metrics.small),
            textField.leadingAnchor.constraint(equalTo: leadingAnchor),
            textField.trailingAnchor.constraint(equalTo: trailingAnchor),
            textField.heightAnchor.constraint(equalToConstant: Metrics.inputSize)
        ])
    }
    
    func getText() -> String {
        return textField.text ?? ""
    }
}
