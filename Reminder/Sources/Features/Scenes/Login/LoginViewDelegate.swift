//
//  LoginViewDelegate.swift
//  Reminder
//
//  Created by Milton Martins on 09/06/25.
//
import Foundation

protocol LoginViewDelegate: AnyObject {
    func sendLoginData(user: String, password: String)
}
