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
            []
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.title = "Filtering Observables"
    }
}
