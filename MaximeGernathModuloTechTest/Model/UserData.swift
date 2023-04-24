//
//  UserData.swift
//  MaximeGernathModuloTechTest
//
//  Created by Gernath Maxime on 23/04/2023.
//

import Foundation

// MARK: - UserData
struct UserData: Codable {
    let devices: [Device]
    let user: User
}

// MARK: - Device
struct Device: Codable {
    let id: Int
    let deviceName: String
    var intensity: Int?
    var mode: String?
    let productType: ProductType
    var position, temperature: Int?
}

enum ProductType: String, Codable {
    case heater = "Heater"
    case light = "Light"
    case rollerShutter = "RollerShutter"
}

// MARK: - User
struct User: Codable {
    let firstName, lastName: String
    let address: Address
    let birthDate: Int
}

// MARK: - Address
struct Address: Codable {
    let city: String
    let postalCode: Int
    let street, streetCode, country: String
}
