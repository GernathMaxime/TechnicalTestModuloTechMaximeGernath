//
//  HomeViewModel.swift
//  MaximeGernathModuloTechTest
//
//  Created by Gernath Maxime on 20/04/2023.
//

import Foundation

protocol TableViewProtocol {
    func didReceiveTableData()
}

final class HomeViewModel: ViewModel {
    
    // MARK: - Properties
    var tableViewDelegate: TableViewProtocol?
    let urlString = "http://storage42.com/modulotest/data.json"
    let fetchData = readData()
    var userData: [Device]? = nil
    
    // MARK: - Init
    override init() {
        super.init()
        self.loadUserData()
    }
    
    // MARK: - Actions
    func loadUserData() {
        self.fetchData.loadJson(fromURLString: urlString) { [self] (result) in
            switch result {
            case .success(let data):
                userData = fetchData.parse(jsonData: data)?.devices
                tableViewDelegate?.didReceiveTableData()
            case .failure(let error):
                print(error)
            }
        }
    }
    
}
