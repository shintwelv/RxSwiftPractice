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
                ("Debounce", #selector(routeToDebounceVC)),
                ("Throttle", #selector(routeToThrottleVC)),
                ("DistinctUntilChanged", #selector(routeToDistinctUntilChanged)),
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
    
    @objc private func routeToThrottleVC(_ button: UIButton) {
        let vc = ThrottleViewController()
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc private func routeToDistinctUntilChanged(_ button: UIButton) {
        let vc = DistinctUntilChangedViewController()
        self.navigationController?.pushViewController(vc, animated: true)
    }
}
