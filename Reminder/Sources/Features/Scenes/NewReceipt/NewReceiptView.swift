//
//  NewReceiptView.swift
//  Reminder
//
//  Created by Milton Martins on 11/06/25.
//

import UIKit

class NewReceiptView: UIView {
    let backButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "arrow.left"), for: .normal)
        button.tintColor = Colors.GrayScale.gray100
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "new.prescription.title".localized
        label.font = Typography.heading
        label.textColor = Colors.Main.redBase
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let descriptionLabel: UILabel = {
        let label = UILabel()
        label.text = "new.prescription.subtitle".localized
        label.font = Typography.body
        label.textColor = Colors.GrayScale.gray200
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let addButton: UIButton = {
        let button = UIButton()
        button.setTitle("action.add".localized, for: .normal)
        button.titleLabel?.font = Typography.subHeading
        button.setTitleColor(Colors.GrayScale.gray800, for: .normal)
        button.layer.cornerRadius = Metrics.medium
        button.backgroundColor = Colors.Main.redBase
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    let medicineInput: InputView = InputView(
        title: "new.prescription.medicine.label".localized,
        placeholder: "new.prescription.medicine.placeholder".localized
    )
    
    let timeInput: InputView = InputView(
        title: "new.prescription.time.label".localized,
        placeholder: "new.prescription.time.placeholder".localized
    )
    
    let recurrenceInput: InputView = InputView(
        title: "new.prescription.recurrence.label".localized,
        placeholder: "action.select".localized
    )
    
    let checkBox: CheckBoxView = CheckBoxView(title: "new.prescription.take".localized)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView() {
        addSubview(backButton)
        addSubview(titleLabel)
        addSubview(descriptionLabel)
        addSubview(medicineInput)
        addSubview(timeInput)
        addSubview(recurrenceInput)
        addSubview(checkBox)
        addSubview(addButton)
        
        medicineInput.translatesAutoresizingMaskIntoConstraints = false
        
        setupConstraints()
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            backButton.topAnchor.constraint(equalTo: topAnchor, constant: Metrics.medium),
            backButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Metrics.medium),
            backButton.heightAnchor.constraint(equalToConstant: Metrics.icon),
            backButton.widthAnchor.constraint(equalToConstant: Metrics.icon),
            
            titleLabel.topAnchor.constraint(equalTo: backButton.bottomAnchor, constant: Metrics.medium),
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor,constant: Metrics.large),
            
            descriptionLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: Metrics.tiny),
            descriptionLabel.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor),
            descriptionLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -Metrics.large),
            
            medicineInput.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: Metrics.large),
            medicineInput.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Metrics.large),
            medicineInput.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -Metrics.large),
            
            timeInput.topAnchor.constraint(equalTo: medicineInput.bottomAnchor, constant: Metrics.medium),
            timeInput.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Metrics.large),
            timeInput.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -Metrics.large),
            
            recurrenceInput.topAnchor.constraint(equalTo: timeInput.bottomAnchor, constant: Metrics.medium),
            recurrenceInput.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Metrics.large),
            recurrenceInput.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -Metrics.large),
            
            checkBox.topAnchor.constraint(equalTo: recurrenceInput.bottomAnchor, constant: Metrics.medium),
            checkBox.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Metrics.large),
            
            addButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Metrics.large),
            addButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -Metrics.large),
            addButton.heightAnchor.constraint(equalToConstant: Metrics.buttonSize),
            addButton.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -Metrics.large)
        ])
    }
}
