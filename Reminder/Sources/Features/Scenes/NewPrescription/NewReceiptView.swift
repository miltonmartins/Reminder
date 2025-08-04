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
    
    let timePicker: UIDatePicker = {
        let picker = UIDatePicker()
        picker.datePickerMode = .time
        picker.preferredDatePickerStyle = .wheels
        picker.translatesAutoresizingMaskIntoConstraints = false
        return picker
    }()
    
    let recurrencePicker: UIPickerView = {
        let picker = UIPickerView()
        
        picker.translatesAutoresizingMaskIntoConstraints = false
        return picker
    }()
    
    let recurrenceOption = [
        "De hora em hora",
        "2 em 2 horas",
        "4 em 4 horas",
        "6 em 6 horas",
        "12 em 12 horas",
        "Um por dia"
    ]
    
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
        
        setupTimeInput()
        setupRecurrenceInput()
        setupConstraints()
        setupObservers()
        validateInputs()
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            backButton.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: Metrics.small),
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
    
    private func setupTimeInput() {
        timeInput.textField.inputView = timePicker
        timeInput.textField.inputAccessoryView = getToolbarForPicker(action: #selector(didSelectTime))
    }
    
    private func setupRecurrenceInput() {
        recurrenceInput.textField.inputView = recurrencePicker
        recurrenceInput.textField.inputAccessoryView = getToolbarForPicker(action: #selector(didSelectRecurrence))
        recurrencePicker.delegate = self
        recurrencePicker.dataSource = self
    }
    
    private func getToolbarForPicker(action: Selector) -> UIToolbar {
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        
        let doneButton = UIBarButtonItem(
            barButtonSystemItem: .done,
            target: self,
            action: action
        )
        toolbar.setItems([doneButton], animated: true)
        
        return toolbar
    }
    
    private func validateInputs() {
        let isMedicineFilled = !medicineInput.getText().isEmpty
        let isTimeFilled = !timeInput.getText().isEmpty
        let isRecurrenceFilled = !recurrenceInput.getText().isEmpty
        
        addButton.isEnabled = isMedicineFilled && isTimeFilled && isRecurrenceFilled
        addButton.backgroundColor = addButton.isEnabled ? Colors.Main.redBase : Colors.GrayScale.gray500
    }
    
    private func setupObservers() {
        medicineInput.textField.addTarget(self, action: #selector(inputDidChange), for: .editingChanged)
        timeInput.textField.addTarget(self, action: #selector(inputDidChange), for: .editingChanged)
        recurrenceInput.textField.addTarget(self, action: #selector(inputDidChange), for: .editingChanged)
    }
    
    @objc
    private func inputDidChange() {
        validateInputs()
    }
    
    @objc
    private func didSelectRecurrence() {
        let selectRow = recurrencePicker.selectedRow(inComponent: 0)
        recurrenceInput.textField.text = recurrenceOption[selectRow]
        recurrenceInput.textField.resignFirstResponder()
        validateInputs()
    }
    
    @objc
    private func didSelectTime() {
        let formatter = DateFormatter()
        formatter.timeStyle = .short
        timeInput.textField.text = formatter.string(from: timePicker.date)
        timeInput.textField.resignFirstResponder()
        validateInputs()
    }
}

extension NewReceiptView: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return recurrenceOption.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return recurrenceOption[row]
    }
}
