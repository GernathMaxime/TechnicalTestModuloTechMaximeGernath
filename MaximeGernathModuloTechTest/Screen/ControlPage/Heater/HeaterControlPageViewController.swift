//
//  HeatersViewController.swift
//  MaximeGernathModuloTechTest
//
//  Created by Gernath Maxime on 24/04/2023.
//

import Foundation
import UIKit

class HeaterControlPageViewController: ViewController<HeaterControlPageViewModel> {
    
    // MARK: - Values
    
    // MARK: - UI Components
    
    private let DeviceImageView: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFit
        iv.image = UIImage(named: "DeviceHeaterONIcon")
        return iv
    }()
    
    private let DeviceNameLabel: UILabel = {
        let label = UILabel()
        label.textColor = .label
        label.textAlignment = .center
        label.font = .systemFont(ofSize: DesignSystem.FontSize.title.rawValue, weight: .medium)
        
        return label
    }()
    
    private let SaveButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .systemBlue
        button.setTitle("Save and Quit", for: UIControl.State.normal)
        button.layer.cornerRadius = 5
        return button
    }()
    
    private let SwitchLabel: UILabel = {
        let label = UILabel()
        label.textColor = .label
        label.textAlignment = .left
        label.text = "Turn On/Off:"
        label.font = .systemFont(ofSize: DesignSystem.FontSize.subTitle.rawValue, weight: .medium)
        
        return label
    }()
    
    private let SwitchButton: UISwitch = {
        let switchButton = UISwitch()
        switchButton.isOn = false
        return switchButton
    }()
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        self.setupUI()
    }
    
    // MARK: - Setup UI
    private func setupUI() {
        
        self.view.addSubview(DeviceImageView)
        self.view.addSubview(DeviceNameLabel)
        self.view.addSubview(SwitchLabel)
        self.view.addSubview(SwitchButton)
        self.view.addSubview(SaveButton)
        
        DeviceImageView.translatesAutoresizingMaskIntoConstraints = false
        DeviceNameLabel.translatesAutoresizingMaskIntoConstraints = false
        SaveButton.translatesAutoresizingMaskIntoConstraints = false
        SwitchLabel.translatesAutoresizingMaskIntoConstraints = false
        SwitchButton.translatesAutoresizingMaskIntoConstraints = false
        
        self.view.backgroundColor = .systemBackground
        DeviceImageView.image = UIImage(named: "DeviceHeater\(viewModel.device.mode!)Icon")
        DeviceNameLabel.text = self.viewModel.device.deviceName
        SwitchButton.isOn = viewModel.device.mode == "ON" ? true : false
        SwitchButton.addTarget(self, action: #selector(self.switchValueDidChange), for: .valueChanged)
        SaveButton.addTarget(self, action: #selector(self.buttonAction), for: .touchUpInside)
        
        NSLayoutConstraint.activate([
            DeviceImageView.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 60),
            DeviceImageView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            DeviceImageView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            DeviceImageView.heightAnchor.constraint(equalToConstant: 200),
            DeviceImageView.widthAnchor.constraint(equalToConstant: 200),
            
            DeviceNameLabel.topAnchor.constraint(equalTo: self.DeviceImageView.bottomAnchor, constant: 30),
            DeviceNameLabel.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 15),
            DeviceNameLabel.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            
            SwitchLabel.topAnchor.constraint(equalTo: self.DeviceNameLabel.bottomAnchor, constant: 30),
            SwitchLabel.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 15),
            SwitchLabel.widthAnchor.constraint(equalToConstant: 150),
            
            SwitchButton.topAnchor.constraint(equalTo: self.DeviceNameLabel.bottomAnchor, constant: 30),
            SwitchButton.leadingAnchor.constraint(equalTo: self.SwitchLabel.trailingAnchor, constant: 15),
            SwitchButton.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -30),
            SwitchButton.heightAnchor.constraint(equalToConstant: 50),
            
            SaveButton.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: -30),
            SaveButton.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 30),
            SaveButton.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -30),
            SaveButton.heightAnchor.constraint(equalToConstant: 50),
            
        ])
    }
    
    @objc func buttonAction(_ sender: UIButton!) {
        dismiss(animated: true)
    }
    
    @objc func switchValueDidChange(_ sender: UISwitch) {
        let mode = sender.isOn == true ? "ON" : "OFF"
        viewModel.device.mode = mode
        DeviceImageView.image = UIImage(named: "DeviceHeater\(mode)Icon")
        viewModel.valueChanged(device: viewModel.device)
    }
}
