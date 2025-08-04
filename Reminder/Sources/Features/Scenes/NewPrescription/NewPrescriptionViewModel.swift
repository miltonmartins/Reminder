//
//  NewPrescriptionViewModel.swift
//  Reminder
//
//  Created by Milton Martins on 12/06/25.
//

class NewPrescriptionViewModel {
    func addPrescription(medicine: String, time: String, recurrence: String, takeNow: Bool) {
        DBHelper.shared.insertPrescription(medicine: medicine, time: time, recurrence: recurrence, takeNow: takeNow)
    }
}
