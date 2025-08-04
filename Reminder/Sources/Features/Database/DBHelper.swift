//
//  DBHelper.swift
//  Reminder
//
//  Created by Milton Martins on 12/06/25.
//

import Foundation
import SQLite3

class DBHelper {
    static let shared = DBHelper()
    private var db: OpaquePointer?
    
    private init() {
        openDatabase()
        createTable()
    }
    
    private func openDatabase() {
        let fileURL = try! FileManager.default
            .url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false)
            .appendingPathComponent("reminder.sqlite")
        
        
        if sqlite3_open(fileURL.path, &db) != SQLITE_OK {
            print("Error opening database")
            return
        }
    }
    
    private func createTable() {
        let createTableQuery = """
            CREATE TABLE IF NOT EXISTS Prescriptions (
                id INTEGER PRIMARY KEY AUTOINCREMENT,
                medicine TEXT,
                time TEXT,
                recurrence TEXT,
                takeNow INTEGER
            );
        """
        var statement: OpaquePointer?
        
        if sqlite3_prepare_v2(db, createTableQuery, -1, &statement, nil) == SQLITE_OK {
            if sqlite3_step(statement) != SQLITE_DONE {
                print("Error creating table")
            }
        }
        sqlite3_finalize(statement)
    }
    
    func insertPrescription(medicine: String, time: String, recurrence: String, takeNow: Bool) {
        let insertQuery = "INSERT INTO Prescriptions (medicine, time, recurrence, takeNow) VALUES (?, ?, ?, ?);"
        var statement: OpaquePointer?
        
        if sqlite3_prepare_v2(db, insertQuery, -1, &statement, nil) == SQLITE_OK {
            sqlite3_bind_text(statement, 1, (medicine as NSString).utf8String, -1, nil)
            sqlite3_bind_text(statement, 2, (time as NSString).utf8String, -1, nil)
            sqlite3_bind_text(statement, 3, (recurrence as NSString).utf8String, -1, nil)
            sqlite3_bind_int(statement, 4, takeNow ? 1 : 0)
            
            if sqlite3_step(statement) != SQLITE_DONE {
                print("Error inserting data")
            }
        }
        sqlite3_finalize(statement)
    }
    
    func getPrescriptions() -> [Prescription] {
        var prescriptions: [Prescription] = []
        let query = "SELECT * FROM Prescriptions;"
        var statement: OpaquePointer?
        
        if sqlite3_prepare_v2(db, query, -1, &statement, nil) == SQLITE_OK {
            while sqlite3_step(statement) == SQLITE_ROW {
                prescriptions.append(Prescription(
                    id: Int(sqlite3_column_int(statement, 0)),
                    medicine: String(cString: sqlite3_column_text(statement, 1)),
                    time: String(cString: sqlite3_column_text(statement, 2)),
                    recurrence: String(cString: sqlite3_column_text(statement, 3)),
                    takeNow: Bool(sqlite3_column_int(statement, 4) == 1 ? true: false)
                ))
            }
        }
        sqlite3_finalize(statement)
        return prescriptions
    }
    
    func deletePrescription(id: Int) {
        let query = "DELETE FROM Prescriptions WHERE id = ?;"
        var statement: OpaquePointer?
        
        if sqlite3_prepare_v2(db, query, -1, &statement, nil) == SQLITE_OK {
            sqlite3_bind_int(statement, 1, Int32(id))
        }
        sqlite3_step(statement)
        sqlite3_finalize(statement)
    }
}
