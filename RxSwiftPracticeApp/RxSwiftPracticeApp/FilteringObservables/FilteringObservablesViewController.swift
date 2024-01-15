//
//  FilteringObservablesViewController.swift
//  RxSwiftPracticeApp
//
//  Created by siheo on 1/15/24.
//

import UIKit

class FilteringObservablesViewController: ButtonListViewController {
    
    override var buttons: [(String, Selector)] {
        get {
            [
                ("Debounce", #selector(routeToDebounceVC))
            ]
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.title = "Filtering Observables"
    }
    
    @objc private func routeToDebounceVC(_ button: UIButton) {
        let vc = DebounceViewController()
        self.navigationController?.pushViewController(vc, animated: true)
    }
}
