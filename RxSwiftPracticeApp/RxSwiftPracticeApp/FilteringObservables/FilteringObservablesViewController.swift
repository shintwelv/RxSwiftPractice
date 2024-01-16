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
                ("ElementAt", #selector(routeToElementAt)),
                ("Filter", #selector(routeToFilter)),
                ("Skip", #selector(routeToSkip)),
                ("Take", #selector(routeToTake)),
                ("TakeLast", #selector(routeToTakeLast)),
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
    
    @objc private func routeToElementAt(_ button: UIButton) {
        let vc = ElementAtViewController()
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc private func routeToFilter(_ button: UIButton) {
        let vc = FilterViewController()
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc private func routeToSkip(_ button: UIButton) {
        let vc = SkipViewController()
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc private func routeToTake(_ button: UIButton) {
        let vc = TakeViewController()
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc private func routeToTakeLast(_ button: UIButton) {
        let vc = TakeLastViewController()
        self.navigationController?.pushViewController(vc, animated: true)
    }
}
