//
//  NewReceiptViewController.swift
//  Reminder
//
//  Created by Milton Martins on 11/06/25.
//
import UIKit

class NewReceiptViewController: UIViewController {
    private let newReceiptView: NewReceiptView
    private let flowDelegate: NewReceiptFlowDelegate
    private let viewModel = NewPrescriptionViewModel()
    
    init(
        contentView: NewReceiptView,
        flowDelegate: NewReceiptFlowDelegate
    ) {
        self.newReceiptView = contentView
        self.flowDelegate = flowDelegate
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupActions()
    }
    
    private func setupView() {
        view.backgroundColor = Colors.GrayScale.gray800
        view.addSubview(newReceiptView)
        setupConstraints()
    }
    
    private func setupConstraints() {
        self.setupContentViewToBounds(contentView: newReceiptView)
    }
    
    private func setupActions() {
        newReceiptView.backButton.addTarget(self, action: #selector(backButtonTapped), for: .touchUpInside)
        newReceiptView.addButton.addTarget(self, action: #selector(addNewPrescriptionTapped), for: .touchUpInside)
    }
    
    @objc
    private func backButtonTapped() {
        self.navigationController?.popViewController(animated: true)
    }
    
    @objc
    private func addNewPrescriptionTapped() {
        viewModel.addPrescription(
            medicine: newReceiptView.medicineInput.getText(),
            time: newReceiptView.timeInput.getText(),
            recurrence: newReceiptView.recurrenceInput.getText(),
            takeNow: false
        )
        self.navigationController?.popViewController(animated: false)
        self.flowDelegate.openPrescriptions()
    }
}
