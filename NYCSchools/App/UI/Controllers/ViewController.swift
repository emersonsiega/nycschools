//
//  ViewController.swift
//  NYCSchools
//
//  Created by emersonsiega on 06/08/23.
//

import UIKit

class ViewController: UIViewController {
    private let schoolsViewModel = SchoolsViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        schoolsViewModel.getSchools { [weak self] schools, error in
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
            
            if let schools = schools {
                print("Retrieved \(schools.count) schools")
            }
        }
    }

}

