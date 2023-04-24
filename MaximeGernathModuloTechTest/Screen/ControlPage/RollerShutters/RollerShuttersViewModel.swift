//
//  RollerShuttersViewModel.swift
//  MaximeGernathModuloTechTest
//
//  Created by Gernath Maxime on 23/04/2023.
//

import Foundation

final class RollerShuttersViewModel: ViewModel {
    
    // MARK: - Properties
    var deviceConfigDelegate: DeviceConfigProtocol?
    var device: Device
    
    // MARK: - Init
    init(device: Device) {
        self.device = device
    }
    
    // MARK: - Actions
    func valueChanged(device: Device) {
        deviceConfigDelegate?.deviceConfigChanged(device)
    }
}
