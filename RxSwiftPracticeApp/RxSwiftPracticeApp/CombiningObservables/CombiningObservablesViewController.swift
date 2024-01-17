//
//  CombiningObservablesViewController.swift
//  RxSwiftPracticeApp
//
//  Created by siheo on 1/16/24.
//

import UIKit

class CombiningObservablesViewController: ButtonListViewController {
    
    override var buttons: [(String, Selector)] {
        get {
            [
                ("Merge", #selector(routeToMerge)),
                ("Zip", #selector(routeToZip)),
                ("StartWith", #selector(routeToStartWith)),
            ]
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.title = "Combining Observables"
    }
    
    @objc private func routeToMerge(_ button: UIButton) {
        let vc = MergeViewController()
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc private func routeToZip(_ button: UIButton) {
        let vc = ZipViewController()
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc private func routeToStartWith(_ button: UIButton) {
        let vc = StartWithViewController()
        self.navigationController?.pushViewController(vc, animated: true)
    }
}
