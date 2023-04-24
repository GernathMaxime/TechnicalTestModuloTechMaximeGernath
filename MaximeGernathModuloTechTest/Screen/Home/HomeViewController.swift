//
//  HomeViewController.swift
//  MaximeGernathModuloTechTest
//
//  Created by Gernath Maxime on 20/04/2023.
//

import Foundation
import UIKit

class HomeViewController: ViewController<HomeViewModel> {
    
    // MARK: - Values
    
    // MARK: UI Components
    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = .systemBackground
        tableView.allowsSelection = true
        tableView.register(DeviceCustomCell.self, forCellReuseIdentifier: DeviceCustomCell.identifier)
        return tableView
    }()
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        viewModel.tableViewDelegate = self
        self.setupUI()
        
        self.tableView.delegate = self
        self.tableView.dataSource = self
    }
    
    // MARK: - Setup UI
    private func setupUI() {
        
        self.view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: self.view.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
        ])
    }
}

extension HomeViewController: UITableViewDelegate, UITableViewDataSource, TableViewProtocol, DeviceConfigProtocol {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.userData?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: DeviceCustomCell.identifier, for: indexPath) as? DeviceCustomCell else {
            fatalError("The TableView could not dequeue a DeviceCustomCell in ViewController.")
        }
        
        guard let userData = viewModel.userData else {
            return cell
        }
        cell.configure(with: userData[indexPath.row])
        
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let userData = viewModel.userData else {
            return
        }
        redirectOnTap(userData, indexPath)
    }
    
    private func redirectOnTap(_ userData: [Device], _ indexPath: IndexPath) {
        switch userData[indexPath.row].productType {
        case .heater:
            let vm = HeaterControlPageViewModel(device: userData[indexPath.row])
            let vc = HeaterControlPageViewController(viewModel: vm)
            vc.modalPresentationStyle = .fullScreen
            vm.deviceConfigDelegate = self
            
            self.show(vc, sender: self)
        case .light:
            let vm = LightControlPageViewModel(device: userData[indexPath.row])
            let vc = LightControlPageViewController(viewModel: vm)
            vc.modalPresentationStyle = .fullScreen
            vm.deviceConfigDelegate = self
            
            self.show(vc, sender: self)
        case .rollerShutter:
            let vm = RollerShuttersViewModel(device: userData[indexPath.row])
            let vc = RollerShuttersViewController(viewModel: vm)
            vc.modalPresentationStyle = .fullScreen
            vm.deviceConfigDelegate = self
            
            self.show(vc, sender: self)
        }
    }
    
    func deviceConfigChanged(_ device: Device) {
        viewModel.userData?[device.id - 1] = device
        self.tableView.reloadData()
    }
    
    func didReceiveTableData() {
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
}
