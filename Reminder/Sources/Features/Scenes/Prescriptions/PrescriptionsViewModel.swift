//
//  PrescriptionsViewModel.swift
//  Reminder
//
//  Created by Milton Martins on 04/08/25.
//

class PrescriptionsViewModel {
    func getPrescriptions() -> [Prescription] {
        return DBHelper.shared.getPrescriptions()
    }
    
    func deletePrescription(id: Int) {
        DBHelper.shared.deletePrescription(id: id)
    }
}
