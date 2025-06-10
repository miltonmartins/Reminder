//
//  Strings+Ext.swift
//  Reminder
//
//  Created by Milton Martins on 06/06/25.
//

import Foundation

extension String {
    var localized: String {
        NSLocalizedString(self, comment: "")
    }
}
