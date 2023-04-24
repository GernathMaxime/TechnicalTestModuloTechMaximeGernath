//
//  DeviceCustomCell.swift
//  MaximeGernathModuloTechTest
//
//  Created by Gernath Maxime on 21/04/2023.
//

import UIKit

class DeviceCustomCell: UITableViewCell {

    static let identifier = "DeviceCustomCell"

    private let deviceImageView: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFit
        iv.image = UIImage(systemName: "questionmark")
        iv.tintColor = .label
        return iv
    }()
    
    private let DeviceTitle: UILabel = {
        let label = UILabel()
        label.textColor = .label
        label.textAlignment = .left
        label.font = .systemFont(ofSize: DesignSystem.FontSize.subTitle.rawValue, weight: .medium)
        label.text = ""
        return label
    }()
    
    private let DeviceState: UILabel = {
        let label = UILabel()
        label.textColor = .label
        label.textAlignment = .left
        label.font = .systemFont(ofSize: DesignSystem.FontSize.description.rawValue, weight: .light)
        label.text = ""
        return label
    }()
    
    override init (style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func configure(with device: Device) {
        
        switch device.productType {
        case .heater:
            self.deviceImageView.image = UIImage(named: "DeviceHeater\(device.mode!)Icon")
            self.DeviceState.text = device.mode! == "OFF" ? "OFF" : "ON at \(device.temperature!)°C"
        case .light:
            self.deviceImageView.image = UIImage(named: "DeviceLight\(device.mode!)Icon")
            self.DeviceState.text = device.mode! == "OFF" ? "OFF" : "ON at \(device.intensity!)%"
        case .rollerShutter:
            self.deviceImageView.image = UIImage(named: "DeviceRollerShutterIcon")

            rollerShutterUISetUp(device: device)
        }
        
        self.DeviceTitle.text = device.deviceName
    }
    
    private func rollerShutterUISetUp(device: Device) {
        if device.position == 100 {
            self.DeviceState.text = "Closed"
        } else if device.position == 0 {
            self.DeviceState.text = "Opened"
        } else {
            self.DeviceState.text = "In \(device.position!)% position"
        }
    }
    
    private func setupUI() {
        
        self.contentView.addSubview(deviceImageView)
        self.contentView.addSubview(DeviceTitle)
        self.contentView.addSubview(DeviceState)
        
        deviceImageView.translatesAutoresizingMaskIntoConstraints = false
        DeviceTitle.translatesAutoresizingMaskIntoConstraints = false
        DeviceState.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            deviceImageView.topAnchor.constraint(equalTo: self.contentView.layoutMarginsGuide.topAnchor),
            deviceImageView.bottomAnchor.constraint(equalTo: self.contentView.layoutMarginsGuide.bottomAnchor),
            deviceImageView.leadingAnchor.constraint(equalTo: self.contentView.layoutMarginsGuide.leadingAnchor),
            
            deviceImageView.heightAnchor.constraint(equalToConstant: 64),
            deviceImageView.widthAnchor.constraint(equalToConstant: 64),
            
            DeviceTitle.leadingAnchor.constraint(equalTo: self.deviceImageView.trailingAnchor, constant: 16),
            DeviceTitle.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -8),
            DeviceTitle.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 15),
            
            DeviceState.leadingAnchor.constraint(equalTo: self.deviceImageView.trailingAnchor, constant: 16),
            DeviceState.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: 0),
            DeviceState.topAnchor.constraint(equalTo: self.DeviceTitle.bottomAnchor),
            DeviceState.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor),
        ])
    }
}
