//
//  ViewController.swift
//  NYCSchools
//
//  Created by emersonsiega on 06/08/23.
//

import UIKit
import Combine

class ViewController: UIViewController {
    private let schoolsViewModel = SchoolsViewModel()
    private var cancellables = Set<AnyCancellable>()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupBinders()
        schoolsViewModel.getSchools()
        
        //TODO: Remove!!
        let title = "schools.title".localized()
        print("localization usage example: \(title)")
    }
    
    private func setupBinders() {
        schoolsViewModel.$schools
            .receive(on: RunLoop.main)
            .sink { schools in
                if case let schools = schools {
                    print("Retrieved \(schools.count) schools")
                }
            }
            .store(in: &cancellables)
        
        schoolsViewModel.$error
            .receive(on: RunLoop.main)
            .sink { [weak self] error in
                if let error = error {
                    let alert = UIAlertController(
                        title: "Error",
                        message: "Could not retrieve schools. \(error.localizedDescription)",
                        preferredStyle: .alert
                    )
                    
                    let action = UIAlertAction(title: "Ok", style: .default)
                    alert.addAction(action)
                    
                    self?.present(alert, animated: true)
                }
            }
            .store(in: &cancellables)
        
        
        
    }
    
}

