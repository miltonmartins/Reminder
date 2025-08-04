//
//  PrescriptionCell.swift
//  Reminder
//
//  Created by Milton Martins on 05/07/25.
//

import UIKit

class PrescriptionCell: UITableViewCell {
    static let identifier = "PrescriptionCell"
    var onDelete: (() -> Void)? = nil
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.font = Typography.subHeading
        label.textColor = Colors.GrayScale.gray200
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let timeChip: ChipView = {
        let chip = ChipView(icon: "clock")
        chip.translatesAutoresizingMaskIntoConstraints = false
        return chip
    }()
    
    let periodChip: ChipView = {
        let chip = ChipView(icon: "arrow.2.squarepath")
        chip.translatesAutoresizingMaskIntoConstraints = false
        return chip
    }()
    
    let deleteButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "trash"), for: .normal)
        button.tintColor = Colors.Main.redBase
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView() {
        contentView.backgroundColor = Colors.GrayScale.gray700
        contentView.layer.masksToBounds = true
        contentView.layer.cornerRadius = Metrics.small
        
        contentView.addSubview(titleLabel)
        contentView.addSubview(timeChip)
        contentView.addSubview(periodChip)
        contentView.addSubview(deleteButton)
        
        deleteButton.addTarget(self, action: #selector(deleteButtonTapped), for: .touchUpInside)
        setupConstraints()
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: Metrics.normal),
            titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: Metrics.normal),
            titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -Metrics.normal),
            
            timeChip.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: Metrics.small),
            timeChip.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: Metrics.normal),
            timeChip.heightAnchor.constraint(equalToConstant: 28),
            
            periodChip.centerYAnchor.constraint(equalTo: timeChip.centerYAnchor),
            periodChip.leadingAnchor.constraint(equalTo: timeChip.trailingAnchor, constant: Metrics.tiny),
            periodChip.heightAnchor.constraint(equalToConstant: 28),
            
            deleteButton.topAnchor.constraint(equalTo: contentView.topAnchor, constant: Metrics.normal),
            deleteButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -Metrics.normal),
            deleteButton.heightAnchor.constraint(equalToConstant: Metrics.iconSmall),
            deleteButton.widthAnchor.constraint(equalToConstant: Metrics.iconSmall)
        ])
    }
    
    @objc private func deleteButtonTapped() {
        onDelete?()
    }
}
