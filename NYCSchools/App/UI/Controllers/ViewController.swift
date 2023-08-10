//
//  ViewController.swift
//  NYCSchools
//
//  Created by emersonsiega on 06/08/23.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        let api: SchoolAPILogic = SchoolAPI()
        api.getSchools { result in
            switch result {
            case .failure(let error):
                print("Error retrieving schools: \(error.localizedDescription)")
            case .success(let schools):
                if let schools = schools {
                    print("found \(schools.count) schools!")
                }
            }
        }
    }


}

