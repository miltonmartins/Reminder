//
//  PrescriptionsViewController.swift
//  Reminder
//
//  Created by Milton Martins on 30/06/25.
//

import UIKit

class PrescriptionsViewController: UIViewController {
    private let prescriptionsView: PrescriptionsView
    private let flowDelegate: PrescriptionsFlowDelegate
    private let viewModel = PrescriptionsViewModel()
    private var prescriptions = [Prescription]()
    
    init(
        contentView: PrescriptionsView,
        flowDelegate: PrescriptionsFlowDelegate
    ) {
        self.prescriptionsView = contentView
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
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        fetchData()
    }
    
    private func setupView() {
        view.backgroundColor = Colors.GrayScale.gray800
        view.addSubview(prescriptionsView)
        setupTableView()
        setupConstraints()
    }
    
    private func setupTableView() {
        prescriptionsView.tableView.dataSource = self
        prescriptionsView.tableView.delegate = self
        prescriptionsView.tableView.register(PrescriptionCell.self, forCellReuseIdentifier: PrescriptionCell.identifier)
    }
    
    private func setupConstraints() {
        self.setupContentViewToBounds(contentView: prescriptionsView)
    }
    
    private func fetchData() {
        self.prescriptions = viewModel.getPrescriptions()
        prescriptionsView.tableView.reloadData()
    }
    
    private func setupActions() {
        prescriptionsView.backButton.addTarget(self, action: #selector(backButtonTapped), for: .touchUpInside)
        prescriptionsView.addButton.addTarget(self, action: #selector(addButtonTapped), for: .touchUpInside)
    }
    
    @objc func backButtonTapped() {
        self.navigationController?.popViewController(animated: true)
    }
    
    @objc func addButtonTapped() {
        self.navigationController?.popViewController(animated: false)
        self.flowDelegate.openNewPrescrition()
    }
}

extension PrescriptionsViewController: UITableViewDataSource, UITableViewDelegate {
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: PrescriptionCell.identifier, for: indexPath) as? PrescriptionCell else { return PrescriptionCell() }
        
        let prescription = prescriptions[indexPath.section]
        cell.titleLabel.text = prescription.medicine
        cell.timeChip.configureLabel(label: prescription.time)
        cell.periodChip.configureLabel(label: prescription.recurrence)
        cell.onDelete =  { [weak self] in
            self?.viewModel.deletePrescription(id: prescription.id)
            self?.fetchData()
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return Metrics.normal
    }

    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let spacer = UIView()
        spacer.backgroundColor = .clear
        return spacer
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 90
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return prescriptions.count
    }
}
