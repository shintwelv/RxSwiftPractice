//
//  MainViewController.swift
//  RxSwiftPracticeApp
//
//  Created by siheo on 1/15/24.
//

import UIKit

class MainViewController: ButtonListViewController {

    override var buttons: [(String, Selector)] {
        get {
            [
                ("FilteringObservables", #selector(routeToFilteringObservables))
            ]
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.title = "Main"
    }
    
    @objc private func routeToFilteringObservables(_ button: UIButton) {
        let vc = FilteringObservablesViewController()
        self.navigationController?.pushViewController(vc, animated: true)
    }
}
