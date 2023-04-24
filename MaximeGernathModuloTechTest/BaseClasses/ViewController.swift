//
//  ViewController.swift
//  MaximeGernathModuloTechTest
//
//  Created by Gernath Maxime on 23/04/2023.
//

import Foundation
import UIKit

class ViewController<T: ViewModel>: UIViewController {

    // MARK: - Properties
    let viewModel: T

    // MARK: - Init
    init(viewModel: T) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    // MARK: - Setup
    //LANG MANA
}
