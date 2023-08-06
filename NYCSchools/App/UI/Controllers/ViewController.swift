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
        api.getSchools()
    }


}

