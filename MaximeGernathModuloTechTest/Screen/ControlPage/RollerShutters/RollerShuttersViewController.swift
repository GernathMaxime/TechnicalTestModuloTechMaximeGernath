//
//  RollerShuttersViewController.swift
//  MaximeGernathModuloTechTest
//
//  Created by Gernath Maxime on 23/04/2023.
//

import Foundation
import UIKit

class RollerShuttersViewController: ViewController<RollerShuttersViewModel> {
    
    // MARK: - Values
    
    // MARK: - UI Components
    
    private let DeviceImageView: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFit
        iv.image = UIImage(named: "DeviceRollerShutterIcon")
        return iv
    }()
    
    private let DeviceNameLabel: UILabel = {
        let label = UILabel()
        label.textColor = .label
        label.textAlignment = .center
        label.font = .systemFont(ofSize: DesignSystem.FontSize.title.rawValue, weight: .medium)
        
        return label
    }()
    
    private let DeviceStateLabel: UILabel = {
        let label = UILabel()
        label.textColor = .label
        label.textAlignment = .left
        label.font = .systemFont(ofSize: DesignSystem.FontSize.subTitle.rawValue, weight: .medium)
        
        return label
    }()
    
    private let SaveButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .systemBlue
        button.setTitle("Save and Quit", for: UIControl.State.normal)
        button.layer.cornerRadius = 5
        return button
    }()
    
    private let StateSlider: UISlider = {
        let slider = UISlider()
        slider.minimumValue = 0
        slider.maximumValue = 100
        slider.value = 0
        return slider
    }()
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        self.setupUI()
    }
    
    // MARK: - Setup UI
    private func setupUI() {
        
        self.view.addSubview(DeviceImageView)
        self.view.addSubview(DeviceNameLabel)
        self.view.addSubview(DeviceStateLabel)
        self.view.addSubview(StateSlider)
        self.view.addSubview(SaveButton)
        
        DeviceImageView.translatesAutoresizingMaskIntoConstraints = false
        DeviceNameLabel.translatesAutoresizingMaskIntoConstraints = false
        DeviceStateLabel.translatesAutoresizingMaskIntoConstraints = false
        StateSlider.translatesAutoresizingMaskIntoConstraints = false
        SaveButton.translatesAutoresizingMaskIntoConstraints = false
        
        self.view.backgroundColor = .systemBackground
        DeviceNameLabel.text = self.viewModel.device.deviceName
        DeviceStateLabel.text = "Position: \(Int(self.viewModel.device.position!))"
        StateSlider.addTarget(self, action: #selector(self.sliderValueDidChange), for: .valueChanged)
        StateSlider.value = Float(self.viewModel.device.position!)
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
            
            DeviceStateLabel.topAnchor.constraint(equalTo: self.DeviceNameLabel.bottomAnchor, constant: 30),
            DeviceStateLabel.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 15),
            DeviceStateLabel.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            
            StateSlider.topAnchor.constraint(equalTo: self.DeviceStateLabel.bottomAnchor, constant: 16),
            StateSlider.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 30),
            StateSlider.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -30),
            
            SaveButton.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: -30),
            SaveButton.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 30),
            SaveButton.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -30),
            SaveButton.heightAnchor.constraint(equalToConstant: 50),
        ])
    }
    
    @objc func buttonAction(_ sender: UIButton!) {
        dismiss(animated: true)
    }
    
    @objc func sliderValueDidChange(_ sender: UISlider!) {
        sender.value = round(sender.value)
        DeviceStateLabel.text = "Position: \(Int(sender.value))"
        
        viewModel.device.position = Int(sender.value)
        viewModel.valueChanged(device: viewModel.device)
    }
}
